package haxe.ui.showcase;

import haxe.ui.showcase.util.Prefs;
import haxe.ui.toolkit.containers.Accordion;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.controls.Menu;
import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.style.DefaultStyles;
import haxe.ui.toolkit.style.Style;
import haxe.ui.toolkit.style.StyleManager;
import haxe.ui.toolkit.themes.DefaultTheme;
import haxe.ui.toolkit.themes.GradientTheme;
import haxe.ui.toolkit.themes.WindowsTheme;

class Main {
	public static function main() {
		if (Prefs.theme == "default") {
			Toolkit.theme = new DefaultTheme();
		} else if (Prefs.theme == "gradient") {
			Toolkit.theme = new GradientTheme();
		} else if (Prefs.theme == "windows") {
			Toolkit.theme = new WindowsTheme();
		}

		PopupManager.instance.defaultTitle = "Component Showcase";
		Toolkit.defaultTransition = "none";
		Toolkit.setTransitionForClass(Accordion, "slide");
		Toolkit.setTransitionForClass(Stack, "fade");
		Toolkit.setTransitionForClass(Menu, "none");
		Toolkit.setTransitionForClass(Popup, "slide");
		
		if (Prefs.selectionMethod != "theme") {
			StyleManager.instance.addStyle("ListSelector", new Style( {
				selectionMethod: Prefs.selectionMethod,
			}));
		}
		
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(new MainController().view);
		});
	}
}
