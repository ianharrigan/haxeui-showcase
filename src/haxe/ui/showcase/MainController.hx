package haxe.ui.showcase;

import flash.events.Event;
import haxe.ui.richtext.Code;
import haxe.ui.showcase.util.Prefs;
import haxe.ui.showcase.util.XPathUtil;
import haxe.ui.showcase.views.AbsoluteLayout;
import haxe.ui.showcase.views.Accordions;
import haxe.ui.showcase.views.BoxLayout;
import haxe.ui.showcase.views.BusyPopup;
import haxe.ui.showcase.views.Buttons;
import haxe.ui.showcase.views.CheckBoxes;
import haxe.ui.showcase.views.CustomPopup;
import haxe.ui.showcase.views.CalendarPopup;
import haxe.ui.showcase.views.HContinuousLayout;
import haxe.ui.showcase.views.DateSelectors;
import haxe.ui.showcase.views.GridLayout;
import haxe.ui.showcase.views.HorizontalLayout;
import haxe.ui.showcase.views.Images;
import haxe.ui.showcase.views.ListPopup;
import haxe.ui.showcase.views.ListSelectors;
import haxe.ui.showcase.views.ListViews;
import haxe.ui.showcase.views.OptionBoxes;
import haxe.ui.showcase.views.HProgressBars;
import haxe.ui.showcase.views.HScrollBars;
import haxe.ui.showcase.views.ScrollViews;
import haxe.ui.showcase.views.SimplePopup;
import haxe.ui.showcase.views.HSliders;
import haxe.ui.showcase.views.TextFields;
import haxe.ui.showcase.views.TextInputs;
import haxe.ui.showcase.views.Todo;
import haxe.ui.showcase.views.VContinuousLayout;
import haxe.ui.showcase.views.VerticalLayout;
import haxe.ui.showcase.views.VProgressBars;
import haxe.ui.showcase.views.VScrollBars;
import haxe.ui.showcase.views.VSliders;
import haxe.ui.toolkit.containers.Accordion;
import haxe.ui.toolkit.containers.ContinuousHBox;
import haxe.ui.toolkit.containers.Grid;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.containers.TabView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Menu;
import haxe.ui.toolkit.controls.MenuButton;
import haxe.ui.toolkit.controls.MenuItem;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.Controller;
import haxe.ui.toolkit.core.PopupManager.PopupButton;
import haxe.ui.toolkit.core.renderers.ItemRenderer;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.MenuEvent;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.resources.ResourceManager;
import xpath.xml.XPathXml;

class MainController extends XMLController {
	private var _loadResources:Bool = false;
	private var _groups:Map<String, ListView>;

	private var theme:ListSelector;
	
	public function new() {
		super("ui/main.xml");

		_loadResources = Prefs.showSources == "yes";
		
		theme = getComponentAs("theme", ListSelector);
		var themeName:String = "Default";
		if (Prefs.theme == "default") {
			themeName = "Default Theme";
		} else if (Prefs.theme == "gradient") {
			themeName = "Gradient Theme";
		}
		theme.text = themeName;
		theme.onChange = function(e) {
			Prefs.theme = theme.selectedItems[0].data.id;
			showSimplePopup("The theme has been changed. You must restart (or refresh) the application to use the new theme.");
		};
		
		attachEvent("menuApplication", MenuEvent.SELECT, function(e:MenuEvent) {
			switch (e.menuItem.id) {
				case "menuSettings":
					popupSettings();
				case "menuAbout":
					popupAbout();
				default:
			}
		});
		
		attachEvent("menuView", MenuEvent.SELECT, function(e:MenuEvent) {
			var controller = e.menuItem.userData;
			var name = e.menuItem.id;
			showView(controller);
		});
		
		_groups = new Map<String, ListView>();
		buildMenu();
		loadViews();
		var views:Accordion = getComponentAs("views", Accordion);
		#if !html5
		//views.selectedIndex = 0;
		#end
		views.addEventListener(UIEvent.CHANGE, _onViewsChange);
	}

