/**
 * ...
 * @author ...
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.Scenes.SceneLib;
import classes.internals.*;
//import classes.Scenes.Combat.CombatAbilities;

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
			outputText(" She then flips back and launches herself–horns first at you. ");
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
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) moveFeralAttack();
			if (choice == 1) {
				if (hasStatusEffect(StatusEffects.AbilityCooldown1)) moveFeralAttack();
				else moveCero();
			}
			if (choice == 2) {
				moveLightingBolt();
			}
			if (choice == 3) {
				if (hasStatusEffect(StatusEffects.AbilityCooldown2)) moveLightingBolt();
				else moveThunderclap();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			hollow.wonWithWhite();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			hollow.lostToWhite();
		}
		
		public function Hollow() 
		{
			this.a = "the ";
			this.short = "pale hollow";
			this.long = "Your opponent is a Hollow, a lingering spiritual remnant who died before corruption could take them. She looks like a strange mix of cat girl, ghost and baboon of all things. Her feral looking mask hides her face but those piercing white irises submerged in black speaks of her morbid intentions. Aside from her mask, she wears nothing to hide her modesty, displaying an androgynous emaciated figure, though you do spot a pair of flat droopy tits.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 72;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.bodyColor = "pale";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(165, 85, 185, 200);
			initWisLibSensCor(200, 65, 80, 60);
			this.weaponAttack = 108;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "iron skin";
			this.armorDef = 10;
			this.armorMDef = 200;
			this.bonusHP = 100;
			this.bonusLust = 164;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 19;
			this.gems = 15 + rand(10);
			this.drop = new ChainedDrop().add(useables.MMASKFRAG,1);
			this.horns.type = Horns.HOLLOW;
			this.horns.count = 2;
			this.faceType = Face.HOLLOW_MASK;
			this.eyes.type = Eyes.HOLLOW;
			this.arms.type = Arms.HUMAN;
			this.lowerBody = LowerBody.HUMAN;
			this.tailType = Tail.MONKEY;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
			this.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}