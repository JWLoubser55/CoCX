package coc.view {
import classes.CoC;
import classes.Parser.Parser;
import classes.internals.Utils;

import flash.text.TextField;

/**
 *
 * Usage:
 *
 * ---
 * var sp:SettingsPanel = new SettingsPanel();
 *
 * sp.setting("Hardcore mode", settings, "hardcore");
 * sp.option(0, "OFF", "off. Description for off");
 * sp.option(1, "ON", "on. Description for on");
 * sp.option(10, "SUPER", "super on. Desription for super on");
 * // repeat sp.option for all option values
 *
 * // repeat block above for all settings
 *
 * // sp.show will put it into the MainView
 * sp.show();
 * ---
 * This will switch settings.hardcore between three values: 0, 1, and 10
 */
public class SettingsPanel extends Block {
	public function SettingsPanel() {
		super({
			layoutConfig: {
				type: "flow",
				direction: "column",
				stretch: true,
				gap: 2
			}
		});
	}
	private var currentSetting:SettingObj = null;

	public function setting(name:String, obj:*, propname:*):void {
		setting_ex(name, function():* {
				return obj[propname]
			},
			function(value:*):void {
				obj[propname] = value
			});
	}
	public function setting_ex(name:String, getter:Function, setter:Function, descriptionFn:Function=null):void {
		flushoption();
		var setting:SettingObj = new SettingObj(name, getter, setter);
		if (descriptionFn == null) {
			descriptionFn = function (): String {
				for (var i:int = 0; i < setting.options.length; i++) {
					if (setting.options[i].selectedFn()) {
						return Parser.recursiveParser(setting.options[i].description);
					}
				}
				return Parser.recursiveParser(setting.name);
			}
		}
		setting.descriptionFn = descriptionFn;
		currentSetting = setting;
	}
	public function option(value:*, name:String, description:String):void {
		var s:* = currentSetting;
		option_ex(
				name,
				currentSetting.name+": "+description,
				function ():Boolean {
					return s.getter() == value
				},
				function ():void {
					s.setter(value);
				}
		)
	}
	public function option_ex(name:String, description:String, selectedFn:Function, clickFn:Function, enabledFn:Function=null): void {
		currentSetting.options.push(
				new OptionObj(name, description, selectedFn, clickFn, enabledFn)
		);
	}
	public function update_setting_ui(setting:SettingObj, header:TextField, buttons:/*CoCButton*/Array):void {
		function set_option(option:OptionObj):void {
			option.clickFn();
			update_setting_ui(setting, header, buttons);
		}
		for (var i:int = 0; i < setting.options.length; i++) {
			if (setting.options[i].disabledFn()) {
				buttons[i].showDisabled(setting.options[i].name, setting.options[i].description);
			} else {
				buttons[i].show(setting.options[i].name, Utils.curry(set_option, setting.options[i]), setting.options[i].description);
			}
		}
		header.htmlText = setting.descriptionFn();
		invalidateLayout();
	}
	private function flushoption():void {
		// Create UI element
		if (!currentSetting) return;
		var header:TextField = UIUtils.newTextField({
			htmlText: "",
			multiline: true,
			wordWrap: true,
			autoSize: "left",
//				width: contentBlock.width,
			defaultTextFormat: CoC.instance.mainView.mainText.defaultTextFormat
		});
		addElement(header);
		var buttons:/*CoCButton*/Array = [];
		var grid:Block = new Block({
			layoutConfig: {
				type: "flow",
				direction: "row",
				gap: 2
			}
		});
		for (var i:int = 0; i < currentSetting.options.length; i++) {
			var button:CoCButton = new CoCButton();
			buttons.push(button);
			grid.addElement(button);
		}
		grid.doLayout();
		addElement(grid, {after:20});
		update_setting_ui(currentSetting, header, buttons);
		currentSetting = null;
	}
	public function show():void {
		flushoption();

		width = MainView.TEXTZONE_W - MainView.VSCROLLBAR_W;
		CoC.instance.mainView.setCustomElement(this, true, false, true);
		doLayout();
	}
}
}

import classes.Parser.Parser;

class SettingObj {

	public function SettingObj(
			name:String,
			getter:Function,
			setter:Function
	) {
		this.name = name;
		this.getter = getter;
		this.setter = setter;
		this.options = [];
		this.descriptionFn = this.defaultDescriptionFn;
	}
	public var name:String;
	public var getter:Function;
	public var setter:Function;
	public var descriptionFn:Function;
	public var options:/*OptionObj*/Array = [];

	private function defaultDescriptionFn():String {
		for (var i:int = 0; i < options.length; i++) {
			if (options[i].selectedFn()) {
				return Parser.recursiveParser(options[i].description);
			}
		}
		return Parser.recursiveParser(name);
	}
}

class OptionObj {

	public function OptionObj(
			name:String,
			description:String,
			selectedFn:Function,
			clickFn:Function,
			disabledFn:Function
	) {
		this.name = name;
		this.description = description;
		this.selectedFn = selectedFn;
		this.clickFn = clickFn;
		this.disabledFn = disabledFn || selectedFn;

	}
	public var name:String;
	public var description:String;
	public var selectedFn:Function;
	public var clickFn:Function;
	public var disabledFn:Function;
}