	private function buildMenu():Void {
		var menuView:MenuButton = getComponentAs("menuView", MenuButton);
		
		var menu:Menu = new Menu();
		menuView.addChild(menu);
		
		var groupMenus:Map<String, Menu> = new Map<String, Menu>();
		var xml:Xml = ResourceManager.instance.getXML("data/views.xml");
		var a:Array<Xml> = XPathUtil.getXPathNodes(xml, "/views/view");
		for (item in a) {
			var group:String = XPathUtil.getXPathValue(item, "group/text()");
			var name:String = XPathUtil.getXPathValue(item, "name/text()");
			var controller:String = XPathUtil.getXPathValue(item, "controller/text()");
			
			var groupMenu:Menu = groupMenus.get(group);
			if (groupMenu == null) {
				groupMenu = new Menu();
				groupMenu.text = group;
				menu.addChild(groupMenu);
				groupMenus.set(group, groupMenu);
			}
			
			var item:MenuItem = new MenuItem();
			item.text = name;
			item.userData = controller;
			item.id = name;
			groupMenu.addChild(item);
		}
	}
	
	private function loadViews():Void {
		var views:Accordion = getComponentAs("views", Accordion);
		var xml:Xml = ResourceManager.instance.getXML("data/views.xml");
		var a:Array<Xml> = XPathUtil.getXPathNodes(xml, "/views/view");
		
		for (item in a) {
			var group:String = XPathUtil.getXPathValue(item, "group/text()");
			var name:String = XPathUtil.getXPathValue(item, "name/text()");
			var icon:String = XPathUtil.getXPathValue(item, "icon/text()");
			var controller:String = XPathUtil.getXPathValue(item, "controller/text()");
			var resources:Array<Xml> = XPathUtil.getXPathNodes(item, "resources/resource");
			for (r in resources) {
				var resType:String = XPathUtil.getXPathValue(r, "@type");
				var res:String = XPathUtil.getXPathValue(r, "text()");
			}
			
			var list:ListView = _groups.get(group);
			if (list == null) {
				var vbox:VBox = new VBox();
				vbox.percentWidth = vbox.percentHeight = 100;
				vbox.text = group;
				
				list = new ListView();
				if (Prefs.theme == "gradient") {
					list.showVScroll = false;
				}
				list.percentWidth = list.percentHeight = 100;
				list.addEventListener(UIEvent.CHANGE, _onViewItemChange);
				vbox.addChild(list);
				_groups.set(group, list);
				
				views.addChild(vbox);
			}
			
			list.dataSource.add( { text: name, controller: controller, icon: icon } );
		}
	}
	
	private function _onViewsChange(event:UIEvent):Void {
		for (list in _groups.iterator()) {
			list.selectedIndex = -1;
		}

		var tabs:TabView = getComponentAs("tabs", TabView);
		tabs.removeAllTabs();
		
		var views:Accordion = getComponentAs("views", Accordion);
		if (views.selectedButton == null) {
			return;
		}

		var xml:Xml = ResourceManager.instance.getXML("data/views.xml");
		var xpath:String = "/views/view/group[text() = '" + views.selectedButton.text + "']";
		var a:Array<Xml> = XPathUtil.getXPathNodes(xml, xpath);
		var box:ContinuousHBox = new ContinuousHBox();
		box.percentWidth = 100;
		box.text = views.selectedButton.text;
		for (item in a) {
			item = item.parent;
			var name:String = XPathUtil.getXPathValue(item, "name/text()");
			var icon:String = XPathUtil.getXPathValue(item, "icon/text()");
			var controller:String = XPathUtil.getXPathValue(item, "controller/text()");
			
			var button:Button = new Button();
			button.autoSize = false;
			button.multiline = true;
			button.width = 110;// 100 / cols;
			button.height = 110;
			button.icon = icon;
			button.style.iconPosition = "top";
			button.text = name;
			button.userData = controller;
			button.addEventListener(UIEvent.CLICK, _onViewButtonClick);
			box.addChild(button);
		}

		tabs.addChild(box);
		tabs.selectedIndex = 0;
	}
	
