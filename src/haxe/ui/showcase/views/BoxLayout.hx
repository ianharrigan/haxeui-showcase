package haxe.ui.showcase.views;

import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.XMLController;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/resources/BoxLayout/BoxLayout.xml"))
class BoxLayout extends XMLController {
	private static var VALIGNS:Array<String> = ["top", "center", "bottom"];
	private static var HALIGNS:Array<String> = ["left", "center", "right"];
	
	public function new() {
		width.onChange = function(e) {
			theBox.width = width.pos;
		}
		
		height.onChange = function(e) {
			theBox.height = height.pos;
		}
		
		child.onChange = function(e) {
			var c:Component = getComponent(child.text);
			if (c.percentWidth == -1) {
				childWidthAsPercent.selected = false;
				childWidth.pos = c.width;
			} else {
				childWidthAsPercent.selected = true;
				childWidth.pos = c.percentWidth;
			}
			
			if (c.percentHeight == -1) {
				childHeightAsPercent.selected = false;
				childHeight.pos = c.height;
			} else {
				childHeightAsPercent.selected = true;
				childHeight.pos = c.percentHeight;
			}
			
			halign.selectedIndex = Lambda.indexOf(VALIGNS, c.horizontalAlign);
			valign.selectedIndex = Lambda.indexOf(HALIGNS, c.verticalAlign);
		}
		
		childWidth.onChange = function(e) {
			var c:Component = getComponent(child.text);
			if (childWidthAsPercent.selected == false) {
				c.percentWidth = -1;
				c.width = childWidth.pos;
			} else {
				c.percentWidth = childWidth.pos / 2;
			}
		}

		childHeight.onChange = function(e) {
			var c:Component = getComponent(child.text);
			if (childHeightAsPercent.selected == false) {
				c.percentHeight = -1;
				c.height = childHeight.pos;
			} else {
				c.percentHeight = childHeight.pos / 2;
			}
		}
		
		childWidthAsPercent.onClick = function(e) {
			var c:Component = getComponent(child.text);
			if (childWidthAsPercent.selected == false) {
				c.percentWidth = -1;
				c.width = childWidth.pos;
			} else {
				c.percentWidth = childWidth.pos / 2;
			}
		}
		
		childHeightAsPercent.onClick = function(e) {
			var c:Component = getComponent(child.text);
			if (childHeightAsPercent.selected == false) {
				c.percentHeight = -1;
				c.height = childHeight.pos;
			} else {
				c.percentHeight = childHeight.pos / 2;
			}
		}
		
		halign.onChange = function(e) {
			var c:Component = getComponent(child.text);
			c.horizontalAlign = halign.text;
		}

		valign.onChange = function(e) {
			var c:Component = getComponent(child.text);
			c.verticalAlign = valign.text;
		}
	}
}