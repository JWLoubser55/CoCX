/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
//import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class WaizAbi extends Monster
	{
		private function monkeReactsToLustiness():void {
			outputText("Bimbo Monkey stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Emegency Instant Teleportation!!!</i>\"");
			outputText("\n\nMonkey starts to make gesture needed for activation of her skill and then vanish.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function powerUp():void {
			clearOutput();
			flags[kFLAGS.WAIZABI_LVL_UP] = 100;
			strStat.core.value += 9000;
			touStat.core.value += 9000;
			speStat.core.value += 9000;
			intStat.core.value += 9000;
			wisStat.core.value += 9000;
			libStat.core.value += 9000;
			weaponAttack += 9000;
			armorDef += 9000;
			armorMDef += 9000;
			level += 9000;
			HP = maxHP();
			outputText("Staggering back, Bimbo Monkey wastes no time and starts to yelling and yelling and yelling and yelling and yelling (just skip next 5 min of her constantly yelling while her energy steady rising). \"<i>I'm not done yet!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
			SceneLib.combat.combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.WAIZABI_LVL_UP] < 100) {
				powerUp();
				return;
			}
			else {
				if (hpVictory) cleanupAfterCombat();
				else monkeReactsToLustiness();
			}
		}
		
		public function WaizAbi()
		{
			if (flags[kFLAGS.WAIZABI_LVL_UP] == 0) {
				initStrTouSpeInte(20, 20, 20, 50);
				initWisLibSensCor(50, 200, 100, 0);
				this.weaponAttack = 5;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 20;
				this.bonusWrath = 5;
				this.bonusLust = 318;
				this.level = 18;
			}
			if (flags[kFLAGS.WAIZABI_LVL_UP] == 1) {
				initStrTouSpeInte(30, 30, 30, 55);
				initWisLibSensCor(55, 225, 125, 0);
				this.weaponAttack = 15;
				this.armorDef = 15;
				this.armorMDef = 15;
				this.bonusHP = 120;
				this.bonusWrath = 15;
				this.bonusLust = 374;
				this.level = 24;
			}
			if (flags[kFLAGS.WAIZABI_LVL_UP] == 2) {
				initStrTouSpeInte(40, 40, 40, 60);
				initWisLibSensCor(60, 250, 150, 0);
				this.weaponAttack = 25;
				this.armorDef = 25;
				this.armorMDef = 25;
				this.bonusHP = 220;
				this.bonusWrath = 25;
				this.bonusLust = 430;
				this.level = 30;
			}
			if (flags[kFLAGS.WAIZABI_LVL_UP] == 100) {
				initStrTouSpeInte(9020, 9020, 9020, 9050);
				initWisLibSensCor(9050, 9200, 9100, 0);
				this.weaponAttack = 9005;
				this.armorDef = 9005;
				this.armorMDef = 9005;
				this.bonusHP = 9020;
				this.bonusWrath = 905;
				this.bonusLust = 27318;
				this.level = 9018;
			}
			/*this.a = "";
			this.short = "Waiz'abi";
			this.imageName = "waizabi";
			this.long = "You are fighting Waiz'abi. She's a female Sayian.";*/
			this.a = "the ";
			this.short = "bimbo monkey";
			this.imageName = "waizabi";
			this.long = "You are fighting a Bimbo Monkey. Don't let her curves decieve you ;)";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_LARGE + 2;
			this.bodyColor = "light";
			//this.hairColor = "emerald"; - po tym jak z bimbo body zmieni na amazonian body ^^
			this.hairColor = "platinum green";
			this.hairLength = 13;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "skimpy black bikini";
			this.lust = 30;
			this.lustVuln = .8;
			this.drop = NO_DROP;
			//this.tailType = Tail.MONKEY;
			checkMonster();
		}
	}
}
