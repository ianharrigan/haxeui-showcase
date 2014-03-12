package haxe.ui.showcase.views;

import haxe.ui.toolkit.core.XMLController;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/resources/Sliders/Sliders.xml"))
class Sliders extends XMLController {
	public function new() {
		width.onChange = function(e) {
			theScroll.width = width.pos;
		};
		
		height.onChange = function(e) {
			theScroll.height = height.pos;
		};

		min.onChange = function(e) {
			theScroll.min = min.pos;
		};
		
		max.onChange = function(e) {
			theScroll.max = max.pos;
			pos.max = max.pos;
		};
		
		pos.onChange = function(e) {
			theScroll.pos = pos.pos;
		};
	}
}