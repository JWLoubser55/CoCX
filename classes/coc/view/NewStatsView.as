package coc.view {
import classes.CoC;
import classes.Player;
import classes.Stats.Buff;
import classes.Stats.BuffableStat;
import classes.internals.Utils;

import flash.text.TextField;
import flash.text.TextFormatAlign;

public class NewStatsView extends Block {
	public static const TITLE_FORMAT: Object = {
		font:'Times New Roman',
		bold:true,
		size:22,
		align:TextFormatAlign.CENTER
	};
	public static const SUBTITLE_FORMAT: Object = {
		font:'Times New Roman',
		bold:false,
		size:14,
		align:TextFormatAlign.CENTER
	};
	public static const STATLABEL_FORMAT: Object = {
		font:'Georgia',
		size:16,
		bold:true,
		align:TextFormatAlign.CENTER
	};
	public static const STATVALUE_FORMAT: Object = {
		font:'Georgia',
		size:16,
		align:TextFormatAlign.CENTER
	};
	public static const BARLABEL_FORMAT: Object = {
		font:'Georgia',
		size:16,
		bold:true,
		align:TextFormatAlign.LEFT
	};
	public static const BARMAX_FORMAT: Object = {
		font:'Georgia',
		size:16,
		align:TextFormatAlign.LEFT
	};
	public static const XP_BAR_BG:String = "#222222";
	public static const XP_BAR_BORDER:String = "#888888";
	public static const XP_BAR_FILL:String = "#eeee00";
	public static const XP_BAR_FILL_LEVELUP:String = "#eeeecc";
	public static const XP_BAR_FILL_LEVELCAP:String = "#ff8000";
	public static const XP_BAR_HEIGHT:int = 8;
	public static const XP_BAR_BORDER_SIZE:int = 1;

	private var bg:BitmapDataSprite;

	public var titleLabel:TextField;
	public var subtitleLabel:TextField;

	public var xpBar:Block;
	public var xpBarFill:BitmapDataSprite;
	public var xpBarBg:BitmapDataSprite;
	public var xpBarBorder:BitmapDataSprite;

	public var resourceTab:ResourceStatsView;
	public var primaryTab:PrimaryStatsView;

	public function NewStatsView() {
		super({
			x: 0,
			y: 0,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				type: 'flow',
				direction: 'column',
				stretch: true,
				ignoreHidden: true
			}
		});
		bg = addBitmapDataSprite({
			x:0, y:0,
			width: width,
			height: height,
			crop: true,
			borderColor: '#A37C17',
			borderWidth: 1,
			borderRadius: 2
		}, {
			ignore:true
		});
		titleLabel = addTextField({
			width: width,
//			height: 22,
			defaultTextFormat: TITLE_FORMAT
		}, {
			autosize: true
		});
		subtitleLabel = addTextField({
			width: width,
//			height: 12,
			defaultTextFormat: SUBTITLE_FORMAT
		}, {
			autosize: true
		});
		xpBar = new Block({
			width: width-2,
			height: XP_BAR_HEIGHT
		});
		addElement(xpBar);
		xpBarBorder = xpBar.addBitmapDataSprite({
			x:1,
			y:0,
			width:width-2,
			height:XP_BAR_HEIGHT,
			fillColor:XP_BAR_BORDER
		});
		xpBarBg = xpBar.addBitmapDataSprite({
			x:1+XP_BAR_BORDER_SIZE,
			y:XP_BAR_BORDER_SIZE,
			width:width-2-XP_BAR_BORDER_SIZE*2,
			height:XP_BAR_HEIGHT-XP_BAR_BORDER_SIZE*2,
			fillColor:XP_BAR_BG
		});
		xpBarFill = xpBar.addBitmapDataSprite({
			x:xpBarBg.x,
			y:xpBarBg.y,
			width:xpBarBg.width,
			height:xpBarBg.height,
			fillColor:XP_BAR_FILL
		});

		resourceTab = new ResourceStatsView();
		addElement(resourceTab);
		primaryTab = new PrimaryStatsView();
		primaryTab.visible = false;
		addElement(primaryTab);
	}

	public function toggle():void {
		resourceTab.visible = !resourceTab.visible;
		primaryTab.visible = !primaryTab.visible;
		invalidateLayout();
	}

	public function refreshAll():void {
		const player:Player = CoC.instance.player;

		titleLabel.text = player.short;
		var levelText:String;
		if (player.negativeLevel) {
			levelText = "<font color='#900000'>(-"+player.negativeLevel+")</font> "+player.level;
		} else {
			levelText = String(player.level);
		}
		subtitleLabel.htmlText = "Level "+levelText+" "+player.race();

		var xppc:Number;
		if (player.level >= CoC.instance.levelCap) {
			xpBarFill.fillColor = XP_BAR_FILL_LEVELCAP;
			xppc = 1.0;
		} else {
			xppc = Utils.boundFloat(0.0, Number(player.XP)/Number(player.requiredXP()), 1.0);
			xpBarFill.fillColor = xppc >= 1.0 ? XP_BAR_FILL_LEVELUP : XP_BAR_FILL;
		}
		xpBarFill.width = Math.round(xppc * xpBarBg.width);

		resourceTab.refreshAll();
		primaryTab.refreshAll();
		invalidateLayout();
	}

	public function setTheme(type:int, font:String):void {
		var style:* = MainView.Themes[type];
		if (!style) return;
		bg.borderColor = style.statBorderColor;
		bg.fillColor = style.statGlass;
		bg.fillAlpha = style.statGlassAlpha;
		var _textColor:* = style.statTextColor;
		// TODO subscribe elements globally on ThemeChangeEvent?
		for each (var tf:TextField in [
				titleLabel,subtitleLabel
		]) {
			UIUtils.setTextColor(tf, _textColor);
		}
		resourceTab.onThemeChange();
		primaryTab.onThemeChange();
	}


	override public function doLayout():void {
		super.doLayout();
		bg.width = width;
		bg.height = (resourceTab.visible ? (resourceTab.y + resourceTab.height) : (primaryTab.y + primaryTab.height)) + MainView.GAP;
	}

	public function hideUpDown():void {
		resourceTab.hideUpDown();
		primaryTab.hideUpDown();
	}
}
}
