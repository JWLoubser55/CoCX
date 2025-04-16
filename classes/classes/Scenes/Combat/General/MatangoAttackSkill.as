package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.Monster;
import classes.StatusEffects;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.AbstractGeneral;
import classes.GlobalFlags.kFLAGS;

public class MatangoAttackSkill extends AbstractGeneral {

    public function MatangoAttackSkill() {
		super(
            "Matango Attack",
            "Attack the oppenent with your matango",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            PerkLib.MummyLord
        )
		lastAttackType = Combat.LAST_ATTACK_PHYS;
	}

    override public function get isKnown():Boolean {
        return super.isKnown && player.perkv1(PerkLib.FungalNobility) > 0;
    }

	override public function describeEffectVs(target:Monster):String {
		return "Deals ~" + numberFormat(calcDamage(target)) + " physical damage.";
	}

	public function calcDamage(monster:Monster):Number {
		var matangoDamage:Number = 10;
        matangoDamage += (scalingBonusIntelligence() + scalingBonusWisdom()) * 0.4;
        matangoDamage *= player.perkv1(PerkLib.FungalNobility);
		matangoDamage *= player.horns.count;
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) matangoDamage *= combat.historyTacticianBonus();
        var matangoamplification:Number = 1;
        if (player.weapon == weapons.SCECOMM) matangoamplification += 0.5;
		if (player.hasPerk(PerkLib.CommandingTone)) matangoamplification += 0.1;
		if (player.hasPerk(PerkLib.DiaphragmControl)) matangoamplification += 0.1;
		if (player.hasPerk(PerkLib.VocalTactician)) matangoamplification += 0.15;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
            matangoamplification += 0.1;
            if (player.hasPerk(PerkLib.WispLieutenant)) matangoamplification += 0.2;
            if (player.hasPerk(PerkLib.WispCaptain)) matangoamplification += 0.3;
            if (player.hasPerk(PerkLib.WispMajor)) matangoamplification += 0.4;
            if (player.hasPerk(PerkLib.WispColonel)) matangoamplification += 0.5;
        }
		//if (player.perkv2(PerkLib.MummyLord) > 0) matangoamplification *= 2;
        matangoDamage *= matangoamplification;

		return Math.round(matangoDamage);
	}

    override public function doEffect(display:Boolean = true):void {
    	var damage:Number = calcDamage(monster);
		var stunned:Boolean = false;

		//Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        var critChanceMulti:Number = 1.75;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= critChanceMulti;
        }
		if (!monster.plural && !monster.hasPerk(PerkLib.Resolute) && rand(10) == 0) stunned = true;

		damage = Math.round(damage);

		if (display) outputText("\n\nYour matango servants attempt to hurt and restrain your opponent"+(monster.plural?"s":"")+" punching and grabbing at [monster him]. ");
		doPhysicalDamage(damage, true, display);
		if (display) {
			if (crit) outputText(" <b>Critical! </b>");
			if (!stunned) outputText("\n\n");
		}
		if (stunned) {
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (display) outputText("Some of them manage to restrain your opponent down long enough for the others to punch [monster him] silly. \n\n");
		}
    }
}
}