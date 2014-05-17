package haxe.ui.showcase.views;

import haxe.ui.toolkit.core.XMLController;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/resources/AbsoluteLayout/AbsoluteLayout.xml"))
class AbsoluteLayout extends XMLController {
	public function new() {
		child.onChange = function(e) {
			childLeft.pos = getComponent(child.text).x;
			childTop.pos = getComponent(child.text).y;
			childWidth.pos = getComponent(child.text).width;
			childHeight.pos = getComponent(child.text).height;
		}
		
		childLeft.onChange = function(e) {
			getComponent(child.text).x = childLeft.pos;
		}

		childTop.onChange = function(e) {
			getComponent(child.text).y = childTop.pos;
		}

		childWidth.onChange = function(e) {
			getComponent(child.text).width = childWidth.pos;
		}

		childHeight.onChange = function(e) {
			getComponent(child.text).height = childHeight.pos;
		}
	}
}