	private function _onViewItemChange(event:UIEvent):Void {
		//var list:ListView = cast event.component;
		//var data:Dynamic = list.selectedItems[0].data;
		showView(cast(event.component, ItemRenderer).data.controller);
	}
	
	private function _onViewButtonClick(event:UIEvent):Void {
		showView(event.component.userData);
	}
	
	private function showView(controller:String):Void {
		var tabs:TabView = getComponentAs("tabs", TabView);
		tabs.removeAllTabs();
		
		var xml:Xml = ResourceManager.instance.getXML("data/views.xml");
		var xpath:String = "/views/view/controller[text() = '" + controller + "']";
		var node:Xml = XPathUtil.getXPathNode(xml, xpath).parent;
		var name:String = XPathUtil.getXPathValue(node, "name/text()");
		var controller:String = XPathUtil.getXPathValue(node, "controller/text()");
		var view:Controller = Type.createInstance(Type.resolveClass(controller), []);
		var icon:String = XPathUtil.getXPathValue(node, "icon/text()");
		/*
		var container:VBox = new VBox();
		container.percentWidth = container.percentHeight = 100;
		container.text = name;
		container.addChild(view.view);
		*/
		cast(view.view, Component).text = name;
		tabs.addChild(view.view);
		tabs.getTabButton(0).icon = icon;
		
		if (_loadResources == true) {
			var resources:Array<Xml> = XPathUtil.getXPathNodes(node, "resources/resource");
			var tabIndex:Int = 0;
			for (r in resources) {
				var resType:String = XPathUtil.getXPathValue(r, "@type");
				var res:String = XPathUtil.getXPathValue(r, "text()");
				var n:Int = res.lastIndexOf("/");
				var resName:String = res.substr(n + 1, res.length);
				
				var c:Component = null;
				var icon = null;
				if (resType == "haxe") {
					c = new Code();
					cast(c, Code).async = true;
					cast(c, Code).syntax = "haxe";
					var code:String = ResourceManager.instance.getText(res);
					code = StringTools.replace(code, "\r", "");
					c.text = code;
					c.percentWidth = c.percentHeight = 100;
					icon = "icons/blue-document-haxe.png";
				} else if (resType == "xml") {
					c = new Code();
					cast(c, Code).async = true;
					cast(c, Code).syntax = "xml";
					var code:String = ResourceManager.instance.getText(res);
					code = StringTools.replace(code, "\r", "");
					c.text = code;
					c.percentWidth = c.percentHeight = 100;
					icon = "icons/blue-document-xml.png";
				} else if (resType == "css") {
					c = new Code();
					cast(c, Code).async = true;
					cast(c, Code).syntax = "css";
					var code:String = ResourceManager.instance.getText(res);
					code = StringTools.replace(code, "\r", "");
					c.text = code;
					c.percentWidth = c.percentHeight = 100;
					icon = "icons/blue-document-css.png";
				}

				if (c != null) {
					var container:VBox = new VBox();
					container.percentWidth = container.percentHeight = 100;
					container.text = resName;
					container.addChild(c);
					tabs.addChild(container);
					if (icon != null) {
						tabs.getTabButton(tabIndex+1).icon = icon;
					}
				}
				
				tabIndex++;
			}
		}

		//tabs.selectedIndex = -1;
		tabs.selectedIndex = 0;
		
		//var views:Accordion = getComponentAs("views", Accordion);
		//views.selectedIndex = 2;
	}

	private function popupSettings():Void {
		var controller:PrefsController = new PrefsController();
		var config:Dynamic = { };
		config.buttons = [PopupButton.CONFIRM, PopupButton.CANCEL];
		config.styleName = "prefs-popup";
		config.width = 400;
		showCustomPopup(controller.view, "Settings", config, function(e) {
			if (e == PopupButton.CONFIRM) {
				controller.savePrefs();
				showSimplePopup("Your settings have been changed. You must restart (or refresh) the application from the new settings to take effect.");
			}
		});
	}
	
	private function popupAbout():Void {
		showCustomPopup("ui/about.xml", "About", {width: 400, buttons: PopupButton.OK});
	}
}