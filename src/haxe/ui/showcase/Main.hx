package haxe.ui.showcase;

import haxe.ui.toolkit.controls.Menu;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;

class Main {
	public static function main() {
		#if android
			Macros.addStyleSheet("styles/gradient/gradient_mobile.css");
		#else
			Macros.addStyleSheet("styles/gradient/gradient.css");
		#end
		Macros.addStyleSheet("assets/resources/main.css");
		Toolkit.defaultTransition = "none";
		Toolkit.setTransitionForClass(Menu, "none");
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(new MainController().view);
		});
	}
}
