package haxe.ui.showcase.views;

import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/resources/AbsoluteLayout/AbsoluteLayout.xml"))
class AbsoluteLayout extends XMLController {
	public function new() {
		getComponent("child").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = e.component.text;
			getComponentAs("childLeft", HSlider).pos = getComponent(childId).x;
			getComponentAs("childTop", HSlider).pos = getComponent(childId).y;
			getComponentAs("childWidth", HSlider).pos = getComponent(childId).width;
			getComponentAs("childHeight", HSlider).pos = getComponent(childId).height;
		});
		
		getComponent("childLeft").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).x = cast(e.component, HSlider).pos;
		});
		
		getComponent("childTop").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).y = cast(e.component, HSlider).pos;
		});
		
		getComponent("childWidth").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).width = cast(e.component, HSlider).pos;
		});
		
		getComponent("childHeight").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			var childId = getComponent("child").text;
			getComponent(childId).height = cast(e.component, HSlider).pos;
		});
	}
}