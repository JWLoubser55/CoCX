/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

import coc.view.CoCButton;

public class Barometz extends Monster
	{
		public function barometzEntangle():void {
			//
		}
		
		public function barometzBriarthorn():void {
			//
		}
		
		public function barometz3():void {
			//
		}
		
		public function barometzHeal():void {
			var temp:Number = inteligencescalingbonus();
			temp = Math.round(temp);
			outputText("The barometz raises her staff and chants a healing spell causing her wound to heal.");
			addHP(temp);
			mana -= 30;
			createStatusEffect(StatusEffects.AbilityCooldown1, 2, 0, 0, 0);
		}
		
		public function barometzKick():void {
			outputText("The barometz suddenly turns over and delivers a vicious kick with her hooves, the impact sending you flying and leaving you dazed.");
			if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			else player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		
		public function barometzStaffWack():void {
			var damage:Number = rand(weaponAttack);
			outputText("The barometz strikes at you with her gnarled staff.");
			damage += eBaseStrengthDamage() * 0.5;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			outputText("\n");
		}
		
		override protected function performCombatAction():void
		{
			if (HPRatio() < .6 && (mana >= 30) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) barometzHeal();
			else {
				var choice:Number = rand(4);
				switch (choice) {
					case 0:
						barometzKick();
						break;
					case 1:
						/*if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) castHealDinah();
						else if (mana >= spellCostArouse()) castArouseDinah();
						else*/ barometzKick();
						break;
					case 2:
						barometzKick();
						break;
					case 3:
						barometzStaffWack();
						break;
					default:
						barometzStaffWack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.barometzScene.barometzDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.forest.barometzScene.barometzDeepwoodsLost();
		}
		
		public function Barometz() 
		{
			this.a = "a ";
			this.short = "barometz";
			this.long = "You are fighting a barometz. This centauress is half plant, half goat and half human. While she pretend to be guarding the area you trespassed in, the excited look in her eyes and the writhing set of green tentacle cocks at her crotch tells you she was really just looking for a good excuse to fuck you. She wields a gnarled wooden staff for a weapon and appears to excel in nature magic.";
			initStrTouSpeInte(32, 430, 32, 181);
			initWisLibSensCor(181, 300, 150, 30);
			this.armorDef = 500;
			this.armorMDef = 50;
			this.bonusHP = 1500;
			this.bonusLust = 500;
			this.level = 50;
			this.drop = new WeightedDrop().
			add(consumables.RAUNENECT,7).
			addMany(1,consumables.HORNFRU,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.imageName = "barometz";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 1;
			this.butt.type = Butt.RATING_JIGGLY + 1;
			this.lowerBody = LowerBody.PLANT_FLOWER;
			this.hairLength = 6;
			this.weaponName = "gnarled wooden staff";
			this.weaponVerb="smack";
			this.weaponAttack = 10;
			this.armorName = "skin";
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.gems = rand(20) + 6;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
