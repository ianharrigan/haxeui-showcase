package haxe.ui.showcase;

import haxe.ui.showcase.util.Prefs;
import haxe.ui.toolkit.core.XMLController;

@:build(haxe.ui.toolkit.core.Macros.buildController("assets/ui/prefs.xml"))
class PrefsController extends XMLController {
	public function new() {
		var themeName:String = "Default";
		if (Prefs.theme == "default") {
			themeName = "Default Theme";
		} else if (Prefs.theme == "gradient") {
			themeName = "Gradient Theme";
		}
		theme.text = themeName;
		
		var text:String = "No";
		if (Prefs.showSources == "yes") {
			text = "Yes";
		}
		showSources.text = text;
		
		text = "Theme Decides";
		if (Prefs.selectionMethod == "theme") {
			text = "Theme Decides";
		} else if (Prefs.selectionMethod == "dropdown") {
			text = "Drop Down List";
		} else if (Prefs.selectionMethod == "popup") {
			text = "Popup Up List";
		}
		selectionMethod.text = text;
	}
	
	public function savePrefs():Void {
		if (theme.selectedItems != null && theme.selectedItems.length != 0) {
			Prefs.theme = theme.selectedItems[0].data.id;
		}
		Prefs.showSources = showSources.text.toLowerCase();
		if (selectionMethod.selectedItems != null && selectionMethod.selectedItems.length != 0) {
			Prefs.selectionMethod = selectionMethod.selectedItems[0].data.id;
		}
	}
	
}