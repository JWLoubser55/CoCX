package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.Races;
import classes.Scenes.API.FnHelpers;

public class CrimsonOverflowSkill extends AbstractBloodSoulSkill {
	
	public function CrimsonOverflowSkill() {
        super(
            "Crimson Overflow",
            "Activate Crimson Overflow state, which enhances your vitality beyond the limit.",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF],
            StatusEffects.KnowsCrimsonOverflow
        )
		baseSFCost = 0;
    }

	override protected function baseName():String {
		return "CrimsonOverflow";
	}

	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.CrimsonOverflowImperfect);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Increase max Over HP by "+calcPower()+"% "+(player.hasPerk(PerkLib.WayOfTheBlood)?"for additional "+(player.hasPerk(PerkLib.BloodDemonIntelligence)?"2 hours":"1 hour")+"":"until end of combat")+""
	}
	
	override public function calcDuration():int {
		var calcD:int = 1;
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) calcD *= 2;
		return calcD;
	}
	
	public function calcPower():Number {
		var calcP:Number = player.maxHP() * 0.1;
		if (player.hasPerk(PerkLib.WayOfTheBlood)) calcP *= 0.5;
		return Math.round(calcP);
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(bloodSoulSkillCoolDown(4));
	}
	
	override public function doEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood as you raise your hands above your head, opening up your palms. Blood gushes out of your fingertips as beads of crimson gather over your palms in an hourglass shape. ");
			outputText("For a moment, the liquid stills before the blood from the top slowly trickles down into the lower half. The construct breaks down back into a liquid form and burrows back into your pores.");
		}
		if (player.hasPerk(PerkLib.WayOfTheBlood)) {
			if (player.hasStatusEffect(StatusEffects.CrimsonOverflow)) {
				if (player.statusEffectv1(StatusEffects.CrimsonOverflow) < (6 * calcDuration() * player.progressBloodDemon())) player.addStatusValue(StatusEffects.CrimsonOverflow, 1, calcDuration());
			}
			else player.createStatusEffect(StatusEffects.CrimsonOverflow,calcDuration(),0,0,0);
		}
		else player.createStatusEffect(StatusEffects.CrimsonOverflowImperfect,0,0,0,0);
	}
}
}