package classes.Scenes.Areas.DefiledRavine 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class FeralDemonHellHound extends Monster
	{
		protected function demonhellhoundFire():void {
			//Blind dodge change
			if(player.getEvasionRoll()) {
				outputText("Both feral demon hellhound's heads breathe in deeply before blasting a wave of emerald green flames at you.  You easily avoid the wave, diving to the side and making the most of your talents at evasion.");
			}
			else {
				//Determine the damage to be taken
				var temp:Number = (tou + inte + rand(10)) * 5;
				temp = Math.round(temp);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard,1,-1);
					temp *= 0.2;
					outputText("Both feral demon hellhound's heads breathe in deeply before blasting a wave of emerald green flames at you. While the flames don't burn much due to protection of blizzard, the unnatural heat fills your body with arousal. ");
				}
				else outputText("Both feral demon hellhound's heads breathe in deeply before blasting a wave of emerald green flames at you. While the flames don't burn much, the unnatural heat fills your body with arousal. ");
				temp = Math.round(temp);
				player.takeFireDamage(temp, true);
				player.takeLustDamage(100+(player.effectiveSensitivity()/8), true);
				statScreenRefresh();
				if(Math.round(player.HP) <= Math.round(player.minHP())) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
				if(player.lust >= player.maxOverLust() && !SceneLib.combat.tyrantiaTrainingExtension()) {
					doNext(SceneLib.combat.endLustLoss);
					return;
				}
			}
			doNext(EventParser.playerMenu);
		}
		protected function demonhellhoundScent():void {
			if(player.hasStatusEffect(StatusEffects.NoFlee)) {
				if(spe > 800) {
					demonhellhoundFire();
					return;
				}
				else {
					outputText("The feral demon hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.");
					speStat.core.value += 235;	
				}
			}
			else {
				speStat.core.value += 235;
				outputText("The feral demon hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...");
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}
		}
		

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.defiledravine.demonScene.defeatFeralDemonHellhound();
		}
		
		public function FeralDemonHellHound() 
		{
			this.a = "the ";
			this.short = "feral demon hellhound";
			this.imageName = "hellhound";
			this.long = "It looks like a large feral demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top, small demon horns and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  You get the feeling that reasoning with this beast will be impossible.";
			// this.plural = false;
			this.createCock(8,2,CockTypesEnum.DOG);
			this.createCock(8,2,CockTypesEnum.DOG);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 5;
			// this.hoursSinceCum = 0;
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 47;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.DOG;
			this.skin.growFur({color:"black"});
			this.hairColor = "red";
			this.hairLength = 3;
			initStrTouSpeInte(562, 562, 470, 5);
			initWisLibSensCor(5, 327, 277, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.armorName = "thick fur";
			this.weaponAttack = 300;
			this.armorDef = 990;
			this.armorMDef = 180;
			this.bonusHP = 4000;
			this.bonusLust = 673;
			this.lust = 25;
			this.level = 69;
			this.gems = 25+rand(7);
			this.drop = new WeightedDrop().add(consumables.CANINEP, 3)
					.addMany(1, consumables.BULBYPP,
							consumables.KNOTTYP,
							consumables.BLACKPP,
							consumables.DBLPEPP,
							consumables.LARGEPP);
			this.horns.type = Horns.DEMON;
			this.horns.count = 4;
			this.tailType = Tail.DOG;
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: demonhellhoundFire, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_FIRE]},
				{call: demonhellhoundScent, type: ABILITY_SPECIAL, range: RANGE_SELF, tags:[]},
			];
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 69, 0, 0, 0);
			checkMonster();
		}
	}
}