/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DefiledRavine
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class MinoIncubus extends Monster
	{
		public function minoincubusPheromones():void {
			outputText("The mino incubus smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air, ");
			if(rand(3) == 0) {
				outputText("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if (player.lust > 75) {
					outputText("swallowing it into your mouth without thinking.  ");
					player.takeLustDamage(100 + player.lib/4, true);
				}
				else {
					outputText("feeling your heart beat with desire as your tongue licks the residue from your lips.  ");
					player.takeLustDamage(50 + player.lib/8, true);
				}
			}
			else outputText("right past your head.  ");
			outputText("The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.");
			player.takeLustDamage(100 + player.lib/8, true);
			if(player.hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) {
				if(rand(2) == 0) outputText("\n<b>You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.</b>");
				else outputText("\n<b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>");
				player.takeLustDamage(75+rand(75), true);
			}
		}
		
		public function minoincubusHeadbutt():void {
			outputText("\"<i>Catch,</i>\" the demonic brute growls, moments before attempting to slam his forehead into your own.");
			var damage:Number = (str + weaponAttack) - rand(player.tou * 0.75);
			if (damage <= 0 || player.getEvasionRoll()) {
				outputText(" Luckily, you dodge aside.");
			}
			else {
				outputText(" He impacts with stunning force, leaving you reeling! ");
				damage = Math.round(damage);
				player.takePhysDamage(damage, true);
				//{Stun for one turn, minor HP damage}
				if (!player.hasPerk(PerkLib.Resolute)) {
					outputText(" <b>You're left stunned by the force of the blow!</b>");
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				}
			}
		}
		public function minoincubusDickslap():void {
			//Used after stunning PC.
			outputText("Before you can completely regain your wits, the brute is on you, easily holding your hand in one hand while he none-too-gently smacks his cock into your face, dragging his musky member back and forth across your cheeks before finally breaking contact.");
			outputText(" Strands of his"+(player.hasPerk(PerkLib.MinotaurCumAddict) ? " god-like":"")+" spunk hang from your nose until your tongue lashes out to collect them. "+(player.hasPerk(PerkLib.MinotaurCumAddict) ? "Delicious.":"")+"Why did you do that? And why did it feel so good.");
			player.takeLustDamage(100 + player.lib/8, true);
		}
		
		public function  minoincubusBattleaxes():void {
			outputText("The mino incubus carries his axes as if they weighed no more than a feather, brandishing them back and forth with such casual movements that you barely register his swings");
			var damage:Number = ((str + weaponAttack) * 2.5) - rand(player.tou);
			if (damage <= 0 || player.getEvasionRoll()) {
				outputText(" in time to avoid it.");
			}
			else {
				outputText(". By the time you notice, it’s too late. ");
				damage = Math.round(damage);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void {
			if (player.hasStatusEffect(StatusEffects.FeralDemon))  {
				var choice1:Number = rand(3);
				if (choice1 == 0) eAttack();
				if (choice1 == 1) minoincubusBattleaxes();
				if (choice1 == 2) minoincubusHeadbutt();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.Stunned)) minoincubusDickslap();
				else {
					var choice:Number = rand(4);
					if (choice == 0) eAttack();
					if (choice == 1) minoincubusBattleaxes();
					if (choice == 2) minoincubusHeadbutt();
					if (choice == 3) minoincubusPheromones();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) SceneLib.defiledravine.demonScene.defeatFeralMinoIncubus();
			else SceneLib.defiledravine.demonScene.defeatMinoIncubus();
		}
		
		public function MinoIncubus()
		{
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) {
				this.short = "feral mino incubus";
				this.long = "You are fighting a minotaur-like feral incubus.  Covered in shaggy brown fur, the beast is an imposing sight, wearing little but a loincloth, with a pair of deadly battle axes, is easily eight feet tall.  As a former minotaur he has hooves, a cow-like tail and face, prominent horns, and impressive musculature.";
				this.createCock(rand(5) + 12,1 + rand(2), CockTypesEnum.HORSE);
				initStrTouSpeInte(750, 215, 395, 60);
				initWisLibSensCor(60, 120 + this.ballSize * 2, 45 + this.ballSize * 2, 100);
				this.weaponAttack = 640;
				this.armorDef = 300;
				this.armorMDef = 60;
				this.bonusHP = 250 + rand(this.ballSize);
				this.bonusLust = 165 + this.ballSize * 3 + rand(this.ballSize * 2);
				this.level = 65;
				this.gems = rand(15) + 20;
				this.createPerk(PerkLib.OverMaxHP, 65, 0, 0, 0);
			}
			else {
				this.short = "mino incubus";
				this.long = "You are fighting a minotaur-like incubus.  Covered in shaggy brown fur, the beast is an imposing sight, wearing little but an obviously distended loincloth, with a pair of deadly battle axes, is easily eight feet tall.  As a former minotaur he has hooves, a cow-like tail and face, prominent horns, and impressive musculature.  His huge equine cock is already dripping with precum in anticipation.";
				this.magicuser = true;
				this.createCock(rand(10) + 27,3 + rand(2), CockTypesEnum.HORSE);
				initStrTouSpeInte(500, 430, 395, 120);
				initWisLibSensCor(120, 240 + this.ballSize * 2, 90 + this.ballSize * 2, 100);
				this.weaponAttack = 320;
				this.armorDef = 600;
				this.armorMDef = 120;
				this.bonusHP = 500 + rand(this.ballSize * 2);
				this.bonusLust = 390 + this.ballSize * 5 + rand(this.ballSize * 3);
				this.level = 60;
				this.gems = rand(15) + 15;
				this.createPerk(PerkLib.OverMaxHP, 60, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "minotaur";
			// this.plural = false;
			this.flyer = true;
			this.balls = 2;
			this.ballSize = 5 + rand(10);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(7) + 96;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:"brown"});
			this.skinDesc = "shaggy fur";
			this.hairColor = "brown";
			this.hairLength = 3;
			this.faceType = Face.COW_MINOTAUR;
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 6;
			this.weaponName = "dual axes";
			this.weaponVerb = "cleave";
			this.armorName = "thick fur";
			this.lust = this.ballSize * 3;
			this.lustVuln = 0.84;
			//this.special1 = SceneLib.mountain.minotaurScene.minoPheromones;
			this.tailType = Tail.COW;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new WeightedDrop().
					add(consumables.BROBREW, 1).
					add(weapons.DL_AXE_, 2).
					add(consumables.MINOCUM, 6).
					add(consumables.MINOBLO, 8).
					add(consumables.INCUBID, 10);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
