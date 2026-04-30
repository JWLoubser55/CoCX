package coc.view {
import classes.CoC;
import classes.Player;
import classes.Stats.PrimaryStat;
import classes.internals.Utils;

import flash.text.TextField;

public class PrimaryStatsView extends Block {
	private var row1:Block;
	private var row2:Block;

	public var hpLabel:TextField;
	public var hpValue:StatBar;
	public var lustLabel:TextField;
	public var lustValue:StatBar;
	public var wrathLabel:TextField;
	public var wrathValue:StatBar;
	public var staminaLabel:TextField;
	public var staminaValue:StatBar;
	public var manaLabel:TextField;
	public var manaValue:StatBar;
	public var soulforceLabel:TextField;
	public var soulforceValue:StatBar;
	public var venomLabel:TextField;
	public var venomValue:StatBar;
	public var satLabel:TextField;
	public var satValue:StatBar;

	public var strBar:StatBar;
	public var touBar:StatBar;
	public var speBar:StatBar;
	public var intBar:StatBar;
	public var wisBar:StatBar;
	public var libBar:StatBar;
	public var sensBar:StatBar;
	public var corBar:StatBar;

	public function PrimaryStatsView() {
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
				cols: 8,
				setWidth: true
			}
		});
		addElement(row1);
		row2 = new Block({
			width: width,
			layoutConfig: {
				type: 'grid',
				gap: 2,
				rows: 3,
				cols: 2,
				setWidth: true
			}
		});
		addElement(row2, { before: 24 });

		// Row 1;
		var row1h:int = NewStatsView.STATLABEL_FORMAT.size+6;
		const row1nameformat:* = {
			defaultTextFormat: NewStatsView.STATLABEL_FORMAT,
			autoSize: 'none',
			height: row1h,
			mouseEnabled: true,
			selectable: false
		};
		hpLabel = row1.addTextField(Utils.extend({text:'HP'}, row1nameformat));
		StatsView.addStatTooltip(hpLabel, 'hp');
		lustLabel = row1.addTextField(Utils.extend({text:'Lust'}, row1nameformat));
		StatsView.addStatTooltip(lustLabel, 'lust');
		wrathLabel = row1.addTextField(Utils.extend({text:'Wra'}, row1nameformat));
		StatsView.addStatTooltip(wrathLabel, 'wrath');
		staminaLabel = row1.addTextField(Utils.extend({text:'Sta'}, row1nameformat));
		StatsView.addStatTooltip(staminaLabel, 'fatigue');
		manaLabel = row1.addTextField(Utils.extend({text:'Mana'}, row1nameformat));
		StatsView.addStatTooltip(manaLabel, 'mana');
		soulforceLabel = row1.addTextField(Utils.extend({text:'SF'}, row1nameformat));
		StatsView.addStatTooltip(soulforceLabel, 'soulforce');
		venomLabel = row1.addTextField(Utils.extend({text:'Ven'}, row1nameformat));
		StatsView.addStatTooltip(venomLabel, 'venom');
		satLabel = row1.addTextField(Utils.extend({text:'Sat'}, row1nameformat));
		StatsView.addStatTooltip(satLabel, 'hunger');

		const row1barOptions:* ={
			height: row1h,
			animate: false,
			hasGauge: false,
			arrowStyle: 'none',
			showMax: false,
			percentage: true,
			labelAlign: 'center',
			barAlpha: 0.6,
			valueFontSz: 16
		};
		hpValue = new StatBar(row1barOptions);
		row1.addElement(hpValue);
		StatsView.addStatTooltip(hpValue, 'hp');
		lustValue = new StatBar(row1barOptions);
		row1.addElement(lustValue);
		StatsView.addStatTooltip(lustValue, 'lust');
		wrathValue = new StatBar(row1barOptions);
		row1.addElement(wrathValue);
		StatsView.addStatTooltip(wrathValue, 'wrath');
		staminaValue = new StatBar(row1barOptions);
		row1.addElement(staminaValue);
		StatsView.addStatTooltip(staminaValue, 'fatigue');
		manaValue = new StatBar(row1barOptions);
		row1.addElement(manaValue);
		StatsView.addStatTooltip(manaValue, 'mana');
		soulforceValue = new StatBar(row1barOptions);
		row1.addElement(soulforceValue);
		StatsView.addStatTooltip(soulforceValue, 'soulforce');
		venomValue = new StatBar(row1barOptions);
		row1.addElement(venomValue);
		StatsView.addStatTooltip(venomValue, 'venom');
		satValue = new StatBar(row1barOptions);
		row1.addElement(satValue);
		StatsView.addStatTooltip(satValue, 'hunger');

		// Row 2
		const row2BarOptions:Object = {
			showMax: false,
			numberStyle: 'comma',
			arrowStyle: 'small',
			barAlpha: 0.6
		};

		for each (var a:Array in [
				['Strength','str'],
				['Toughness','tou'],
				['Speed','spe'],
				['Intellect','int'],
				['Wisdom','wis'],
				['Libido','lib']
		]) {
			var s:String = a[1];

			var bar:StatBar = new StatBar(Utils.extend({
				statName: a[0]
			},row2BarOptions));
			row2.addElement(bar);
			StatsView.addStatTooltip(bar, s);

			this[s+'Bar'] = bar;
		}
		sensBar = new StatBar(Utils.extend({
			statName: 'Sensitivity'
		}, row2BarOptions));
		row2.addElement(sensBar);
		StatsView.addStatTooltip(sensBar, 'sens');
		corBar = new StatBar(Utils.extend({}, row2BarOptions, {
			statName: 'Corruption',
			barColor: '#5500cc'
		}));
		row2.addElement(corBar);
		StatsView.addStatTooltip(corBar, 'cor');
	}

	public function refreshAll():void {
		const player:Player = CoC.instance.player;

		hpValue.value = player.HP;
		hpValue.maxValue = player.maxHP();
		lustValue.value = player.lust;
		lustValue.maxValue = player.maxLust();
		wrathValue.value = player.wrath;
		wrathValue.maxValue = player.maxWrath();
		staminaValue.value = player.maxFatigue() - player.fatigue;
		staminaValue.maxValue = player.maxFatigue();
		manaValue.value = player.mana;
		manaValue.maxValue = player.maxMana();
		soulforceValue.value = player.soulforce;
		soulforceValue.maxValue = player.maxSoulforce();
		if (player.canUseVenom()) {
			venomLabel.visible = true;
			venomValue.visible = true;
			venomValue.value = player.tailVenom;
			venomValue.maxValue = player.maxVenom();
		} else {
			venomLabel.visible = false;
			venomValue.visible = false;
		}
		satValue.value = player.hunger;
		satValue.maxValue = player.maxHunger();
		if (CoC.instance.mainViewManager.hungerBarVisible()) {
			satLabel.visible = satValue.visible = true;
			var sat100:Number = Math.floor(100 * player.hunger / player.maxHunger());
			if (sat100 < 25) {
				UIUtils.setTextColor(satLabel, '#900000');
			} else if (sat100 > 75) {
				UIUtils.setTextColor(satLabel, '#009000');
			} else {
				UIUtils.setTextColor(satLabel, ResourceStatsView.textColor);
			}
		} else {
			satLabel.visible = satValue.visible = false;
		}

		for each (var s:String in [
				'str','tou','spe','int','wis','lib'
		]) {
			var bar:StatBar = this[s+'Bar'];
			var stat:PrimaryStat = player.statStore.findStat(s) as PrimaryStat;
			bar.value = stat.value ;
			bar.maxValue = stat.max;
		}
		sensBar.value = player.sensStat.value;
		sensBar.maxValue = player.sensStat.max;
		corBar.value = player.cor;
		corBar.maxValue = 100;
	}

	public function onThemeChange():void {
		// TODO subscribe elements globally on ThemeChangeEvent?
		var textColor:* = CoC.instance.mainView.theme.statTextColor;
		for each (var tf:TextField in [
			hpLabel,lustLabel,wrathLabel,staminaLabel,
				manaLabel,soulforceLabel,venomLabel,satLabel]) {
			UIUtils.setTextColor(tf, textColor);
		}
		for each (var bar:StatBar in [
				hpValue,lustValue,wrathValue,staminaValue,
				manaValue,soulforceValue,venomValue,satValue,
				strBar,touBar,speBar,
				intBar,wisBar,libBar,
				sensBar,corBar
		]) {
			UIUtils.setTextColor(bar.nameLabel, textColor);
			UIUtils.setTextColor(bar.valueLabel, textColor);
		}
	}

	public function hideUpDown():void {
		for each (var bar:StatBar in [
			hpValue,lustValue,wrathValue,staminaValue,
			manaValue,soulforceValue,venomValue,satValue,
			strBar,touBar,speBar,
			intBar,wisBar,libBar,
			sensBar,corBar
		]) {
			bar.isUp = false;
			bar.isDown = false;
		}
	}
}
}
