package haxe.ui.showcase.views;

import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.controls.TextInput;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;

class TextInputs extends XMLController {
	public function new() {
		super("resources/TextInputs/TextInputs.xml");
		
		getComponent("width").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theInput").width = cast(e.component, HSlider).pos;
		});

		getComponent("height").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponent("theInput").height = cast(e.component, HSlider).pos;
		});

		getComponent("disabled").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponent("theInput").disabled = cast(e.component, CheckBox).selected;
		});
		
		getComponent("password").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("theInput", TextInput).displayAsPassword = cast(e.component, CheckBox).selected;
		});
		
		getComponent("placeholderText").addEventListener(UIEvent.CHANGE, function(e:UIEvent) {
			getComponentAs("theInput", TextInput).placeholderText = e.component.text;
		});
		
		getComponent("multiline").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("theInput", TextInput).multiline = cast(e.component, CheckBox).selected;
		});
		
		getComponent("wrapLines").addEventListener(UIEvent.CLICK, function(e:UIEvent) {
			getComponentAs("theInput", TextInput).wrapLines = cast(e.component, CheckBox).selected;
		});
	}
}