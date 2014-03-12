package haxe.ui.showcase.views;

import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;

class ContinuousLayout extends XMLController {
	private static var VALIGNS:Array<String> = ["top", "center", "bottom"];
	private static var HALIGNS:Array<String> = ["left", "center", "right"];
	
	public function new() {
		super("resources/ContinuousLayout/ContinuousLayout.xml");
		
		getComponent("width").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theBox").width = cast(e.component, HSlider).pos;
		});

		getComponent("height").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theBox").height = cast(e.component, HSlider).pos;
		});

		getComponent("child").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = e.component.text;
			getComponentAs("childWidth", HSlider).pos = getComponent(childId).width;
			getComponentAs("childHeight", HSlider).pos = getComponent(childId).height;
			getComponentAs("valign", ListSelector).selectedIndex = Lambda.indexOf(VALIGNS, getComponent(childId).verticalAlign);
			getComponentAs("halign", ListSelector).selectedIndex = Lambda.indexOf(HALIGNS, getComponent(childId).horizontalAlign);
		});
		
		getComponent("childWidth").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).width = cast(e.component, HSlider).pos;
		});
		
		getComponent("childHeight").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).height = cast(e.component, HSlider).pos;
		});
		
		getComponent("valign").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).verticalAlign = e.component.text;
		});
		
		getComponent("halign").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).horizontalAlign = e.component.text;
		});
	}
}