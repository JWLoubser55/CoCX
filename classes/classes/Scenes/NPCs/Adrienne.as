/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Adrienne extends Monster
	{
		private function adrienneAttack1():void {
			wrath -= 30;
			var damage:Number = eBaseStrengthDamage() * 2;
			outputText(capitalA + short + " swings her weapons with all her strength and slashes you. ");
			if (damage > 0) {
				if (hasStatusEffect(StatusEffects.FlameBlade)) {
					damage *= 1.1;
					damage = Math.round(damage);
					player.takeFireDamage(damage, true);
					player.takeFireDamage(damage, true);
				}
				else {
					player.takePhysDamage(damage, true);
					player.takePhysDamage(damage, true);
				}
			}
			outputText("\n");
		}
		
		private function adrienneAttack2():void {
			var damage:Number = ((str * 2) - rand(player.tou));
			outputText(capitalA + short + " whips at you with her tail, trying to sear you with her brilliant flames! ");
			if(damage <= 0 || player.getEvasionRoll()) outputText("You evade the strike.");
			else {
				outputText(capitalA + short + "'s tail catches you as you try to dodge.  Your [armor] sizzles, and you leap back with a yelp as she gives you a light burning. ");
				player.takeFireDamage(damage, true);
				if (!player.immuneToBurn()) {
					if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
					else {
						player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(3),0.05,0,0);
						outputText(" Reeling in pain you begin to burn.");
					}
				}
			}
		}
		/*
		private function adrienneAttack3():void {
		
		}
		
		private function adrienneAttack4():void {
		
		}
		
		private function adrienneUltimateAttack1():void {
		
		}
		
		private function adrienneUltimateAttack2():void {
		
		}
		*/
		private function adrienneTripleThrust():void {
			outputText(capitalA + short + " ready " + weaponName + " and prepare to thrust them towards you.  ");
			if (player.getEvasionRoll()) outputText("You evade the strike.");
			else {
				soulforce -= 30;
				outputText(capitalA + short + weaponName + " hits you thrice.");
				adrienneTripleThrust2();
				adrienneTripleThrust2();
				adrienneTripleThrust2();
				adrienneTripleThrust2();
				adrienneTripleThrust2();
				adrienneTripleThrust2();
			}
		}
		private function adrienneTripleThrust2():void {
			var damage:Number = str;
			damage += eBaseStrengthDamage();
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.04));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (3 + ((weaponAttack - 50) * 0.035));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (4.75 + ((weaponAttack - 100) * 0.03));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (6.25 + ((weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((weaponAttack - 200) * 0.02));
			var d2:Number = 0.9;
			d2 += (rand(21) * 0.01);
			damage *= d2;
			var crit:Boolean = false;
			var critChance:int = 15;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			outputText(" ");
			if (hasStatusEffect(StatusEffects.FlameBlade)) player.takeFireDamage(damage, true);
			else player.takePhysDamage(damage, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
		}
		
		private function adrienneFlamesOfLove():void {
			var fireDMG:Number = Math.round(this.lust * 0.9);
			createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			this.lust -= fireDMG;
			fireDMG *= 2;
			outputText(capitalA + short + " starts concentrating on the lust flowing in her body, her veins, while imaging the joy of sharing her flames of love with you. Shortly after that, her lust starts to gather around her hands, getting hotter and hotter till it envelops her hands in flames.\n\n");
			outputText("And with almost orgasmic joy, she sends a wave of flames toward you while mumbling about 'sharing the flames of love'. ");
			player.takeFireDamage(fireDMG, true);
		}
		
		private function adrienneBerserk():void {
			wrath -= 50;
			outputText(capitalA + short + " roars and unleashes her lustful fury in order to destroy you!\n\n");
			this.weaponAttack += (30 + (30 * (1 + player.newGamePlusMod())));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		private function adrienneFlameBlade():void {
			outputText(capitalA + short + " runs her tail across her weapons igniting them with raging flames.\n\n");
			createStatusEffect(StatusEffects.FlameBlade,10,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (15 + (15 * (1 + player.newGamePlusMod())));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			if (flags[kFLAGS.ADRIENNE_LVL_UP] < 1) {
				var choice1:Number = rand(4);
				if (choice1 == 0) {
					if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) adrienneBerserk();
					else {
						if (wrath >= 30) adrienneAttack1();
						else eAttack();
					}
				}
				if (choice1 >= 1) {
					if (!hasStatusEffect(StatusEffects.FlameBlade)) adrienneFlameBlade();
					else {
						if (rand(2) == 0) adrienneAttack2();
						else eAttack();
					}
				}
				if (choice1 == 2) {
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1) && lust >= 50) adrienneFlamesOfLove();
					else eAttack();
				}
				if (choice1 == 3) {
					if (soulforce >= 30) adrienneTripleThrust();
					else eAttack();
				}
			}
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting a salamander – a little over seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her cinnamon hair accents her chestnut brown eyes, while her body covers red qipao with floral motif.  Her scimitars are raised to her side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under the effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Adrienne()
		{
			if (flags[kFLAGS.ADRIENNE_LVL_UP] < 1) {
				initStrTouSpeInte(140, 125, 110, 100);
				initWisLibSensCor(100, 125, 60, 0);
				this.weaponAttack = 41;
				this.armorDef = 50;
				this.armorMDef = 10;
				this.bonusHP = 100;
				this.bonusLust = 200;
				this.level = 15;
			}/*
			if (flags[kFLAGS.ADRIENNE_LVL_UP] == 1) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 0);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 30;
			}
			if (flags[kFLAGS.ADRIENNE_LVL_UP] == 2) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 0);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 45;
			}
			if (flags[kFLAGS.ADRIENNE_LVL_UP] == 3) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 0);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 60;
			}
			if (flags[kFLAGS.ADRIENNE_LVL_UP] == 4) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 0);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 70;
			}*/
			{
				createBreastRow(Appearance.breastCupInverse("II"));
				this.tallness = 87;
				this.hips.type = Hips.RATING_FERTILE + 1;
				this.butt.type = Butt.RATING_JIGGLY + 2;
				this.hairLength = 9;
			}/*
			{
				createBreastRow(Appearance.breastCupInverse("OO"));
				this.tallness = 99;
				this.hips.type = Hips.RATING_FERTILE + 3;
				this.butt.type = Butt.RATING_EXPANSIVE + 1;
				this.hairLength = 39;
			}*/
			{
				this.weaponName = "twin scimitars";
				this.weaponVerb="slash";
				this.armorName = "scales";
			}
			{
				this.a = "the ";
				this.short = "salamander";
			}
			this.imageName = "adrienne";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.bodyColor = "light";
			this.hairColor = "cinnamon";
			this.lust = 30;
			this.lustVuln = .35;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					//add(armors.CHBIKNI,1/20).
					add(weapons.SCIMITR,1/20).
					add(consumables.SALAMFW,0.7);
			this.arms.type = Arms.SALAMANDER;
			this.lowerBody = LowerBody.SALAMANDER;
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.FleshBodyVoLApprenticeStage, 0, 0, 0, 0);
			//if (flags[kFLAGS.ADRIENNE_LVL_UP] >= 1) this.createPerk(PerkLib., 0, 0, 0, 0);
			//if (flags[kFLAGS.ADRIENNE_LVL_UP] >= 2) this.createPerk(PerkLib., 0, 0, 0, 0);
			//if (flags[kFLAGS.ADRIENNE_LVL_UP] >= 3) this.createPerk(PerkLib., 0, 0, 0, 0);
			checkMonster();
		}
	}
}