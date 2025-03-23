/**
 * Created by aimozg on 22.05.2017.
 */
package classes.Scenes.Monsters {
import classes.*;

public class AbstractGolem extends Monster {
	
	public function backhand1(subtype:Number = 0):void {
		outputText(capitalA + short + "'s visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
		var damage:Number = int ((this.str + this.weaponAttack) - rand(player.tou) - player.armorDef);
		if (subtype == 1) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
		}
		if (subtype == 2) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
		}
		//Dodge
		if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
		else
		{
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText(" It hits you square in the chest. ");
			damage = player.takePhysDamage(damage, true);
		}
	}
	protected function backhand2(subtype:Number = 0):void {
		outputText(capitalA + short + " visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
		var damage:Number = int (((this.str + this.weaponAttack) * 6) - rand(player.tou) - player.armorDef);
		if (subtype == 1) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
		}
		if (subtype == 2) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
		}
		//Dodge
		if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
		else
		{
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText(" They hits you square in the chest from a few different angles. ");
			damage = player.takePhysDamage(damage, true);
		}
	}
	protected function overhandSmash1(subtype:Number = 0):void {
		outputText("Raising its fists high overhead, " + a + short + " swiftly dives down bringing it fists down in a punishing strike!");
		var damage:Number = 150 + int(((str + weaponAttack) * 6) - rand(player.tou) - player.armorDef);
		
		if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
		else
		{
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText(" The concussive strikes impacts you with a bonecrushing force. ");
			damage = player.takePhysDamage(damage, true);
		}
	}
	protected function overhandSmash2(subtype:Number = 0):void {
		outputText("Raising their fists high overhead, " + a + short + " swiftly brings them down in a punishing strike!");
		var damage:Number = 150 + int(((str + weaponAttack) * 6) - rand(player.tou) - player.armorDef);
		if (subtype == 1) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
		}
		if (subtype == 2) {
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
		}
		if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
		else
		{
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText(" The concussive strikes impacts you with a bonecrushing force. ");
			damage = player.takePhysDamage(damage, true);
		}
	}
	
	public function AbstractGolem(plural:Boolean) {
		// argument so superclass constructor always called
		this.plural = plural;
		this.lustVuln = 0.01;
		this.createBreastRow(0, 1);
		initGenderless();
		createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
	}
}
}