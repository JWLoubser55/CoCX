package coc.view {
import classes.CoC;
import classes.Player;
import classes.Stats.Buff;
import classes.Stats.BuffableStat;
import classes.internals.Utils;

import coc.view.NewStatsView;

import flash.text.TextField;

public class ResourceStatsView extends Block {

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
	public var venomLabel:TextField;
	public var venomBar:StatBar;
	public var venomMax:TextField;

	public function ResourceStatsView() {
		super({
			x: 0,
			y: 0,
			width: MainView.STATBAR_W,
			layoutConfig: {
				type: 'flow',
				direction: 'column',
				stretch: true
			}
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
				rows: 9,
				cols: 3,
				columns: [0.2,0.65,0.15],
				setWidth: true
			}
		});
		addElement(row2);

		// Row 1
		var row1h:int = NewStatsView.STATLABEL_FORMAT.size+6;
		const row1nameformat:* = {
			defaultTextFormat: NewStatsView.STATLABEL_FORMAT,
			autoSize: 'none',
			height: row1h,
			mouseEnabled: true,
			selectable: false
		};
		strLabel = row1.addTextField(Utils.extend({text:'Str'}, row1nameformat));
		StatsView.addStatTooltip(strLabel, 'str');
		touLabel = row1.addTextField(Utils.extend({text:'Tou'}, row1nameformat));
		StatsView.addStatTooltip(touLabel, 'tou');
		speLabel = row1.addTextField(Utils.extend({text:'Spe'}, row1nameformat));
		StatsView.addStatTooltip(speLabel, 'spe');
		intLabel = row1.addTextField(Utils.extend({text:'Int'}, row1nameformat));
		StatsView.addStatTooltip(intLabel, 'int');
		wisLabel = row1.addTextField(Utils.extend({text:'Wis'}, row1nameformat));
		StatsView.addStatTooltip(wisLabel, 'wis');
		libLabel = row1.addTextField(Utils.extend({text:'Lib'}, row1nameformat));
		StatsView.addStatTooltip(libLabel, 'lib');
		senLabel = row1.addTextField(Utils.extend({text:'Sen'}, row1nameformat));
		StatsView.addStatTooltip(senLabel, 'sens');
		corLabel = row1.addTextField(Utils.extend({text:'Cor'}, row1nameformat));
		StatsView.addStatTooltip(corLabel, 'cor');
		satLabel = row1.addTextField(Utils.extend({text:'Sat'}, row1nameformat));
		StatsView.addStatTooltip(satLabel, 'hunger');

		var row2h:int = NewStatsView.STATVALUE_FORMAT.size+14;
		const row1valueformat:* = {
			defaultTextFormat: NewStatsView.STATVALUE_FORMAT,
			autoSize: 'none',
			height: row2h,
			mouseEnabled: true,
			selectable: false
		};
		strValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(strValue, 'str');
		touValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(touValue, 'tou');
		speValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(speValue, 'spe');
		intValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(intValue, 'int');
		wisValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(wisValue, 'wis');
		libValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(libValue, 'lib');
		senValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(senValue, 'sens');
		corValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(corValue, 'cor');
		satValue = row1.addTextField(row1valueformat);
		StatsView.addStatTooltip(satValue, "hunger");


		// Row 2
		const statBarOptions:Object = {
			showMax: false,
			labelAlign: 'center',
			numberStyle: 'comma',
			arrowStyle: 'small',
			barAlpha: 0.6
		};
		hpLabel = row2.addTextField({text:'HP', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		hpBar = new StatBar(Utils.extend({
			barColor: '#00a000',
			barAlpha: 0.6,
			bgColor : '#ff0000'
		}, statBarOptions));
		StatsView.addStatTooltip(hpBar, 'hp');
		row2.addElement(hpBar);
		hpMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		lustLabel = row2.addTextField({text:'Lust', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		row2.addElement(lustBar = new StatBar(Utils.extend({
			minBarColor : '#ff0000',
			barColor: '#800080',
			barAlpha: 0.6,
			hasMinBar: true
		}, statBarOptions)));
		StatsView.addStatTooltip(lustBar, 'lust');
		lustMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		wrathLabel = row2.addTextField({text:'Wrath', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		row2.addElement(wrathBar = new StatBar(Utils.extend({
//			barColor: '#a00000',
//			barAlpha: 0.6
		}, statBarOptions)));
		StatsView.addStatTooltip(wrathBar, 'wrath');
		wrathMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		fatigueLabel = row2.addTextField({text:'Stamina', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		row2.addElement(fatigueBar = new StatBar(Utils.extend({
//			barColor: '#c0c000',
//			barAlpha: 0.8
		}, statBarOptions)));
		StatsView.addStatTooltip(fatigueBar, 'fatigue');
		fatigueMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		manaLabel = row2.addTextField({text:'Mana', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		row2.addElement(manaBar = new StatBar(Utils.extend({
//			barColor: '#00a0a0',
//			barAlpha: 0.8
		}, statBarOptions)));
		StatsView.addStatTooltip(manaBar, 'mana');
		manaMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		soulforceLabel = row2.addTextField({text:'SF', defaultTextFormat: NewStatsView.BARLABEL_FORMAT});
		row2.addElement(soulforceBar = new StatBar(Utils.extend({
//			barColor: '#c0c0c0',
//			barAlpha: 0.8
		}, statBarOptions)));
		StatsView.addStatTooltip(soulforceBar, 'soulforce');
		soulforceMax = row2.addTextField({text:'', defaultTextFormat: NewStatsView.BARMAX_FORMAT});

		venomLabel = row2.addTextField({text:'Venom',defaultTextFormat:NewStatsView.BARLABEL_FORMAT});
		row2.addElement(venomBar = new StatBar(Utils.extend({

		}, statBarOptions)));
		StatsView.addStatTooltip(venomBar, 'venom');
		venomMax = row2.addTextField({text:'',defaultTextFormat:NewStatsView.BARMAX_FORMAT});

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

	public static function showStatValue(labelElement:TextField, element:TextField, value:Number, buffable1:BuffableStat=null, buffable2:BuffableStat=null):void {
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
			UIUtils.setTextColor(labelElement, textColor);
			UIUtils.setTextColor(element, textColor);
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
				UIUtils.setTextColor(satLabel, textColor);
				UIUtils.setTextColor(satValue, textColor);
			}
		} else {
			satLabel.visible = satValue.visible = false;
		}


		hpBar.value = player.HP;
		hpBar.zeroValue = player.minHP();
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

		if (player.canUseVenom()) {
			venomBar.value = player.tailVenom;
			venomBar.maxValue = player.maxVenom();
			venomMax.text = ""+StatBar.shortHandNumber(venomBar.maxValue);
			venomLabel.visible = true;
			venomBar.visible = true;
			venomMax.visible = true;
		} else {
			venomLabel.visible = false;
			venomBar.visible = false;
			venomMax.visible = false;
		}

		row1.invalidateLayout();
		row2.invalidateLayout();
		invalidateLayout();
	}

	public static function get textColor():* {
		return CoC.instance.mainView.theme.statTextColor;
	}

	public function onThemeChange():void {
		// TODO subscribe elements globally on ThemeChangeEvent?
		for each (var tf:TextField in [
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
			venomLabel,venomMax
		]) {
			UIUtils.setTextColor(tf, textColor);
		}
		for each (var bar:StatBar in [
			hpBar,lustBar,wrathBar,manaBar,fatigueBar,soulforceBar,venomBar
		]) {
			UIUtils.setTextColor(bar.nameLabel, textColor);
			UIUtils.setTextColor(bar.valueLabel, textColor);
		}

	}

	public function hideUpDown():void {

		for each (var bar:StatBar in [
			hpBar,lustBar,wrathBar,manaBar,fatigueBar,soulforceBar,venomBar
		]) {
			bar.isUp = false;
			bar.isDown = false;
		}
	}
}
}
