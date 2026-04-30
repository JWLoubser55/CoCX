package coc.view {
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Player;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.StatUtils;
import classes.internals.Utils;

import coc.model.TimeModel;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class StatsView extends Block {
	public static const ValueFontOld:String    = 'Lucida Sans Typewriter';
	public static const ValueFont:String       = 'Georgia';
	
	public static const LABEL_FORMAT:Object = {
		font:'Times New Roman',
		bold:true,
		size:22
	};
	public static const TEXT_FORMAT:Object = {
		font:ValueFont,
		size:16
	};
	public static const TIME_FORMAT:Object = {
		font:'Lucida Sans Typewriter',
		size:18
	};


	private var newStatsView:NewStatsView;
	private var oldStatsView:Block;
	private var corner:CornerStatsView;
	private var _useNewStatsView:Boolean = true;
	private var toggleButton:CoCButton;
	// OLD statview
	// ============
	private var sideBarBG:BitmapDataSprite;
	private var nameText:TextField;
	private var coreStatsText:TextField;
	private var combatStatsText:TextField;
	private var strBar:StatBar;
	private var touBar:StatBar;
	private var speBar:StatBar;
	private var intBar:StatBar;
	private var wisBar:StatBar;
	private var libBar:StatBar;
	private var senBar:StatBar;
	private var corBar:StatBar;
	private var hpBar:StatBar;
	private var wrathBar:StatBar;
	private var lustBar:StatBar;
	private var fatigueBar:StatBar;
	private var manaBar:StatBar;
	private var soulforceBar:StatBar;
	private var hungerBar:StatBar;

	private var allStats:/*StatBar*/Array;

	private var col1:Block;
	private var col2:Block;

	public function StatsView(mainView:MainView, cornerStatsView:CornerStatsView) {
		super({
			x    : MainView.STATBAR_X,
			y    : MainView.STATBAR_Y,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H
		});
		this.newStatsView = new NewStatsView();
		this.newStatsView.visible = false;
		this.addElement(this.newStatsView);

		const o:Block = new Block({
			x    : 0,
			y    : 0,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H
		});
		o.visible = false;
		this.oldStatsView = o;
		this.addElement(o);

		this.corner = cornerStatsView;
		this.toggleButton = new CoCButton({
			x: MainView.STATBAR_W - MainView.BTN_H - 1,
			y: 1,
			square: true
		});
		this.addElement(toggleButton);

		// Populate oldStatsView;
		sideBarBG     = o.addBitmapDataSprite({
			x:0,y:0,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			crop: true,
			borderColor: '#A37C17',
			borderWidth: 1,
			borderRadius: 2
		});
		nameText      = o.addTextField({
			x:0,y:0,
			width: MainView.STATBAR_W,
			defaultTextFormat: Utils.extend({},LABEL_FORMAT,{
				align:TextFormatAlign.CENTER
			})
		});
		o.addElement(col1 = new Block({
			x: 0,
			y: 20,
			width: MainView.STATBAR_COL_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				padding: MainView.HALFGAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		}));
		o.addElement(col2 = new Block({
			x: MainView.STATBAR_COL_W,
			y: 20,
			width: MainView.STATBAR_COL_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				padding: MainView.HALFGAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		}));
		coreStatsText = col1.addTextField({
			text: 'Core stats:',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		col1.addElement(strBar = new StatBar({statName: "Strength:"}));
		addStatTooltip(strBar, 'str');
		col1.addElement(touBar = new StatBar({statName: "Toughness:"}));
		addStatTooltip(touBar, 'tou');
		col1.addElement(speBar = new StatBar({statName: "Speed:"}));
		addStatTooltip(speBar, 'spe');
		col1.addElement(intBar = new StatBar({statName: "Intelligence:"}));
		addStatTooltip(intBar, 'int');
		col1.addElement(wisBar = new StatBar({statName: "Wisdom:"}));
		addStatTooltip(wisBar, 'wis');
		col1.addElement(libBar = new StatBar({statName: "Libido:"}));
		addStatTooltip(libBar, 'lib');
		col1.addElement(senBar = new StatBar({statName: "Sensitivity:"}));
		addStatTooltip(senBar, 'sens');
		col1.addElement(corBar = new StatBar({statName: "Corruption:"}));
		addStatTooltip(corBar, 'cor');

		combatStatsText = col2.addTextField({
			text: 'Combat stats',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		col2.addElement(hpBar = new StatBar({
			statName: "HP:",
			barColor: '#008000',
			bgColor : '#ff0000',
			showMax : true
		}));
		addStatTooltip(hpBar, 'hp');
		col2.addElement(lustBar = new StatBar({
			statName   : "Lust:",
		//	barColor   : '#ff1493',
			minBarColor: '#ff0000',
			hasMinBar  : true,
			showMax    : true
		}));
		addStatTooltip(lustBar, 'lust');
		col2.addElement(wrathBar = new StatBar({
			statName: "Wrath:",
			showMax : true
		}));
		addStatTooltip(wrathBar, 'wrath');
		col2.addElement(fatigueBar = new StatBar({
			statName: "Fatigue:",
			showMax : true
		}));
		addStatTooltip(fatigueBar, 'fatigue');
		col2.addElement(manaBar = new StatBar({
			statName: "Mana:",
		//	barColor: '#0000ff',
			showMax : true
		}));
		addStatTooltip(manaBar, 'mana');
		col2.addElement(soulforceBar = new StatBar({
			statName: "SF:",
		//	barColor: '#ffd700',
			showMax : true
		}));
		addStatTooltip(soulforceBar, 'soulforce');
		col2.addElement(hungerBar = new StatBar({
			statName: "Satiety:",
			showMax : true
		}));
		addStatTooltip(hungerBar, 'hunger');
		///////////////////////////
		allStats = [];
		for (var ci:int = 0, cn:int = col1.numElements; ci < cn; ci++) {
			var e:StatBar = col1.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
		for (ci = 0, cn = col2.numElements; ci < cn; ci++) {
			e = col2.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
		for (ci = 0, cn = cornerStatsView.numElements; ci < cn; ci++) {
			e = cornerStatsView.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
	}
	private function toggleClick():void {
		this.newStatsView.toggle();
		// this.useNewStatsView = !this.useNewStatsView;
	}
	override public function invalidateLayout():void {
		super.invalidateLayout();
		if (_useNewStatsView) {
			if (newStatsView) this.newStatsView.invalidateLayout();
		} else {
			if (oldStatsView) this.oldStatsView.invalidateLayout();
			if (col1) col1.invalidateLayout();
			if (col2) col2.invalidateLayout();
		}
		if (corner) corner.invalidateLayout();
	}
	public function show():void {
		this.visible = true;
	}

	public function hide():void {
		this.visible = false;
	}


	public function get useNewStatsView():Boolean {
		return _useNewStatsView;
	}

	public function set useNewStatsView(value:Boolean):void {
		if (_useNewStatsView != value) {
			_useNewStatsView = value;
			this.oldStatsView.visible = !value;
			this.newStatsView.visible = value;
			refreshStats();
		}
	}

	override public function set visible(value:Boolean):void {
		if (visible != value) {
			for each (var sb:StatBar in allStats) {
				sb.animate = value && (CoC.instance.settings.statbarAnimations == 0);
			}
			if (_useNewStatsView) {
				this.newStatsView.visible = value;
			} else {
				this.oldStatsView.visible = value;
			}
		}
		this.toggleButton.show("",this.toggleClick).icon("Tab");
		super.visible = value;
		if (corner) corner.visible = visible;
	}
	// <- hideUpDown
	public function hideUpDown():void {
		newStatsView.hideUpDown();
		var ci:int, cc:int = this.allStats.length;
		for (ci = 0; ci < cc; ++ci) {
			var c:StatBar = this.allStats[ci];
			c.isUp        = false;
			c.isDown      = false;
		}
	}

	public function showLevelUp():void {
		this.corner.levelBar.isUp = true;
	}

	public function hideLevelUp():void {
		this.corner.levelBar.isUp = false;
	}

	public function statByName(statName:String):StatBar {
		switch (statName.toLowerCase()) {
			case 'str':
				return newStatsView.primaryTab.strBar;
			case 'tou':
				return newStatsView.primaryTab.touBar;
			case 'spe':
				return newStatsView.primaryTab.speBar;
			case 'inte':
			case 'int':
				return newStatsView.primaryTab.intBar;
			case 'wis':
				return newStatsView.primaryTab.wisBar;
			case 'lib':
				return newStatsView.primaryTab.libBar;
			case 'sens':
			case 'sen':
				return newStatsView.primaryTab.sensBar;
			case 'cor':
				return newStatsView.primaryTab.corBar;
			case 'hp':
				return newStatsView.resourceTab.hpBar;
			case 'wrath':
				return newStatsView.resourceTab.wrathBar;
			case 'lust':
				return newStatsView.resourceTab.lustBar;
			case 'fatigue':
				return newStatsView.resourceTab.fatigueBar;
			case 'mana':
				return newStatsView.resourceTab.manaBar;
			case 'soulforce':
				return newStatsView.resourceTab.soulforceBar;
			case 'hunger':
				return hungerBar;
			case 'level':
				return corner.levelBar;
			case 'xp':
				return corner.xpBar;
			case 'gems':
				return corner.gemsBar;
			case 'spiritstones':
				return corner.spiritstonesBar;
		}
		return null;
	}
	public function showStatUp(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isUp        = true;
		else trace("[ERROR] Cannot showStatUp "+statName);
	}

	public function showStatDown(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isDown      = true;
		else trace("[ERROR] Cannot showStatDown "+statName);
	}
	public function hungerBarIsVisible():Boolean {
		return hungerBar.visible;
	}
	public function toggleHungerBar(show:Boolean):void {
		hungerBar.visible = show;
		invalidateLayout();
	}
	public function refreshStats():void {
		if (_useNewStatsView) {
			newStatsView.refreshAll();
			refreshCornerStats();
			return;
		}
		const game:CoC = CoC.instance;
		var player:Player            = game.player;
		nameText.htmlText     = "<b>" + player.short + "</b>";
		strBar.maxValue       = player.strStat.max;
		strBar.value          = player.str;
		touBar.maxValue       = player.touStat.max;
		touBar.value          = player.tou;
		speBar.maxValue       = player.speStat.max;
		speBar.value          = player.spe;
		intBar.maxValue       = player.intStat.max;
		intBar.value          = player.inte;
		wisBar.maxValue       = player.wisStat.max;
		wisBar.value          = player.wis;
		libBar.maxValue       = player.libStat.max;
		libBar.value          = player.lib;
		senBar.maxValue       = player.sens;
		senBar.value          = player.effectiveSensitivity();
		corBar.value          = player.cor;
		var hpPercent:Boolean = game.settings.hpStatbarPercentage == 1;
		hpBar.maxValue        = player.maxHP();
		hpBar.value           = player.HP;
		hpBar.percentage	  = hpPercent;
		var wrathPercent:Boolean = game.settings.wrathStatbarPercentage == 1;
		wrathBar.maxValue 	  = player.maxWrath();
		wrathBar.value    	  = player.wrath;
		wrathBar.percentage	  = wrathPercent;
		var lustPercent:Boolean = game.settings.lustStatbarPercentage == 1;
		lustBar.maxValue      = player.maxLust();
		lustBar.minValue      = player.minLust();
		lustBar.percentage	  = lustPercent;
		lustBar.value         = player.lust;
		fatigueBar.maxValue   = player.maxFatigue();
		fatigueBar.value      = player.fatigue;
		manaBar.maxValue 	  = player.maxMana();
		manaBar.value    	  = player.mana;
		soulforceBar.maxValue = player.maxSoulforce();
		soulforceBar.value    = player.soulforce;
	//	soulforceBar.valueText= (player.soulforce/player.maxSoulforce()).toFixed(2)+'%';
		hungerBar.maxValue    = player.maxHunger();
		hungerBar.value       = player.hunger;
		if (player.hunger < 25) {
			hungerBar.statName = '/!\\ Satiety:';
		} else {
			hungerBar.statName = 'Satiety:';
		}

		refreshCornerStats();
		invalidateLayout();
	}

	public function refreshCornerStats():void {
		const game:CoC = CoC.instance;
		const player:Player = game.player;
		corner.advancementText.htmlText = "<b>Advancement</b>";
		corner.levelBar.value           = player.level;
		if (player.negativeLevel) corner.levelBar.valueText = "(-" + player.negativeLevel + ") " + player.level;
		if (player.level < CoC.instance.levelCap || player.negativeLevel > 0) {
			corner.xpBar.maxValue = player.requiredXP();
			corner.xpBar.value    = player.XP;
		} else {
			corner.xpBar.maxValue  = player.XP;
			corner.xpBar.value     = player.XP;
			corner.xpBar.valueText = 'MAX';
		}
		corner.gemsBar.valueText = Utils.addComma(Math.floor(player.gems));
		corner.spiritstonesBar.valueText = game.flags[kFLAGS.SPIRIT_STONES];

		var minutesDisplay:String = "" + game.model.time.minutes;
		if (minutesDisplay.length == 1) minutesDisplay = "0" + minutesDisplay;

		var hours:Number = game.model.time.hours;
		var hrs:String, ampm:String;
		if (game.settings.use12hours == 0) {
			hrs  = "" + hours;
			ampm = "";
		} else {
			hrs  = (hours % 12 == 0) ? "12" : "" + (hours % 12);
			ampm = hours < 12 ? "am" : "pm";
		}
		corner.timeText.htmlText = "<u>Days Passed: " + game.model.time.days + "</u>\n"
				+ (CoC.instance.model.time.useRealDate() ? '' : '<u>Date: ' + TimeModel.formatDate(CoC.instance.model.time.date) + '</u>\n')
				+ "Time: " + hrs + ":" + minutesDisplay + ampm;
		corner.debugBuildVersion.htmlText = "CoCX: " + CoC.instance.debugGameVer +
				", NG: "+ CoC.instance.flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
	}

	public function setTheme(type:int, font:String):void {
		var style:* = MainView.Themes[type];
		if (!style) return;
		newStatsView.setTheme(type, font);
		// TODO subscribe elements globally on ThemeChangeEvent?
		sideBarBG.borderColor = style.statBorderColor;
		sideBarBG.fillColor = style.statGlass;
		sideBarBG.fillAlpha = style.statGlassAlpha;
		corner.bg.borderColor = style.statBorderColor;
		corner.bg.fillColor = style.statGlass;
		corner.bg.fillAlpha = style.statGlassAlpha;
		
		var dtf:TextFormat;
		for each(var e:StatBar in allStats) {
			dtf = e.valueLabel.defaultTextFormat;
			dtf.color = style.statTextColor;
			dtf.font = font;
			e.valueLabel.defaultTextFormat = dtf;
			e.valueLabel.setTextFormat(dtf);
			e.nameColor = style.statTextColor;
			if (e.bar) e.bar.alpha    = style.barAlpha;
			if (e.minBar) e.minBar.alpha = (1 - (1 - style.barAlpha) / 2); // 2 times less transparent than bar
		}
		for each(var tf:TextField in [nameText,coreStatsText,combatStatsText,corner.advancementText,corner.timeText,corner.debugBuildVersion]) {
			dtf = tf.defaultTextFormat;
			dtf.color = style.statTextColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
	}

	public static function addStatTooltip(element:DisplayObject, statName:String):void {
		element.addEventListener("rollOver",Utils.curry(hoverStat, statName));
		element.addEventListener("rollOut",Utils.curry(hoverStat, statName));
	}
	public static function hoverStat(statname:String, event:MouseEvent):void {
		var player:Player = CoC.instance.player;
		switch (event.type) {
			case MouseEvent.ROLL_OVER:
				var text:String;
				var astat:IStat = player.statStore.findStat(statname);
				var isPositiveStat:Boolean = true;
				var bar:DisplayObject = event.target as DisplayObject;
				if (astat is BuffableStat) {
					var displayName:String = StatUtils.nameOfStat(statname);
					var stat:BuffableStat = astat as BuffableStat;
					if (!stat) return;
					if (!bar) return;
					if (statname == "sens" || statname == "cor" || statname == "minlust") isPositiveStat = false;
					if (statname == "minlust") {
						var lustValue:String = (CoC.instance.settings.lustStatbarPercentage)? "Lust: " +
							 Utils.formatNumber(Math.floor(player.lust)) + '/' + Utils.formatNumber(player.maxLust()) + "\n": "";
						text = lustValue + StatUtils.describeBuffs(stat, false, isPositiveStat);
						player.listMinLustMultiBuffs();
						text += StatUtils.describeBuffs(player.minLustXStat, true, isPositiveStat);
						CoC.instance.mainView.toolTipView.showForElement(
								bar,
								displayName,
								text);
					}
					else {
						CoC.instance.mainView.toolTipView.showForElement(
								bar,
								displayName,
								StatUtils.describeBuffs(stat, false, isPositiveStat));
					}
				} else if (astat is PrimaryStat) {
					displayName = StatUtils.nameOfStat(statname);
					var primStat:PrimaryStat = astat as PrimaryStat;
					if (!primStat) return;
					if (statname == "sens" || statname == "cor") isPositiveStat = false;
					var s:String = "Core: "+primStat.core.value+"/"+primStat.core.max+". ";
					s += "Training: "+primStat.train.value+"/"+primStat.train.max+". ";
					if (statname == "tou" && (player.hasPerk(PerkLib.IcyFlesh) || player.hasPerk(PerkLib.HaltedVitals))) {
						s += "\nYou are currently in a state of undeath and cannot benefit from bonus to toughness.";
					} else {
						s += "\n" +
								"" + StatUtils.describeBuffs(primStat.bonus, false, isPositiveStat) + "" +
								"" + StatUtils.describeBuffs(primStat.mult, true, isPositiveStat) + "";
					}
					CoC.instance.mainView.toolTipView.showForElement(bar,displayName,s);
				} else if (statname == "cor") {
					if (!bar) return;
					text = "Corruption: " + Utils.formatNumber(Math.floor(player.cor)) + '/100';
					CoC.instance.mainView.toolTipView.showForElement(bar,"Corruption",text);
				}  else if (statname == "hp") {
					if (!bar) return;
					text = "HP: " + Utils.formatNumber(Math.floor(player.HP)) + '/' + Utils.formatNumber(player.maxHP());
					text+="\n"+StatUtils.describeBuffs(player.maxHpBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxHpMultStat, true);
					CoC.instance.mainView.toolTipView.showForElement(bar,"HP",text);
				} else if (statname == "lust") {
					if (!bar) return;
					text = "Lust: " + Utils.formatNumber(Math.floor(player.lust)) + '/' + Utils.formatNumber(player.maxLust());
					text+="\n"+StatUtils.describeBuffs(player.maxLustBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxLustMultStat, true);
					text += "\n\n<b>Min Lust: "+player.minLust()+"</b>\n"
					text += StatUtils.describeBuffs(player.minLustXStat, true, false);
					CoC.instance.mainView.toolTipView.showForElement(bar,"Lust",text);
				} else if (statname == "wrath") {
					if (!bar) return;
					text = "Wrath: " + Utils.formatNumber(Math.floor(player.wrath)) + '/' + Utils.formatNumber(player.maxWrath())+"\n";
					text += "\n" + StatUtils.describeBuffs(player.maxWrathBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxWrathMultStat, true);
					CoC.instance.mainView.toolTipView.showForElement(bar,"Wrath",text);
				} else if (statname == "mana") {
					if (!bar) return;
					text = "Mana: " + Utils.formatNumber(Math.floor(player.mana)) + '/' + Utils.formatNumber(player.maxMana())+"\n";
					text += "\n" + StatUtils.describeBuffs(player.maxManaBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxManaMultStat, true);
					CoC.instance.mainView.toolTipView.showForElement(bar,"Mana",text);
				} else if (statname == "fatigue") {
					if (!bar) return;
					text = "Fatigue: " + Utils.formatNumber(Math.floor(player.fatigue)) + '/' + Utils.formatNumber(player.maxFatigue())+"\n";
					text += "\n" + StatUtils.describeBuffs(player.maxFatigueBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxFatigueMultStat, true);
					CoC.instance.mainView.toolTipView.showForElement(bar,"Fatigue",text);
				} else if (statname == "soulforce") {
					if (!bar) return;
					text = "Soulforce: " + Utils.formatNumber(Math.floor(player.soulforce)) + '/' + Utils.formatNumber(player.maxSoulforce())+"\n";
					text += "\n" + StatUtils.describeBuffs(player.maxSfBaseStat, false);
					text += "\n" + StatUtils.describeBuffs(player.maxSfMultStat, true);
					CoC.instance.mainView.toolTipView.showForElement(bar,"Soulforce",text);
				} else if (statname == "hunger") {
					if (!bar) return;
					text = "Satiety: " + Utils.formatNumber(Math.floor(player.hunger)) + '/' + Utils.formatNumber(player.maxHunger())+"\n";
					CoC.instance.mainView.toolTipView.showForElement(bar,"Satiety",text);
				}
				break;
			case MouseEvent.ROLL_OUT:
				CoC.instance.mainView.toolTipView.hide();
				if (statname == "minlust") {
					player.minLustStat.removeCombatRoundTrackingBuffs();
					player.minLustXStat.removeCombatRoundTrackingBuffs();
				}
				break;
		}
	}
}
}
