/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class ChiChi extends Monster
	{
		public var chichiScene:ChiChiFollower = SceneLib.chichiScene;
		
		public function PentaStrike():void {
			outputText("Chi Chi unleashes a devastating combo at you. ");
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			if (!player.hasPerk(PerkLib.Resolute) && flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2) {
				outputText(" You stagger under the violent force of the consecutive impacts, unable to recover your balance.");
				player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] >= 2) outputText(" Thankfully your training with her helped you learn how to counter most of these attacks and you manage to weaken her normally overwhelming blows.");
			outputText("\n\n");
		}
		public function SimpleStrike():void {
			var damage:Number = 0;
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2 || flags[kFLAGS.CHI_CHI_LVL_UP] >= 7) {
				damage += eBaseStrengthDamage() * 2;
				damage += eBaseDamage() * 2;
				if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 12) {
					damage += eBaseStrengthDamage() * 2;
					damage += eBaseDamage() * 2;
				}
				if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 17) {
					damage += eBaseStrengthDamage() * 2;
					damage += eBaseDamage() * 2;
				}
			}
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2 || (flags[kFLAGS.CHI_CHI_LVL_UP] >= 2 && flags[kFLAGS.CHI_CHI_LVL_UP] < 7)) {
				damage += eBaseStrengthDamage() * 1.4;
				damage += eBaseDamage() * 1.4;
			}
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 && flags[kFLAGS.CHI_CHI_LVL_UP] < 2) {
				damage += eBaseStrengthDamage() * 0.8;
				damage += eBaseDamage() * 0.8;
			}
			if (player.hasStatusEffect(StatusEffects.Stunned)) damage *= 1.5;
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.inte <= 200) critChance += this.inte / 10;
			if (this.inte > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		public function DefensiveStance():void {
			outputText("The mouse seems to be in rough shape. However, instead of dropping down and admitting defeat like most of your foes, she resumes standing and howls with rage; Her fire increasing in size as she goes berserk her body glowing with a halo the color of blood. However... she clearly looks to be suffering. Her gaze meet yours with a death stare that leaves you shaken.\n\n");
			outputText("\"<i>Come at me ‘champion’ of Ingnam!!!</i>\"\n\n");
			outputText("She slam her left foot in the ground with such terrifying strength it creates a 1 feet deep crater before rushing toward you, this is going to hurt! <b>There is an obsessed fury about her, like she is determined to defeat you at all costs. Perhaps you should surrender before someone gets killed?</b>");
			createStatusEffect(StatusEffects.DefendMonsterVer, 50, 0.9, 0, 0);
		}
		
		public function Regeneration():void {
			outputText("To your surprise, Chi Chi’s wounds start closing!");
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 17) createStatusEffect(StatusEffects.MonsterRegen, 5, 6, 0, 0);
			else if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 12) createStatusEffect(StatusEffects.MonsterRegen, 5, 4, 0, 0);
			else createStatusEffect(StatusEffects.MonsterRegen, 5, 2, 0, 0);
		}
		
		public function SoulBlast():void {
			if (!hasStatusEffect(StatusEffects.AbilityChanneled)) {
				outputText("You see Chi Chi assuming a stance and waving soul art signs, - characteristic of a deadly attack you don’t recognise - it's obviously a dangerous technique. The best option would be to dodge it.");
				createStatusEffect(StatusEffects.AbilityChanneled, 0, 0, 0, 0);
			}
			else {
				removeStatusEffect(StatusEffects.AbilityChanneled);
				if (Combat.playerWaitsOrDefends()) {
					outputText("When Chi Chi unleashes a torrent of soulforce energy at you, you’ve already dodged out of the way, predicting her move. The attack leaves a massive hole where you stood earlier. You are glad you moved out of the way!");
				}
				else {
					outputText("Chi Chi’s palms fill with a massive sphere of red energy which suddenly explodes in a devastating beam of concentrated soul force. You see the devastating torrent a mere fraction of a second before it hits you. Your defences are shattered, utterly unable to stop it as the energy overwhelms you. The blast barely leaves you intact.");
					player.takePhysDamage(500000000000000);
					player.takeMagicDamage(500000000000000);
				}
			}
		}
		
		override protected function performCombatAction():void {
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 20) {
				if ((this.HPRatio() < 0.5 || this.lust > this.maxLust() * 0.5) && !hasStatusEffect(StatusEffects.DefendMonsterVer)) DefensiveStance();
				else PentaStrike();
			}
			else {
				if (hasStatusEffect(StatusEffects.AbilityChanneled)) SoulBlast();
				else {
					if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3) {
						var choice1:Number = rand(5);
						if (choice1 < 3) PentaStrike();
						if (choice1 == 3) {
							if (hasStatusEffect(StatusEffects.MonsterRegen)) PentaStrike();
							else Regeneration();
						}
					}
					else {
						var choice2:Number = rand(5);
						if (choice2 < 3) PentaStrike();
						if (choice2 == 3) {
							if (hasStatusEffect(StatusEffects.MonsterRegen)) PentaStrike();
							else Regeneration();
						}
						if (choice2 == 4) SoulBlast();
					}
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 3) chichiScene.WonSparringFight();
			else if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) chichiScene.WonSecondFight();
			else chichiScene.WonFirstFight();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 3) chichiScene.LostSparringFight();
			else if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) chichiScene.LostSecondFight();
			else chichiScene.LostFirstFight();
		}

		override public function get long():String {
			var str:String = "";
			str += "Chi Chi is a mouse morph, albeit a strange one. Her fists, tail, and even legs are on fire! She has pink fur and bright red hair which always seems on the verge of  catching fire. She wears a pair of gauntlets and a qipao, characteristic of her homeland.";
			if (hasStatusEffect(StatusEffects.DefendMonsterVer)) str += " Chi Chi appears to be in great pain but keeps fighting on with little regards for her wounds. It would be smart to surrender so she doesn’t go so far as to kill herself for an arena match!</b>";
			return str;
		}
		
		public function ChiChi()
		{
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2) {
				initStrTouSpeInte(630, 630, 610, 400);
				initWisLibSensCor(400, 190, 160, 0);
				this.weaponAttack = 140;
				this.armorDef = 10;
				this.armorMDef = 100;
				this.bonusHP = 25000;
				this.bonusLust = 408;
				this.level = 58;
			}
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 && flags[kFLAGS.CHI_CHI_LVL_UP] < 2) {
				initStrTouSpeInte(180, 180, 160, 220);
				initWisLibSensCor(220, 120, 80, 0);
				this.weaponAttack = 60;
				this.armorDef = 10;
				this.armorMDef = 100;
				this.bonusHP = 5000;
				this.bonusLust = 222;
				this.level = 22;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 2) {
				initStrTouSpeInte(260, 260, 240, 250);
				initWisLibSensCor(250, 140, 100, 0);
				this.weaponAttack = 72;
				this.armorDef = 11;
				this.armorMDef = 110;
				this.bonusHP = 6000;
				this.bonusLust = 271;
				this.level = 31;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 3) {
				initStrTouSpeInte(340, 340, 320, 280);
				initWisLibSensCor(280, 160, 120, 0);
				this.weaponAttack = 88;
				this.armorDef = 12;
				this.armorMDef = 120;
				this.bonusHP = 8000;
				this.bonusLust = 320;
				this.level = 40;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 4) {
				initStrTouSpeInte(420, 420, 400, 310);
				initWisLibSensCor(310, 180, 140, 0);
				this.weaponAttack = 100;
				this.armorDef = 13;
				this.armorMDef = 130;
				this.bonusHP = 10000;
				this.bonusLust = 369;
				this.level = 49;
			}
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2 || flags[kFLAGS.CHI_CHI_LVL_UP] == 5) {
				initStrTouSpeInte(500, 500, 480, 340);
				initWisLibSensCor(340, 200, 160, 0);
				this.weaponAttack = 112;
				this.armorDef = 15;
				this.armorMDef = 150;
				this.bonusHP = 12000;
				this.bonusLust = 418;
				this.level = 58;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 6) {
				initStrTouSpeInte(560, 560, 540, 370);
				initWisLibSensCor(370, 220, 180, 0);
				this.weaponAttack = 120;
				this.armorDef = 20;
				this.armorMDef = 200;
				this.bonusHP = 15000;
				this.bonusLust = 464;
				this.level = 64;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 7) {
				initStrTouSpeInte(620, 620, 600, 400);
				initWisLibSensCor(400, 240, 200, 0);
				this.weaponAttack = 130;
				this.armorDef = 25;
				this.armorMDef = 250;
				this.bonusHP = 20000;
				this.bonusLust = 510;
				this.level = 70;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 8) {
				initStrTouSpeInte(680, 680, 660, 430);
				initWisLibSensCor(430, 260, 220, 0);
				this.weaponAttack = 140;
				this.armorDef = 30;
				this.armorMDef = 300;
				this.bonusHP = 25000;
				this.bonusLust = 556;
				this.level = 76;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 9 && flags[kFLAGS.CHI_CHI_LVL_UP] < 18) {
				var mod:int = (flags[kFLAGS.CHI_CHI_LVL_UP] - 8);
				initStrTouSpeInte(680 + 60*mod, 680 + 60*mod, 660 + 60*mod, 430 + 30*mod);
				initWisLibSensCor(430 + 30*mod, 260 + 20*mod, 220 + 20*mod, 0);
				this.weaponAttack = 140 + 14*mod;
				this.armorDef = 30 + 10*mod;
				this.armorMDef = 300 + 100*mod;
				this.bonusHP = 25000 + 1000*mod;
				this.bonusLust = 556 + 46*mod;
				this.level = 76 + 6*mod;
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] == 18) {
				initStrTouSpeInte(1280, 1280, 1260, 730);
				initWisLibSensCor(730, 460, 420, 0);
				this.weaponAttack = 280;
				this.armorDef = 130;
				this.armorMDef = 1300;
				this.bonusHP = 35000;
				this.bonusLust = 1016;
				this.level = 136;
			}
			this.a = "";
			this.short = "Master Chi Chi of the four winds";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			this.skinColor = "light";
			this.hairColor = "pinkish red";
			this.hairLength = 13;
			this.weaponName = "master gloves";
			this.weaponVerb="punch";
			this.armorName = "qipao";
			this.lust = 30;
			this.lustVuln = .8;
			this.gems = 45 + rand(40);
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2) this.drop = NO_DROP;
			else this.drop = new ChainedDrop().add(consumables.FIERYS_, 0.2);
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 20) this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 12 && flags[kFLAGS.CHI_CHI_LVL_UP] < 19) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 9) this.createPerk(PerkLib.LimitBreakerFlesh1stStage, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 10) this.createPerk(PerkLib.LimitBreakerPsyche1stStage, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 11) this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 12) {
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 13) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 14) this.createPerk(PerkLib.LimitBreakerFlesh2ndStage, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 15) this.createPerk(PerkLib.LimitBreakerPsyche2ndStage, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 16) this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 17) this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_LVL_UP] >= 18) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			checkMonster();
		}
		
	}
}
