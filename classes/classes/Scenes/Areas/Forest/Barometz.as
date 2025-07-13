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
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" raises its staff causing the plants to suddenly grow taller as the whole area becomes an entanglement.");
			player.createStatusEffect(StatusEffects.Tentagrappled, 0, 0, 0, 0);
		}
		public function baroGrappleStruggle():void {
			clearOutput();
			outputText("You struggle to break from from the entanglement ");
			if (SceneLib.combat.struggleCentralizedCheck()) {
				outputText("and succeed!");
				player.removeStatusEffect(StatusEffects.Tentagrappled);
			}
			else outputText("in vain.");
			SceneLib.combat.enemyAIImpl();
		}
		public function baroGrappleWait():void {
			clearOutput();
			outputText("Why bother resisting? Theres no way you can escape this anyway.\n\n");
			SceneLib.combat.enemyAIImpl();
		}
		
		public function barometzBriarthorn():void {
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" raises its staff causing the plants to grow sharp poisonous thorns that tear at your flesh! You begin to bleed badly!");
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
				else player.createStatusEffect(StatusEffects.IzmaBleed, 4, 0, 0, 0);
			}
			if (player.hasStatusEffect(StatusEffects.Briarthorn)) player.addStatusValue(StatusEffects.Briarthorn, 1, 1);
			else player.createStatusEffect(StatusEffects.Briarthorn, 4, 0, 0, 0);
			player.addCurse("tou", 20, 2);
		}
		
		public function barometzDeathBlossom():void {
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" raises its staff causing the plants to bloom into flowers that release a large cloud of pollen. You begin to gag almost immediately fuck this shit is poisonous. To your horror your skin also flush with arousal as the insidious aphrodisiacs flood your system!");
			var damage:Number = (3 * inteligencescalingbonus()) + (3 * wisdomscalingbonus());
			player.takeLustDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.DeathBlossom)) player.addStatusValue(StatusEffects.DeathBlossom, 1, 1);
			else player.createStatusEffect(StatusEffects.DeathBlossom, 4, 1, 0, 0);
			player.addCurse("tou", 20, 2);
		}
		
		public function barometzHeal():void {
			var temp:Number = inteligencescalingbonus();
			temp = Math.round(temp);
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" raises her staff and chants a healing spell causing her wound to heal.");
			addHP(temp);
			mana -= 30;
			createStatusEffect(StatusEffects.AbilityCooldown1, 2, 0, 0, 0);
		}
		
		public function barometzKick():void {
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" suddenly turns over and delivers a vicious kick with her hooves, the impact sending you flying and leaving you dazed.");
			if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			else player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		
		public function barometzStaffWack():void {
			var damage:Number = rand(weaponAttack);
			outputText(""+(silly()?"Baro Kiteer":"The barometz")+" strikes at you with her gnarled staff.");
			damage += eBaseStrengthDamage() * 0.5;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			outputText("\n");
		}
		
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
				btnStruggle.call(baroGrappleStruggle);
				btnBoundWait.call(baroGrappleWait);
			}
		}

		override protected function performCombatAction():void
		{
			if (HPRatio() < .6 && (mana >= 30) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) barometzHeal();
			else if (!player.hasStatusEffect(StatusEffects.Tentagrappled)) barometzEntangle();
			else {
				if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
					player.addStatusValue(StatusEffects.Tentagrappled, 1, 1);
					if (player.statusEffectv1(StatusEffects.Tentagrappled) > 7) player.removeStatusEffect(StatusEffects.Tentagrappled);
				}
				var choice:Number = rand(4);
				switch (choice) {
					case 0:
						barometzBriarthorn();
						break;
					case 1:
						barometzDeathBlossom();
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
			if (silly()) {
				this.a = "a ";
				this.short = "barometz";
				this.drop = new WeightedDrop().
				add(weapons.GNARLEDS,10).
				add(consumables.HORNFRU,5).
				addMany(1,consumables.HORNFRU,
						consumables.HEALHERB,
						consumables.HEALHERB,
						consumables.HEALHERB,
						consumables.MOONGRASS,
						consumables.SNAKEBANE,
						consumables.IRONWEED,
						consumables.BLADEFERN);
			}
			else {
				this.a = " ";
				this.short = "Baro Kiteer";
				this.drop = new WeightedDrop().
				add(weapons.GNARLEDS, 10).
				add(consumables.HORNFRU, 3).
				add(useables.DUCATS_, 3);
			}
			this.long = "You are fighting "+(silly()?"Baro Kiteer":"a barometz")+". This centauress is half plant, half goat and half human. While she pretend to be guarding the area you trespassed in, the excited look in her eyes and the writhing set of green tentacle cocks at her crotch tells you she was really just looking for a good excuse to fuck you. She wields a gnarled wooden staff for a weapon and appears to excel in nature magic.";
			initStrTouSpeInte(32, 430, 32, 181);
			initWisLibSensCor(181, 300, 150, 30);
			this.armorDef = 500;
			this.armorMDef = 50;
			this.bonusHP = 1500;
			this.bonusLust = 500;
			this.level = 50;
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
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
