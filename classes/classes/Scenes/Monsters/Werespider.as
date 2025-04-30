/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Swamp.AbstractSpiderMorph;
import classes.Stats.Buff;
import classes.Scenes.SceneLib;
import classes.internals.*;

import coc.view.CoCButton;

	public class Werespider extends AbstractSpiderMorph
	{
		private var _biteCounter:int = 0;
		
		//VampThirstThousandHands
		//VampThirstHydraulicStr
		
		public function werespiderBite():void {
			if (player.isGargoyle()) {
				outputText("[Themonster] tries to bite you, but quickly steps back, holding a hand to her mouth with a surprised yelp of clear pain. You smirk, amused by her stupidity, did she seriously try to bite your stone skin?");
				takePhysDamage(maxHP() * .1);
			} else if (player.isAlraune()) {
				outputText("[Themonster] tries to bite you but, just as her fang pierce your skin, she shoves you off and starts spitting."
					+ "\n\n"
					+ "\"<i>Your blood tastes like sap and flower nectar. How disgusting! How dare you bear such vile ichors.</i>\""
					+ "\n\n"
					+ "Should you be offended by her reaction? You should be grateful that plant sap is not her favorite.");
				takePhysDamage(10);
			} else {
				addHP(maxHP() * .05);
				var dam:int = this.str * 5;
				for (var i:int = 0; i < _biteCounter; i++) {
					dam += dam * .10;
				}
				_biteCounter++;
				outputText("The werespider bites into your neck and begins drinking her fill. The loud slurping noises she’s exuding is hardly a pleasant noise for such an intimate act. Weirdly enough you feel aroused from this despite the pain.");
				if (silly()) outputText(" You masochist, you.");
				dam = Math.round(dam);
				player.takePhysDamage(dam);
				player.takeLustDamage(10 + rand(9), true);
				if (!player.hasStatusEffect(StatusEffects.AlterBindScroll3)) {
					var drain:Number = Math.round(player.touStat.max * 0.05);
					player.saveHPRatio();
					player.buff("Bat bites").addStats({"tou":-drain}).withText("Bat bites!").combatPermanent();
					player.restoreHPRatio();
					showStatDown( 'tou' );
					if (player.tou <= 1) {
						doNext(SceneLib.combat.endHpLoss);
						return;
					}
				}
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) {
				if (player.buff("Web").isPresent()) werespiderBite();
				else spiderMorphWebAttack();
			}
			if (choice == 1) {
				if (player.hasStatusEffect(StatusEffects.WebSilence)) {
					createStatusEffect(StatusEffects.Attacks, 4, 0, 0, 0);
					eAttack();
				}
				else spiderSilence();
			}
			if (choice == 2) {
				if (!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon() && rand(3) == 0) spiderDisarm();
				else werespiderBite();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.werespiderScene.wonWithWerespider();
		}
		  
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.werespiderScene.lostToWerespider();
		}
		
		public function Werespider() 
		{
			this.a = "the ";
			this.short = "werespider";
			this.imageName = "femalespidermorph";
			this.long = "You are fighting a werespider. She's completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.WERESPIDER;
			this.faceType = Face.SNAKE_FANGS;
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(451, 380, 621, 621);
			initWisLibSensCor(621, 270, 145, 0);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 169;
			this.armorName = "exoskeleton";
			this.armorDef = 600;
			this.armorMDef = 55;
			this.armorValue = 50;
			this.bonusHP = 6000;
			this.bonusLust = 498;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 83;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,2).
					add(consumables.GORGOIL,5);
			checkMonster();
		}
		
	}

}