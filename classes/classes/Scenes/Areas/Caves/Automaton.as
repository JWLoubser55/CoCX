/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Automaton extends Monster
	{
		override public function interruptAbility():void {
			if (hasStatusEffect(StatusEffects.Uber)) removeStatusEffect(StatusEffects.Uber);
		}

		public function moveAutomatonWaterfowlDance():void {
			if (!hasStatusEffect(StatusEffects.Uber)) {
				outputText("The automaton draws her energy sword and leap in the air time almost slowing down as her arm pulls back for a spinning motion.");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
			else {
				var dodged:Boolean = false;
				removeStatusEffect(StatusEffects.Uber);
				createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
				outputText("Information Noona congratulate you for using Wait command as it neglated enemy very dangerous move entirely.  ");
				outputText("She suddenly leap at you spinning and striking her sword motion almost too fast for the eye to keep up with!  ");
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				outputText("\n\nJust as you thought she was done she pulls back again from the other side moving along with you as her sword spin around at inhuman speed!  ");
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				if (Combat.playerWaitsOrDefends() && player.getEvasionRoll()) if (!dodged) dodged = true;
				else dmgWaterfowlDance();
				outputText("\n\nFinally her blade goes for a high to low arc slashing five more times in a motion so rapid you just can't avoid it instantly breaking through whatever was left of your defense!  ");
				dmgWaterfowlDance();
				dmgWaterfowlDance();
				dmgWaterfowlDance();
				dmgWaterfowlDance();
				dmgWaterfowlDance();
				if (dodged) outputText("\n\nThanks to observing your opponent you managed to avoid some of the attacks albeit not all of them.  ");
				if (flags[kFLAGS.PRIMARY_DIFFICULTY] >= 7 || flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) outputText("\n\nShe also seem to have healed a good part of her hit point!  ");
				else if (silly()) outputText("\n\nShe also seems to have healed all her hit points… nevermind wait no that would have been too horrible to deal with.  ");
			}
		}
		private function dmgWaterfowlDance():void {
			var damage:int = this.weaponAttack;
			damage + eBaseStrengthDamage() * 2;
			damage + eBaseSpeedDamage();
			var crit:Boolean = false;
			if (rand(4) == 0) {
				crit = true;
				damage = Math.round(damage * 1.75);
			}
			else damage = player.takeFireDamage(damage, true);
			if (crit) {
				outputText("<b>(crit)</b>");
				if (flags[kFLAGS.PRIMARY_DIFFICULTY] >= 7 || flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) addHP(Math.round(maxHP() * 0.1));
			}
		}
		
		public function moveAutomatonLaserSpear():void {
			outputText("The automaton suddenly grabs you by the collar and sends you flying upward before drawing her spear at the last second and viciously trusting upward impaling you on the blade. With inhuman strength she throws your badly bleeding body off her spear sending you flying a few meters off.  ");
			var damage:int = this.weaponAttack;
			damage + eBaseStrengthDamage() * 2;
			damage + eBaseSpeedDamage();
			damage = player.takeFireDamage(damage, true);
			if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			else player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
		}
		
		public function moveAutomatonLaserGun():void {
			outputText("She draw her gun firing a salvo of glowing energy shot at you.  ");
			var damage:int = this.weaponRangeAttack * 5;
			damage += eBaseWisdomDamage() * 3;
			damage += eBaseIntelligenceDamage() * 2;
			damage += eBaseSpeedDamage();
			if (player.isFlying()) damage *= 2;
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			if (player.isFlying() && player.statusEffectv2(StatusEffects.Flying) == 0) {
				outputText("As your wings are shot you crash to the ground! ");
				player.removeStatusEffect(StatusEffects.Flying);
			}
		}
		
		public function moveAutomatonLaserBlade():void {
			outputText("She draws her sword and cross slash's you so fast you fail to avoid it.  ");
			var damage:int = this.weaponAttack;
			damage + eBaseStrengthDamage() * 2;
			damage + eBaseSpeedDamage();
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
		}
		
		public function moveAutomatonTaser():void {
			outputText("She suddenly spins toward you exposing a long tail like appendage that makes a sizzling sound as its tip makes contact with you delivering a paralyzing discharge!  ");
			var damage:int = eBaseIntelligenceDamage() * 0.5 + eBaseWisdomDamage() * 0.25;
			damage = player.takeLightningDamage(damage, true);
			if (player.hasPerk(PerkLib.Resolute)) {
				outputText("Despite your stoicism you fail to fully negate the stun!  ");
				player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			}
			else player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Uber)) {
				moveAutomatonWaterfowlDance();
				return;
			}
			var choice:Number = rand(5);
			if (choice == 0) {
				if (!player.hasStatusEffect(StatusEffects.Stunned)) {
					if (rand(2) == 0) moveAutomatonLaserBlade();
					else moveAutomatonLaserGun();
				}
				else moveAutomatonTaser();
			}
			if (choice == 1) moveAutomatonLaserBlade();
			if (choice == 2) moveAutomatonLaserGun();
			if (choice == 3) {
				if (!player.hasStatusEffect(StatusEffects.Stunned)) {
					if (rand(2) == 0) moveAutomatonLaserBlade();
					else moveAutomatonLaserGun();
				}
				else moveAutomatonLaserSpear();
			}
			if (choice == 4) {
				if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
					if (rand(2) == 0) moveAutomatonLaserBlade();
					else moveAutomatonLaserGun();
				}
				else moveAutomatonWaterfowlDance();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.automatonScene.winningOverAutomaton();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.automatonScene.losingToAutomaton();
		}
		
		public function Automaton() 
		{
			this.a = "the ";
			this.short = "automaton";
			this.imageName = "automaton";
			this.long = "You are fighting an Automaton, a mechanical soldier from a long lost underground civilization. While human in shape and proportion her body is strictly made of metal parts. She is equipped with a wild set of energy weapons seemingly to swap between them at random at the worst of times for you to block them, constantly surprising you with her fluid and varied combat style.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity, 60, 0, 0, 0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_JIGGLY;
			this.bodyColor = "quicksilver";
			this.hairColor = "neon blue";
			this.hairLength = 9;
			initStrTouSpeInte(626, 442, 550, 422);
			initWisLibSensCor(422, 400, 200, -40);
			this.weaponAttack = 150;
			this.weaponName = "sword";
			this.weaponVerb= "slash";
			this.weaponAttack = 150;
			this.weaponName = "sword";
			this.weaponVerb= "slash";
			this.weaponRangeAttack = 150;
			this.weaponRangeName = "gun";
			this.weaponRangeVerb= "shot";
			this.armorName = "steel skin";
			this.armorDef = 900;
			this.armorMDef = 900;
			this.bonusHP = 5000;
			this.bonusLust = 674;
			this.wrath = 130;
			this.lustVuln = .65;
			this.lust = 30;
			this.level = 74;
			this.gems = rand(20) + 40;
			this.drop = new ChainedDrop()
					.add(weaponsrange.ENERGYG,0.1)
					.add(weaponsrange.ENERGYG,0.1)
					.add(weaponsrange.ENERGYG,0.1)
					.add(null,0.7);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}