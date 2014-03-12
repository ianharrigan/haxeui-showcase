package haxe.ui.showcase.views;

import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;

class GridLayout extends XMLController {
	private static var VALIGNS:Array<String> = ["top", "center", "bottom"];
	private static var HALIGNS:Array<String> = ["left", "center", "right"];
	
	public function new() {
		super("resources/GridLayout/GridLayout.xml");
		
		getComponent("width").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theBox").width = cast(e.component, HSlider).pos;
		});

		getComponent("height").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theBox").height = cast(e.component, HSlider).pos;
		});
		
		getComponent("child").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = e.component.text;
			if (getComponent(childId).percentWidth == -1) {
				getComponentAs("childWidthAsPercent", CheckBox).selected = false;
				getComponentAs("childWidth", HSlider).pos = getComponent(childId).width;
			} else {
				getComponentAs("childWidthAsPercent", CheckBox).selected = true;
				getComponentAs("childWidth", HSlider).pos = getComponent(childId).percentWidth * 2;
			}
			
			if (getComponent(childId).percentHeight == -1) {
				getComponentAs("childHeightAsPercent", CheckBox).selected = false;
				getComponentAs("childHeight", HSlider).pos = getComponent(childId).height;
			} else {
				getComponentAs("childHeightAsPercent", CheckBox).selected = true;
				getComponentAs("childHeight", HSlider).pos = getComponent(childId).percentHeight * 2;
			}
			
			getComponentAs("valign", ListSelector).selectedIndex = Lambda.indexOf(VALIGNS, getComponent(childId).verticalAlign);
			getComponentAs("halign", ListSelector).selectedIndex = Lambda.indexOf(HALIGNS, getComponent(childId).horizontalAlign);
		});
		
		getComponent("childWidth").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			if (getComponentAs("childWidthAsPercent", CheckBox).selected == false) {
				getComponent(childId).percentWidth = -1;
				getComponent(childId).width = cast(e.component, HSlider).pos;
			} else {
				getComponent(childId).percentWidth = cast(e.component, HSlider).pos / 2;
			}
		});
		
		getComponent("childWidthAsPercent").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			var childId = getComponent("child").text;
			if (cast(e.component, CheckBox).selected == false) {
				getComponent(childId).percentWidth = -1;
				getComponent(childId).width = getComponentAs("childWidth", HSlider).pos;
			} else {
				getComponent(childId).percentWidth = getComponentAs("childWidth", HSlider).pos / 2;
			}
		});
		
		getComponent("childHeight").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			if (getComponentAs("childHeightAsPercent", CheckBox).selected == false) {
				getComponent(childId).percentHeight = -1;
				getComponent(childId).height = cast(e.component, HSlider).pos;
			} else {
				getComponent(childId).percentHeight = cast(e.component, HSlider).pos / 2;
			}
		});
		
		getComponent("childHeightAsPercent").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			var childId = getComponent("child").text;
			if (cast(e.component, CheckBox).selected == false) {
				getComponent(childId).percentHeight = -1;
				getComponent(childId).height = getComponentAs("childHeight", HSlider).pos;
			} else {
				getComponent(childId).percentHeight = getComponentAs("childHeight", HSlider).pos / 2;
			}
		});
		
		getComponent("valign").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).verticalAlign = e.component.text;
		});
		
		getComponent("halign").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).horizontalAlign = e.component.text;
		});
		
		getComponent("Button1").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 0;
		});
		getComponent("Button2").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 1;
		});
		getComponent("Button3").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 2;
		});
		getComponent("Button4").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 3;
		});
		getComponent("Button5").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 4;
		});
		getComponent("Button6").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 5;
		});
		getComponent("Button7").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 6;
		});
		getComponent("Button8").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 7;
		});
		getComponent("Button9").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("child", ListSelector).selectedIndex = 8;
		});
	}
	
}