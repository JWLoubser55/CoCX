/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Caves.AutomatonScene;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Automaton extends Monster
	{
		public var automatonScene:AutomatonScene = new AutomatonScene();
		
		public function move1MantagoSporeCloud():void {
			
		}
		
		public function move1MantagoGrab():void {
			
		}
		
		public function move1MantagoPunch():void {
			
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.Lustzerking)) move1MantagoSporeCloud();
			else {
				if (!hasStatusEffect(StatusEffects.Lustzerking)) move1MantagoGrab();
				else move1MantagoPunch();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			automatonScene.winningOverAutomaton();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			automatonScene.losingToAutomaton();
		}
		
		public function Automaton() 
		{
			this.a = "the ";
			this.short = "matangom";
			this.imageName = "matango";
			this.long = "You are fighting an Automaton, a mechanical soldier from a long lost underground civilization. While human in shape and proportion her body is strictly made of metal parts. She is equipped with a wild set of energy weapons seemingly to swap between them at random at the worst of times for you to block them, constantly surprising you with her fluid and varied combat style.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 120, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity, 120, 0, 0, 0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_INHUMANLY_WIDE;
			this.butt.type = Butt.RATING_INCONCEIVABLY_BIG;
			this.lowerBody = LowerBody.CAVE_WYRM;
			this.bodyColor = "dark blue";
			this.hairColor = "black";
			this.hairLength = 9;
			initStrTouSpeInte(426, 242, 330, 222);
			initWisLibSensCor(222, 200, 100, -40);
			this.weaponAttack = 150;
			this.weaponName = "double axe";
			this.weaponVerb= "double cleave";
			this.armorName = "scales";
			this.armorDef = 270;
			this.armorMDef = 90;
			this.bonusHP = 1500;
			this.bonusLust = 354;
			this.bonusWrath = 750;
			this.wrath = 130;
			this.lustVuln = .35;
			this.lust = 30;
			this.level = 74;
			this.gems = rand(20) + 40;
			this.drop = new ChainedDrop().
					add(useables.EBONBLO,1/20).
					add(consumables.METHIRC,0.7);
			this.tailType = Tail.CAVE_WYRM;
			this.tailRecharge = 0;
			checkMonster();
		}
	}
}