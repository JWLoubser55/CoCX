package coc.view {
import classes.CoC;
import classes.Parser.Parser;
import classes.Player;
import classes.Stats.Buff;
import classes.Stats.BuffableStat;
import classes.internals.Utils;

import coc.view.BitmapDataSprite;
import coc.view.Block;
import coc.view.MainView;
import coc.view.StatBar;
import coc.view.StatOrbBar;
import coc.view.StatsView;
import coc.view.UIUtils;

import flash.display.DisplayObject;

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

	private var bg:BitmapDataSprite;

	public var titleLabel:TextField;
	public var subtitleLabel:TextField;

	private var main:Block;
	private var row1:Block;
	private var row2:Block;

	public var strLabel:TextField;
	public var strValue:TextField;
	public var touLabel:TextField;
	public var touValue:TextField;
	public var speLabel:TextField;
	public var speValue:TextField;
	public var intLabel:TextField;
	public var intValue:TextField;
	public var wisLabel:TextField;
	public var wisValue:TextField;
	public var libLabel:TextField;
	public var libValue:TextField;
	public var senLabel:TextField;
	public var senValue:TextField;
	public var corLabel:TextField;
	public var corValue:TextField;
	public var satLabel:TextField;
	public var satValue:TextField;

	public var hpLabel:TextField;
	public var hpBar:StatBar;
	public var hpOrb:StatOrbBar;
	public var hpMax:TextField;
	public var lustLabel:TextField;
	public var lustBar:StatBar;
	public var lustMax:TextField;
	public var wrathLabel:TextField;
	public var wrathBar:StatBar;
	public var wrathMax:TextField;
	public var fatigueLabel:TextField;
	public var fatigueBar:StatBar;
	public var fatigueMax:TextField;
	public var manaLabel:TextField;
	public var manaBar:StatBar;
	public var manaMax:TextField;
	public var soulforceLabel:TextField;
	public var soulforceBar:StatBar;
	public var soulforceMax:TextField;
	private var _textColor:uint = 0x000000;


	public function NewStatsView() {
		super({
			x: 0,
			y: 0,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				type: 'flow',
				direction: 'column',
				stretch: true
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
		row1 = new Block({
			width: width,
			layoutConfig: {
				type: 'grid',
				rows: 2,
				cols: 9,
				setWidth: true
			}
		});
		addElement(row1);
		row2 = new Block({
			width: width,
			layoutConfig: {
				type: 'grid',
				gap: 2,
				rows: 6,
				cols: 3,
				columns: [0.2,0.65,0.15],
				setWidth: true,
				debug: true
			}
		});
		addElement(row2, { before: 8 });

		// Row 1
		var row1h:int = STATLABEL_FORMAT.size+6;
		const row1nameformat:* = {
			defaultTextFormat: STATLABEL_FORMAT,
			autoSize: 'none',
			height: row1h,
			mouseEnabled: true,
			selectable: false
		};
		strLabel = row1.addTextField(Utils.extend({text:'Str'}, row1nameformat));
		strLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'str'));
		strLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'str'));
		touLabel = row1.addTextField(Utils.extend({text:'Tou'}, row1nameformat));
		touLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'tou'));
		touLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'tou'));
		speLabel = row1.addTextField(Utils.extend({text:'Spe'}, row1nameformat));
		speLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'spe'));
		speLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'spe'));
		intLabel = row1.addTextField(Utils.extend({text:'Int'}, row1nameformat));
		intLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'int'));
		intLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'int'));
		wisLabel = row1.addTextField(Utils.extend({text:'Wis'}, row1nameformat));
		wisLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'wis'));
		wisLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'wis'));
		libLabel = row1.addTextField(Utils.extend({text:'Lib'}, row1nameformat));
		libLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'lib'));
		libLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'lib'));
		senLabel = row1.addTextField(Utils.extend({text:'Sen'}, row1nameformat));
		senLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'sens'));
		senLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'sens'));
		corLabel = row1.addTextField(Utils.extend({text:'Cor'}, row1nameformat));
		corLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'cor'));
		corLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'cor'));
		satLabel = row1.addTextField(Utils.extend({text:'Sat'}, row1nameformat));
		satLabel.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'hunger'));
		satLabel.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'hunger'));
		var row2h:int = STATVALUE_FORMAT.size+6;
		const row1valueformat:* = {
			defaultTextFormat: STATVALUE_FORMAT,
			autoSize: 'none',
			height: row2h,
			mouseEnabled: true,
			selectable: false
		};
		strValue = row1.addTextField(row1valueformat);
		strValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'str'));
		strValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'str'));
		touValue = row1.addTextField(row1valueformat);
		touValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'tou'));
		touValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'tou'));
		speValue = row1.addTextField(row1valueformat);
		speValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'spe'));
		speValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'spe'));
		intValue = row1.addTextField(row1valueformat);
		intValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'int'));
		intValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'int'));
		wisValue = row1.addTextField(row1valueformat);
		wisValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'wis'));
		wisValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'wis'));
		libValue = row1.addTextField(row1valueformat);
		libValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'lib'));
		libValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'lib'));
		senValue = row1.addTextField(row1valueformat);
		senValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'sens'));
		senValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'sens'));
		corValue = row1.addTextField(row1valueformat);
		corValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'cor'));
		corValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'cor'));
		satValue = row1.addTextField(row1valueformat);
		satValue.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'hunger'));
		satValue.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'hunger'));


		// Row 2
		const statBarOptions:Object = {
			showMax: false,
			labelAlign: 'center',
			numberStyle: 'comma',
			hasArrow: false
		};
		hpLabel = row2.addTextField({text:'HP', defaultTextFormat: BARLABEL_FORMAT});
		hpBar = new StatBar(Utils.extend({
			barColor: '#00a000',
			barAlpha: 0.6,
			bgColor : '#ff0000'
		}, statBarOptions));
		hpBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'hp'));
		hpBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'hp'));
		row2.addElement(hpBar);
		hpMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		lustLabel = row2.addTextField({text:'Lust', defaultTextFormat: BARLABEL_FORMAT});
		row2.addElement(lustBar = new StatBar(Utils.extend({
			minBarColor : '#ff0000',
			barColor: '#800080',
			barAlpha: 0.6,
			hasMinBar: true
		}, statBarOptions)));
		lustBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'lust'));
		lustBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'lust'));
		lustMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		wrathLabel = row2.addTextField({text:'Wrath', defaultTextFormat: BARLABEL_FORMAT});
		row2.addElement(wrathBar = new StatBar(Utils.extend({
//			barColor: '#a00000',
//			barAlpha: 0.6
		}, statBarOptions)));
		wrathBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'wrath'));
		wrathBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'wrath'));
		wrathMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		fatigueLabel = row2.addTextField({text:'Stamina', defaultTextFormat: BARLABEL_FORMAT});
		row2.addElement(fatigueBar = new StatBar(Utils.extend({
//			barColor: '#c0c000',
//			barAlpha: 0.8
		}, statBarOptions)));
		fatigueBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'fatigue'));
		fatigueBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'fatigue'));
		fatigueMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		manaLabel = row2.addTextField({text:'Mana', defaultTextFormat: BARLABEL_FORMAT});
		row2.addElement(manaBar = new StatBar(Utils.extend({
//			barColor: '#00a0a0',
//			barAlpha: 0.8
		}, statBarOptions)));
		manaBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'mana'));
		manaBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'mana'));
		manaMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		soulforceLabel = row2.addTextField({text:'SF', defaultTextFormat: BARLABEL_FORMAT});
		row2.addElement(soulforceBar = new StatBar(Utils.extend({
//			barColor: '#c0c0c0',
//			barAlpha: 0.8
		}, statBarOptions)));
		soulforceBar.addEventListener("rollOver",Utils.curry(StatsView.hoverStat,'soulforce'));
		soulforceBar.addEventListener("rollOut",Utils.curry(StatsView.hoverStat,'soulforce'));
		soulforceMax = row2.addTextField({text:'', defaultTextFormat: BARMAX_FORMAT});

		/*
		const orbSize:Number = Math.floor((width-8)/3);
		const defaultOrbOptions:* = {
			width: orbSize,
			height: orbSize+32,
			radius: orbSize/2-2,
			hasMaxValue: true,
			hasValue: true
		};
		hpOrb = new StatOrbBar(Utils.extend({},defaultOrbOptions,{
			bgColor: '#800000',
			bgAlpha: 0.8,
			barColor: '#00a000'
		}));
		addElement(hpOrb);
		/**/
	}

	private function showStatValue(labelElement:TextField, element:TextField, value:Number, buffable1:BuffableStat=null, buffable2:BuffableStat=null):void {
		element.text = StatBar.shortHandNumber(value);
		var x1:Number = 0.0;
		var x2:Number = 0.0;
		if (buffable1) {
			for each (var b:Buff in buffable1.listBuffsUnsafe()) {
				if (b.rate === Buff.RATE_ROUNDS) x1 += b.value;
			}
		}
		if (buffable2) {
			for each (b in buffable2.listBuffsUnsafe()) {
				if (b.rate === Buff.RATE_ROUNDS) x2 += b.value;
			}
		}
		if (x1 == 0 && x2 == 0) {
			UIUtils.setTextColor(labelElement, _textColor);
			UIUtils.setTextColor(element, _textColor);
		} else if (x1 >= 0 && x2 >= 0) {
			UIUtils.setTextColor(labelElement, '#006b00');
			UIUtils.setTextColor(element, '#006b00');
		} else if (x1 <= 0 && x2 <= 0) {
			UIUtils.setTextColor(labelElement, '#900000');
			UIUtils.setTextColor(element, '#900000');
		} else {
			UIUtils.setTextColor(labelElement, '#808000');
			UIUtils.setTextColor(element, '#808000');
		}
	}

	public function refreshAll():void {
		const player:Player = CoC.instance.player;

		titleLabel.text = player.short;
		subtitleLabel.text = "Level "+player.level+" "+player.race();

		showStatValue(strLabel, strValue, player.str, player.strStat.bonus, player.strStat.mult);
		showStatValue(touLabel, touValue, player.tou, player.touStat.bonus, player.touStat.mult);
		showStatValue(speLabel, speValue, player.spe, player.speStat.bonus, player.speStat.mult);
		showStatValue(intLabel, intValue, player.inte, player.intStat.bonus, player.intStat.mult);
		showStatValue(wisLabel, wisValue, player.wis, player.wisStat.bonus, player.wisStat.mult);
		showStatValue(libLabel, libValue, player.lib, player.libStat.bonus, player.libStat.mult);
		showStatValue(senLabel, senValue, player.sens, player.sensStat);
		showStatValue(corLabel, corValue, player.cor);
		if (CoC.instance.mainViewManager.hungerBarVisible()) {
			satLabel.visible = satValue.visible = true;
			var sat100:Number = Math.floor(100 * player.hunger / player.maxHunger());
			satValue.text = "" + sat100 + "%";
			if (sat100 < 25) {
				UIUtils.setTextColor(satLabel, '#900000');
				UIUtils.setTextColor(satValue, '#900000');
			} else if (sat100 > 75) {
				UIUtils.setTextColor(satLabel, '#009000');
				UIUtils.setTextColor(satValue, '#009000');
			} else {
				UIUtils.setTextColor(satLabel, _textColor);
				UIUtils.setTextColor(satValue, _textColor);
			}
		} else {
			satLabel.visible = satValue.visible = false;
		}


		hpBar.value = player.HP;
		hpBar.maxValue = player.maxHP();
//		hpOrb.value = player.HP;
//		hpOrb.maxValue = hpBar.maxValue;
		hpMax.text = ""+StatBar.shortHandNumber(player.maxHP());

		lustBar.value = player.lust;
		lustBar.minValue = player.minLust();
		lustBar.maxValue = player.maxLust();
		lustMax.text = ""+StatBar.shortHandNumber(player.maxLust());

		wrathBar.value = player.wrath;
		wrathBar.maxValue = player.maxWrath();
		wrathMax.text = ""+StatBar.shortHandNumber(player.maxWrath());

		fatigueBar.value = player.maxFatigue()-player.fatigue;
		fatigueBar.maxValue = player.maxFatigue();
		fatigueMax.text = ""+StatBar.shortHandNumber(player.maxFatigue());

		manaBar.value = player.mana;
		manaBar.maxValue = player.maxMana();
		manaMax.text = ""+StatBar.shortHandNumber(player.maxMana());

		soulforceBar.value = player.soulforce;
		soulforceBar.maxValue = player.maxSoulforce();
		soulforceMax.text = ""+StatBar.shortHandNumber(player.maxSoulforce());

		row1.invalidateLayout();
		row2.invalidateLayout();
		invalidateLayout();
	}

	public function setTheme(type:int, font:String):void {
		var style:* = MainView.Themes[type];
		if (!style) return;
		bg.borderColor = style.statBorderColor;
		bg.fillColor = style.statGlass;
		bg.fillAlpha = style.statGlassAlpha;
		_textColor = style.statTextColor;
		// TODO subscribe elements globally on ThemeChangeEvent?
		for each (var tf:TextField in [
				titleLabel,subtitleLabel,
				strLabel,strValue,
				touLabel,touValue,
				speLabel,speValue,
				intLabel,intValue,
				wisLabel,wisValue,
				libLabel,libValue,
				senLabel,senValue,
				corLabel,corValue,
				satLabel,satValue,
				hpLabel,hpMax,
				lustLabel,lustMax,
				wrathLabel,wrathMax,
				manaLabel,manaMax,
				fatigueLabel,fatigueMax,
				soulforceLabel,soulforceMax,
		]) {
			UIUtils.setTextColor(tf, _textColor);
		}
		for each (var bar:StatBar in [
				hpBar,lustBar,wrathBar,manaBar,fatigueBar,soulforceBar
		]) {
			UIUtils.setTextColor(bar.nameLabel, _textColor);
			UIUtils.setTextColor(bar.valueLabel, _textColor);
		}
	}


	override public function doLayout():void {
		super.doLayout();
		bg.width = width;
		bg.height = row2.y + soulforceBar.y + soulforceBar.height + MainView.GAP;
	}
}
}
