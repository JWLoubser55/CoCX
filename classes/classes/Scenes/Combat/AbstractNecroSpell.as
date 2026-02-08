package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractNecroSpell extends AbstractSpell {
	public function AbstractNecroSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_NECRO;
	}
	
	override public function manaCost():Number {
		return spellCostBlack(baseManaCost);
	}
	
	public function demonBonesCost():int {
		return 0;
	}
	
	override public function costDescription():Array {
		var costs:/*String*/Array = super.costDescription().concat();
		if (demonBonesCost() > 0) {
			costs.push("Bones Cost: "+demonBonesCost());
		}
		return costs;
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (demonBonesAvailable() < demonBonesCost() && !player.hasPerk(PerkLib.BoneSoul) && !player.hasPerk(PerkLib.Equilibrium)) {
			return "You don't have enough demon bones to use any this necromancer spell.";
		}
		if (player.statusEffectv2(StatusEffects.Sealed) == 10) {
			return "Your ability to use necromantic magic was sealed."
		}
		
		return "";
	}
	
	////////////
	// Utilities
	////////////
	
	/**
	 * Consume bones.
	 * This method should not be called in useResources but in doSpellEffect
	 * after power calculation instead; otherwise boneSoulBonus won't calculate correctly
	 */
	protected function consumeBones(count:int):void {
		addDemonBones(-Math.min(demonBonesAvailable(),count));
	}
	
	public static function demonBonesAvailable():int {
		if (player.hasPerk(PerkLib.JobHaruspex)) return player.perkv1(PerkLib.JobHaruspex);
		else return 0;
	}
	
	public static function addDemonBones(delta:int):void {
		player.addPerkValue(PerkLib.JobHaruspex, 1, delta);
	}
	
	public static function boneSoulBonus(bonesCost:int):Number {
		if (!player.hasPerk(PerkLib.BoneSoul)) return 1.0;
		var bones:int = demonBonesAvailable();
		if (bones < 50) return 1.0
		var bonus:Number = Math.round((bones - 50) / 10);
		if (bonus >= 3.0) bonus = 3.0;
		return 1.0 + bonus;
	}
}
}
