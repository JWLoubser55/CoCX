/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.display.SpriteDb;

public class UnderwaterSharkGirlsPack extends Monster
	{
		private function sharkTease():void {
			game.spriteSelect(SpriteDb.s_izma);
			if(rand(2) == 0) {
				outputText("You charge at the shark girls, prepared to strike again, but stop dead in your tracks when one of them turns around and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takePhysDamage(140+rand(140), true);
				player.takeLustDamage((140+(player.lib/5)), true);
			}
			else {
				outputText("You pull your [weapon] back, getting a swimming start to land another attack. One of shark girls smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you away.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takePhysDamage(140+rand(140), true);
				player.takeLustDamage((70+(player.lib/3)), true);
			}
		}
		private function sharkBiteAttack():void {
			game.spriteSelect(SpriteDb.s_izma);
			outputText("Your opponents takes a turn and charges at you at high speed, jaw open as they goes in for the kill, viciously biting you. You start to bleed in abundance the water around you turning red. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.2, 0, 0);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sharkgirlScene.oceanSharkspackWinChoices();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.sharkgirlScene.sharkspackLossOceanRape();
		}
		
		public function UnderwaterSharkGirlsPack()
		{
			this.a = "the ";
			this.short = "shark-girls pack";
			this.imageName = "izma";
			this.long = "You're under attack by a frenzy of shark girls and the worst part is they all look hungry for sex! The tigershark alpha lead, the pack directing its assault as they all circle around you looking for an opening to draw blood.";
			this.plural = true;
			this.createCock(15,2.2);
			this.balls = 4;
			this.ballSize = 3;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 5*12+4;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.bodyColor = "gray";
			this.hairColor = "silver";
			this.hairLength = 20;
			initStrTouSpeInte(810, 519, 663, 348);
			initWisLibSensCor(348, 405, 144, -20);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 451;
			this.armorName = "tough skin";
			this.armorDef = 920;
			this.armorMDef = 160;
			this.bonusHP = 15000;
			this.bonusLust = 644;
			this.lust = 20;
			this.lustVuln = .5;
			this.level = 95;
			this.gems = rand(30) + 70;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.TSTOOTH,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkBiteAttack;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.WaterNature, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
