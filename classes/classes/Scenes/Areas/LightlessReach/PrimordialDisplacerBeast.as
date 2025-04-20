/**
 * ...
 * @author Ormael, name idea: Lord Shadeogorath
 */
package classes.Scenes.Areas.LightlessReach 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class PrimordialDisplacerBeast extends Monster
	{
		public function movePrimodialDisplacerBeastPhaseTentacleStrike():void {
			outputText("The primodial displacer beast blinks out and appears next to you as it begins slapping you with its back tentacles.");
            for (var i:int = 1; i < 2; ++i) {
                outputText("\n\nThe primodial displacer beast slaps you! ");
                phaseslapDmg();
            }
		}
		private function phaseslapDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage *= 5;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
		}

		public function movePrimodialDisplacerBeastPhaseStrike():void {
			outputText("The primodial displacer beast blinks out and appears right behind you as it begins mauling you with its claws.");
            for (var i:int = 1; i < 2; ++i) {
                outputText("\n\nThe primodial displacer beast claws you! ");
                phasestrikeDmg();
            }
		}
		private function phasestrikeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage *= 10;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
		}

		override public function preMeleeMissed():void{
			outputText("The primodial displacer beast teleports, dodging your attack.\n");
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.displacerbeastScene.displacerBeastVictory();
		}
		
		public function PrimordialDisplacerBeast() 
		{
			this.a = "the ";
			this.short = "primordial displacer beast";
			this.imageName = "displacer beast";
			this.long = "This strange cat boy has two pairs of arms ending with clawed paws. From his back grows two pairs of long tentacles similar to that of a calamari. He growls aggressively at you like a feral beast.";
			this.createCock(5,1,CockTypesEnum.DISPLACER);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 72;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "";
			this.hairColor = "";
			this.hairLength = 9;
			initStrTouSpeInte(756, 256, 630, 86);
			initWisLibSensCor(86, 120, 120, -40);
			this.weaponAttack = 240;
			this.weaponName = "claws";
			this.weaponVerb= "slash";
			this.armorDef = 200;
			this.armorMDef = 200;
			this.armorName = "fur";
			this.bonusHP = 500;
			this.bonusLust = 324;
			this.wrath = 130;
			this.lustVuln = .35;
			this.lust = 30;
			this.level = 84;
			this.gems = rand(30) + 100;
			this.drop = new ChainedDrop().
					add(useables.EBONBLO,1/20).
					add(consumables.D_FRUIT,0.7);
			this.abilities = [
				{ call: movePrimodialDisplacerBeastPhaseStrike, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY] },
				{ call: movePrimodialDisplacerBeastPhaseTentacleStrike, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY] },
			];
			this.createStatusEffect(StatusEffects.EvasiveTeleport, 240, 0, 0, 0);
			checkMonster();
		}
	}
}
