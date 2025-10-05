/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Syth extends Monster
	{
		private function sythLustzerk():void {
			wrath -= 50;
			outputText("Sythril roar and unleash his lustful fury in order to destroy you!\n\n");
			this.weaponAttack += (25 + (5 * flags[kFLAGS.SYTHRIL_LVL_UP]) + ((25 + (5 * flags[kFLAGS.SYTHRIL_LVL_UP])) * (1 + player.newGamePlusMod())));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		private function sythBaseAttack():void {
			var atkCount:Number = 2;
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 6) atkCount += 1;
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 11) atkCount += 1;
			if (hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 20) {
				wrath -= 20;
				createStatusEffect(StatusEffects.Attacks, (atkCount * 2), 0, 0, 0);
			}
			else if (wrath >= 10) {
				wrath -= 10;
				createStatusEffect(StatusEffects.Attacks, atkCount, 0, 0, 0);
			}
			eAttack();
		}
		
		private function sythAttack1():void {
			wrath -= 30;
			var damage:Number = this.weaponAttack;
			damage += eBaseStrengthDamage();
			damage *= (3 + flags[kFLAGS.SYTHRIL_LVL_UP]);
			outputText("Sythril lift it weapons with all his strength and smash them on your head. ");
			if(damage > 0) damage = player.takePhysDamage(damage, true);
			outputText("\n");
		}
		
		private function sythAttack2():void {
			var damage:Number;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Determine if dodged!
			if(player.getEvasionRoll()) {
				outputText("Sythril rushes at you, knocking aside your defensive feint and trying to close the distance between you.  He lashes out at your feet with his tail, and you're only just able to dodge the surprise attack.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str*2) - rand(player.tou) - player.armorDef);
			damage *= (1 + (0.2 * flags[kFLAGS.SYTHRIL_LVL_UP]));
			damage = Math.round(damage);
			//No damage
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("The salamander's tail-swipe harmlessly deflects off your armor!");
				else outputText("The salamander's tail-swipe hits you but fails to move or damage you.");
			}
			//Take Damage
			else outputText("Sythril rushes at you, knocking aside your defensive feint and sliding in past your guard.  He lashes out at your feet with his tail, and you can feel the heated wake of the fiery appendage on your ensuing fall toward the now-smouldering grass. ");
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
			if(damage > 0) damage = player.takeFireDamage(damage, true);
			outputText("\n");
		}
		
		private function sythAttack3():void {
			outputText("Sythril start drawing symbols in the air toward you.");
			var lustDmg:Number = this.lust / 5 + this.lib / 5 + this.inte / 5 + this.wis / 5 + this.sens / 5;
			lustDmg *= (1 + (0.2 * flags[kFLAGS.SYTHRIL_LVL_UP]));
			lustDmg = Math.round(lustDmg);
			player.takeLustDamage(lustDmg, true);
		}
		
		/*private function sythAttack4():void {
			outputText("Salamander ... WIP TEXT !\n\n");
			2nd demonic type attack (cum cannon?)
		}
		
		private function sythAttack5():void {
			outputText("Salamander ... WIP TEXT !\n\n");
			3rd demonic type attack
		}
		
		private function sythUltimateAttack():void {
			outputText("Salamander ... WIP TEXT !\n\n");
			flames of love covering whole body while Sythril slam into PC? lowers lust if Sythril had any, put cooldown for few turns before he can use it again
		}*/
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (25 + (5 * flags[kFLAGS.SYTHRIL_LVL_UP]) + ((25 + (5 * flags[kFLAGS.SYTHRIL_LVL_UP])) * (1 + player.newGamePlusMod())));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			/*var choice2:Number = rand(6);
			if (choice2 == 0) {
				if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) sythBerserk();
				else {
					if (wrath >= 30) sythAttack1();
					else sythBaseAttack();
				}
			}
			if (choice2 == 1) {
				if (rand(2) == 0) sythAttack2();			na późniejsze etapy lvl-nia dla niego ^^
				else sythAttack3();
			}
			if (choice2 >= 2) sythBaseAttack();*/
			var choice1:Number = rand(6);
			if (choice1 == 0) {
				if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) sythLustzerk();
				else {
					/*if (rand(2) == 0) sythAttack4();
					else */sythBaseAttack();
				}
			}
			if (choice1 == 1) {
				if (wrath >= 30) sythAttack1();
				else sythBaseAttack();
			}
			if (choice1 == 2) {
				if (rand(2) == 0) sythAttack2();
				else sythAttack3();
			}/*
			if (choice1 == 3) {
				if (rand(2) == 0) sythAttack4();//some penultimate skill or demon like attack here
				else sythAttack5();
			}*/
			//if (choice1 == 4) sythUltimateAttack();//some super cool channeled or not super attack that will be his ace - smth to mix salamanders and demons style xD
			if (choice1 >= 3) sythBaseAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sythScene.SythrilLostSparring();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.sythScene.SythrilWonSparring();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting Sythril. An eight foot tall corrupted salamander with crimson scales covering his legs, back, and forearms, with a tail swishing menacingly behind him, ablaze with a red-hot fire.  His white hair accents his amber eyes, while his body covers leather armor and pair of large bat-like demon-wings fold behind his shoulders.  His dual BF Swords are raised to his side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at his posture and gaze indicates that he's currently under effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Syth() 
		{
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 1) {
				initStrTouSpeInte(320, 240, 140, 120);
				initWisLibSensCor(120, 240, 50, 70);
				this.weaponAttack = 112;
				this.armorDef = 270;
				this.armorMDef = 90;
				this.bonusHP = 300;
				this.additionalXP = 150;
				this.bonusLust = 175;
				this.level = 30;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 1 && flags[kFLAGS.SYTHRIL_LVL_UP] < 6) {
				var mod:int = flags[kFLAGS.SYTHRIL_LVL_UP] - 1;
				initStrTouSpeInte(320 + 40*mod, 240 + 40*mod, 140 + 23*mod, 120 + 20*mod);
				initWisLibSensCor(120 + 20*mod, 240 + 40*mod, 50 + 30*mod, 70);
				this.weaponAttack = 112 + 15*mod;
				this.armorDef = 270 + 30*mod;
				this.armorMDef = 90 + 10*mod;
				this.bonusHP = 300 + 100*mod;
				this.additionalXP = 150 + 50*mod;
				this.bonusLust = 175 + 77*mod;
				this.level = 30 + 6*mod;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 6) {
				initStrTouSpeInte(520, 440, 255, 220);
				initWisLibSensCor(220, 440, 200, 70);
				this.weaponAttack = 187;
				this.armorDef = 420;
				this.armorMDef = 140;
				this.bonusHP = 800;
				this.additionalXP = 400;
				this.bonusLust = 560;
				this.level = 60;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 7) {
				initStrTouSpeInte(560, 480, 278, 240);
				initWisLibSensCor(240, 480, 230, 70);
				this.weaponAttack = 202;
				this.armorDef = 450;
				this.armorMDef = 150;
				this.bonusHP = 900;
				this.additionalXP = 450;
				this.bonusLust = 637;
				this.level = 66;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 8) {
				
				this.level = 72;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 9) {
				
				this.level = 78;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 10) {
				
				this.level = 84;
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] == 11) {
				
				this.level = 90;
			}
			this.a = "the ";
			this.short = "Sythril";
			this.imageName = "sythril";
			this.long = "";
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 8*12;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.SALAMANDER;
			this.hairColor = "white";
			this.hairLength = 1;
			this.weaponName = "pair of big fucking swords";//later make him wield 'pair of big fucking two handed swords' 
			this.weaponVerb= "slash";
			this.armorName = "scales";
			this.lust = 30;
			this.lustVuln = .2;
			this.gems = 40 + rand(12);
			this.drop = new ChainedDrop().
					add(weapons.DBFSWO,1/50).
					add(armors.LEATHRA,1/20).
					add(consumables.SALAMFW,0.7);
			this.wings.type = Wings.BAT_LIKE_LARGE;
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Berzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 2) {
				this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 3) {
				this.createPerk(PerkLib.JobBeastWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 4) {
				this.createPerk(PerkLib.JobBeastlord, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 5) {
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 6) {
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 7) {
				this.createPerk(PerkLib.LimitBreakerBody1stStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 8) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 9) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 10) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 11) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToSuperiorTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.SYTHRIL_LVL_UP] >= 12) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}