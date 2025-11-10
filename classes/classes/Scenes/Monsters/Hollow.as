/**
 * ...
 * @author ...
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;
//import classes.Scenes.Combat.CombatAbilities;

import coc.view.CoCButton;

use namespace CoC;

	public class Hollow extends Monster
	{
		public var hollow:HollowScene = new HollowScene();
		
		public function moveFeralAttack():void {
			outputText("She unleashes a bestial raw, lunging at you. She rakes at you with vicious claws. ");
			eAttack();
			eAttack();
			if (!player.immuneToAcid()) {
                if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
                else player.createStatusEffect(StatusEffects.AcidDoT, 3, 15, 0, 0);
            }
			EngineCore.SoulforceChange(-Math.round(player.maxSoulforce() * 0.05));
			player.refillHunger(-5, false);
			outputText("She then flips back and launches herself–horns first at you. ");
			var hornspoke:Number = this.str;
			hornspoke += eBaseStrengthDamage();
			player.takePhysDamage(hornspoke, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
		}
		
		public function moveCero():void {
			outputText("She flares her soulforce, then concentrates that spiritual energy at the jagged opening of her. At the apex of power, she releases a powerful blast of concentrated spiritual energy towards you. ");
			var ceroDMG:Number = this.wis + this.inte;
			ceroDMG += wisdomscalingbonus();
			ceroDMG += inteligencescalingbonus();
			ceroDMG *= 3;
			player.takeLightningDamage(ceroDMG, true);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
		}
		
		public function moveLightingBolt():void {
			outputText("You feel the mana in the air surge as she forms esoteric hand signs, manifesting sparks form in her clawed hands. The sharp tang of ozone fills the air as she sends lashes of electricity towards you. ");
			var lightningboltDMG:Number = this.wis + this.inte;
			lightningboltDMG += wisdomscalingbonus();
			lightningboltDMG += inteligencescalingbonus();
			lightningboltDMG *= 2;
			player.takeLightningDamage(lightningboltDMG, true);
		}
		
		public function moveThunderclap():void {
			outputText("The mana around you starts to vibrate as her soulforce flares, her hands turn into a blur of hand signs. A dark thunder cloud overcast the both of you as she seems to lose lucidity. A sudden and terrible lightning strike rains down on you. ");
			var thunderclapDMG:Number = this.wis + this.inte;
			thunderclapDMG += wisdomscalingbonus() * 4;
			thunderclapDMG += inteligencescalingbonus() * 4;
			thunderclapDMG *= 10;
			player.takeLightningDamage(thunderclapDMG, true);
			createStatusEffect(StatusEffects.AbilityCooldown2, 8, 0, 0, 0);
			if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			this.takePhysDamage(Math.round(this.maxHP()*0.2));
		}
		
		public function moveStandardFeralAttack():void {
			outputText("It unleashes a bestial raw, lunging at you. Swipe after swipe, it tries to cut you to ribbons with vicious claws that leave you bleeding. ");
			eAttack();
			eAttack();
			if (!player.immuneToAcid()) {
                if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
                else player.createStatusEffect(StatusEffects.AcidDoT, 3, 15, 0, 0);
            }
			var hornspoke:Number = this.str;
			hornspoke += eBaseStrengthDamage();
			player.takePhysDamage(hornspoke, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
		}
		
		public function moveAcidSpit():void {
			outputText("The Hollow’s soulforce flares then coalesces at its stomach. Its flesh bulging and vibrating. Violent bursts of flesh grotesquely grow. Its pupils sharpen to pinpricks, keen focus poised for action. In one violent lunge, its cheeks bulged with vile juices. It spews a torrent of acid! ");
			var acidSpitDMG:Number = this.wis + this.inte;
			acidSpitDMG += wisdomscalingbonus();
			acidSpitDMG += inteligencescalingbonus();
			player.takeAcidDamage(acidSpitDMG, true);
			createStatusEffect(StatusEffects.AbilityCooldown2, 2, 0, 0, 0);
		}
		
		public function moveHollowGrapple():void {
			outputText("It unleashes a bestial raw, lunging at you. Tackling you to the ground, it holds you in a fierce grip. Its claws bite deep into your [skin]. ");
			player.createStatusEffect(StatusEffects.Pounced, 3, 0, 0, 0);
			if (!player.immuneToBleed()) player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.02, 0, 0);
		}
		
		public function hollowPouncedStruggle():void {
			if (SceneLib.combat.struggleCentralizedCheck()) hollowPounceSuccess();
			else hollowPounceFail();
			SceneLib.combat.enemyAIImpl();
		}
		public function hollowPouncedWait():void {
			hollowPounceFail();
			SceneLib.combat.enemyAIImpl();
		}
		private function hollowPounceSuccess():void {
			createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			player.removeStatusEffect(StatusEffects.Pounced);
		}
		private function hollowPounceFail():void {
			player.addStatusValue(StatusEffects.Pounced, 1, -1);
			if (player.getStatusValue(StatusEffects.Pounced, 1) == 0) {
				createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
				player.removeStatusEffect(StatusEffects.Pounced);
				clearOutput();
				outputText("The hollow soulforce flares, then concentrates that spiritual energy in the pits of its gut as it stares down on you in its grip. At the apex of power, it vomits the contents of the stomach. A vile acrid scent fires your senses as flesh starts to melt. ");
				var acidSpitDMG:Number = this.wis + this.inte;
				acidSpitDMG += wisdomscalingbonus() * 0.5;
				acidSpitDMG += inteligencescalingbonus() * 0.5;
				player.takeAcidDamage(acidSpitDMG, true);
				if (!player.immuneToAcid()) {
					if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
					else player.createStatusEffect(StatusEffects.AcidDoT, 3, 15, 0, 0);
				}
			}
		}
		
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.Pounced)) {
				btnStruggle.call(hollowPouncedStruggle);
				btnBoundWait.call(hollowPouncedWait);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.HOLLOW_TYPE] == 0) {
				var choice0:Number = rand(4);
				if (choice0 == 0) moveFeralAttack();
				if (choice0 == 1) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) moveFeralAttack();
					else moveCero();
				}
				if (choice0 == 2) {
					moveLightingBolt();
				}
				if (choice0 == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown2)) moveLightingBolt();
					else moveThunderclap();
				}
			}
			else {
				var choice1:Number = rand(3);
				if (choice1 == 0) {
					if (!player.hasStatusEffect(StatusEffects.Pounced) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) moveHollowGrapple();
					else moveStandardFeralAttack();
				}
				if (choice1 == 1) {
					moveStandardFeralAttack();
				}
				if (choice1 == 2) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown2)) moveStandardFeralAttack();
					else moveAcidSpit();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.HOLLOW_TYPE] == 0) hollow.wonWithWhite();
			else hollow.wonWithHollow();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.HOLLOW_TYPE] == 0) hollow.lostToWhite();
			else hollow.lostToHollow();
		}
		
		public function Hollow() 
		{
			if (flags[kFLAGS.HOLLOW_TYPE] == 0) {
				this.short = "pale hollow";
				this.long = "Your opponent is a Hollow, a lingering spiritual remnant who died before corruption could take them. She looks like a strange mix of cat girl, ghost and baboon of all things. Her feral looking mask hides her face but those piercing white irises submerged in black speaks of her morbid intentions. Aside from her mask, she wears nothing to hide her modesty, displaying an androgynous emaciated figure, though you do spot a pair of flat droopy tits.";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("D"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.bodyColor = "pale";
				this.hairColor = "red";
				initStrTouSpeInte(165, 135, 185, 200);
				initWisLibSensCor(200, 95, 80, 60);
				this.weaponAttack = 108;
				this.armorDef = 10;
				this.armorMDef = 200;
				this.bonusHP = 500;
				this.bonusLust = 194;
				this.level = 19;
				this.gems = 15 + rand(10);
				this.drop = new ChainedDrop().add(consumables.MTMFRAG,1);
				this.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				this.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.HOLLOW_TYPE] == 1 || flags[kFLAGS.HOLLOW_TYPE] == 2) {
				this.short = "hollow";
				this.long = "Your opponent is a Hollow, a lingering spiritual remnant who died before corruption could take them. The androgynous creature looks emaciated, yet its feral appearance keeps you on edge. Its skin is weathered and pale, its bone-white claws at the ready. Its yellow irises stare at you through the darkness of its eyes, searching for weakness.";
				this.createBreastRow(0, 1);
				initGenderless();
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.bodyColor = "pale";
				this.hairColor = "black";
				if (flags[kFLAGS.HOLLOW_TYPE] == 1) {
					initStrTouSpeInte(165, 135, 185, 200);
					initWisLibSensCor(200, 95, 80, 60);
					this.weaponAttack = 108;
					this.armorDef = 50;
					this.armorMDef = 100;
					this.bonusHP = 500;
					this.bonusLust = 194;
					this.level = 19;
					this.gems = 15 + rand(10);
				}
				else {
					initStrTouSpeInte(245, 195, 275, 300);
					initWisLibSensCor(300, 145, 120, 60);
					this.weaponAttack = 148;
					this.armorDef = 75;
					this.armorMDef = 150;
					this.bonusHP = 750;
					this.bonusLust = 296;
					this.level = 31;
					this.gems = 25 + rand(10);
				}
				this.drop = new ChainedDrop().add(consumables.HM_FRAG,1);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.HOLLOW_TYPE] == 3) {
				this.short = "vacant";
				this.long = "Your opponent is a Vacant, a lingering spiritual remnant who died before corruption could take them and intern have consumed others to further itself. The androgynous creature before you is bulky and strong, it has gorged itself to quench the clawing hunger yet its feral appearance keeps you on edge. Its skin is weathered and pale, claws – bone-white and at the ready. Yellow irises stare at you through the darkness of its mask, searching for weakness.";
				this.createBreastRow(0, 1);
				initGenderless();
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.bodyColor = "pale";
				this.hairColor = "black";
			}
			this.a = "the ";
			this.tallness = 72;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "iron skin";
			this.lust = 30;
			this.lustVuln = .8;
			this.horns.type = Horns.HOLLOW;
			this.horns.count = 2;
			this.faceType = Face.HOLLOW_MASK;
			this.eyes.type = Eyes.HOLLOW;
			this.arms.type = Arms.HOLLOW;
			this.lowerBody = LowerBody.HOLLOW;
			this.tailType = Tail.HOLLOW;
			this.tailRecharge = 0;
			checkMonster();
		}
		
	}

}