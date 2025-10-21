package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Scenes.Combat.CombatAbility;
import classes.StatusEffects;
import classes.Monster;

public class SoulFistSkill extends AbstractSoulSkill {
    public function SoulFistSkill() {
		super(
            "Soul Fist",
            "Toggle on or off. While toggled on unarmed strike gains a wisdom damage bonus but costs soulforce on each strike.",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF],
            StatusEffects.KnowsSoulFist
        )
		baseSFCost = 0;
	}

	override public function get buttonName():String {
		if (isActive())
			return "SoulFist(Off)";
		else
			return "SoulFist(On)";
	}

	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.SoulFist);
	}

	override public function describeEffectVs(target:Monster):String {
		return "Use soulforce to empower your unarmed strikes. Attack will deal greater damage but consume soulforce per hit. (square root of 1% max SF)";
	}

	override public function sfCost():int {
        return baseSFCost;
    }

	override public function toggleOff(display:Boolean = true):void {
		if (display) outputText("You are no longer consuming soulforce to empower your unarmed strikes.");
		player.removeStatusEffect(StatusEffects.SoulFist);
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You coat your limb in soulforce empowering your unarmed strike.\n");
		player.createStatusEffect(StatusEffects.SoulFist, 0, 0, 0, 0);
    }

}
}