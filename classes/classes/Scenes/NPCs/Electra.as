/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Electra extends Monster
	{
		public var electraScene:ElectraFollower = SceneLib.electraScene;
		
		public function moveLightningClaw():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" rushes at you with a mad glare, trying to hit you with her claws.");
			HitOrMiss();
			HitOrMiss();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) HitOrMiss();
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) HitOrMiss();
			}
		}
		private function HitOrMiss():void {
			outputText("\n\n");
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" attempts to strike you with her claw.");
			if (player.getEvasionRoll()) {
				outputText("\nThrowing yourself out of the way, you manage to avoid the strike.");
			}
			else {
				var damage:Number = 0;
				damage += eBaseStrengthDamage();
				var damageLust:Number = 0;
				damageLust += Math.round(this.lib / 10);
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
					damage += eBaseStrengthDamage() * 0.8;
					damageLust += Math.round(this.lib / 25);
				}
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) {
						damage += eBaseStrengthDamage();
						damageLust += Math.round(this.lib / 20);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) {
						damage += eBaseStrengthDamage();
						damageLust += Math.round(this.lib / 20);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) {
						damage += eBaseStrengthDamage();
						damageLust += Math.round(this.lib / 20);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) {
						damage += eBaseStrengthDamage();
						damageLust += Math.round(this.lib / 20);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) {
						damage += eBaseStrengthDamage();
						damageLust += Math.round(this.lib / 20);
					}
				}
				outputText(" You are slashed for ");
				player.takePhysDamage(damage, true);
				player.takeLustDamage(damageLust, true);
				outputText(" damage. The lingering electricity on her claws leaves you aroused. <b>([font-lust]" + damageLust + "[/font])</b> lust damage.");
			}
		}
		
		public function moveStaticDischarge():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" touches you with her claw and you feel some of her electricity rush and course through your body, slowly building your arousal. This is very bad! There is no telling how long you will be able to stand it.");
			var discharge:Number = 40 + int(player.effectiveSensitivity()) / 5;
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) discharge += Math.round(player.effectiveSensitivity() / 10);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) discharge += Math.round(player.effectiveSensitivity() / 10);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) discharge += Math.round(player.effectiveSensitivity() / 10);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) discharge += Math.round(player.effectiveSensitivity() / 10);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) discharge += Math.round(player.effectiveSensitivity() / 10);
			if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
				outputText(" Her repeated touches increase the voltage!!!!");
				discharge += 8;
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) discharge += 2;
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) discharge += 4;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) discharge += 4;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) discharge += 4;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) discharge += 4;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) discharge += 4;
				}
				player.takeLustDamage(discharge, true);
			}
			else {
				player.createStatusEffect(StatusEffects.RaijuStaticDischarge, 0, 0, 0, 0);
				player.takeLustDamage(discharge, true);
			}
			outputText("\n\n");
		}
		
		public function moveMasturbate():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			var damageLust:Number = 0;
			damageLust += Math.round(this.lib / 5);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) damageLust += Math.round(this.lib / 20);
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) damageLust += Math.round(this.lib / 10);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) damageLust += Math.round(this.lib / 10);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) damageLust += Math.round(this.lib / 10);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) damageLust += Math.round(this.lib / 10);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) damageLust += Math.round(this.lib / 10);
			}
			player.takeLustDamage(damageLust, true);
			outputText(" gleefully fingers herself while looking at you with a half crazed look.\n\n");
			outputText("\"<i>Do you know... How frustrating it is to be dependant on someone else to achieve release? Ohhhh soon you will find out!</i>\"\n\n");
			outputText("The display left you aroused but likely she's preparing something. <b>([font-lust]" + damageLust + "[/font])</b> lust damage.\n\n");
			lust += maxLust() * 0.25;
			createStatusEffect(StatusEffects.RaijuUltReady,0,0,0,0);
		}
		public function moveOrgasmicLightningBolt():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" screams in pleasure as a bolt of lightning rushes out of her pussy straight toward you.");
			if (player.getEvasionRoll()) {
				outputText(" Throwing yourself out of the way, you manage to avoid the bolt.");
			}
			else {
				var damageLust:Number = 0;
				damageLust += lust * 4;
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) damageLust += lust * 2;
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) damageLust += lust * 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) damageLust += lust * 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) damageLust += lust * 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) damageLust += lust * 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) damageLust += lust * 2;
				}
				damageLust = Math.round(damageLust);
				player.takeLustDamage(damageLust, true);
				outputText(" You are zapped clean but instead of feeling pain, you feel intense electric pleasure coursing through your body as the Raiju shares some of her unbridled arousal. <b>([font-lust]" + damageLust + "[/font])</b> lust damage.");
			}
			lust -= lust * 0.25;
			if (lust < 0) lust = 0;
			removeStatusEffect(StatusEffects.RaijuUltReady);
			createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
		}
		public function moveElectraLightningBolt():void {
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage() * 2.4;
			damage += eBaseWisdomDamage() * 2.4;
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 8) {
				damage += eBaseIntelligenceDamage() * 1.2;
				damage += eBaseWisdomDamage() * 1.2;
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 15) {
				damage += eBaseIntelligenceDamage() * 1.2;
				damage += eBaseWisdomDamage() * 1.2;
			}
			outputText("Electra charge out energy in her hand and then fire it out in the form of a huge bolt of lightning at you.  ");
			damage = Math.round(damage);
			player.takeLightningDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.RaijuUltReady) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				moveOrgasmicLightningBolt();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
					var choice0:Number = rand(3);
					if (choice0 == 0) moveLightningClaw();
					if (choice0 == 1) moveStaticDischarge();
					if (choice0 == 2) moveMasturbate();
				}
				else if (flags[kFLAGS.ELECTRA_LVL_UP] >= 6) {
					var choice2:Number = rand(6);
					if (choice2 < 3) moveLightningClaw();
					if (choice2 == 3) moveStaticDischarge();
					if (choice2 == 4) moveElectraLightningBolt();
					if (choice2 == 5) moveMasturbate();
				}
				else {
					var choice1:Number = rand(5);
					if (choice1 < 3) moveLightningClaw();
					if (choice1 == 3) moveStaticDischarge();
					if (choice1 == 4) moveMasturbate();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else {
				if (flags[kFLAGS.ELECTRA_FOLLOWER] >= 2) electraScene.PlayerSexElectraPostSpar();
				else electraScene.PlayerSexElectra();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.dungeons.riverdungeon.defeatedByRaiju();
			else electraScene.ElectraSexPlayer();
		}
		
		public function Electra()
		{
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "";
				this.short = "Electra";
				this.long = "You are fighting Electra, a lightning imbued weasel morph. She is fiercely masturbating as she looks at you from a distance and you have issues figuring out whenever she is going to strike.";
			}
			else {
				this.a = "the ";
				this.short = "raiju";
				this.long = "You are fighting a Raiju, a lightning imbued weasel morph. She is fiercely masturbating as she looks at you from a distance and you have issues figuring out whenever she is going to strike.";
			}
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(140, 340, 300, 320);
				initWisLibSensCor(320, 560, 400, 60);
				this.weaponAttack = 36;
				this.armorDef = 60;
				this.armorMDef = 80;
				this.bonusHP = 400;
				this.bonusLust = 1000;
				this.level = 34;
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			}
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] < 2) {
					initStrTouSpeInte(150, 250, 240, 320);
					initWisLibSensCor(320, 370, 270, 60);
					this.weaponAttack = 40;
					this.armorDef = 20;
					this.armorMDef = 28;
					this.bonusHP = 150;
					this.bonusLust = 676;
					this.level = 36;
				}
				else if (flags[kFLAGS.ELECTRA_LVL_UP] == 18) {
					initStrTouSpeInte(610, 940, 930, 1240);
					initWisLibSensCor(1240, 1750, 960, 60);
					this.weaponAttack = 232;
					this.armorDef = 250;
					this.armorMDef = 350;
					this.bonusHP = 1875;
					this.bonusLust = 2884;
					this.level = 138;
				}
				else {	//leave min and max levels to easily balance npc combat
					var electraLvl:Number = flags[kFLAGS.ELECTRA_LVL_UP]-1;
					initStrTouSpeInte(150 + 20*electraLvl, 250 + 30*electraLvl, 240 + 30*electraLvl, 320 + 40*electraLvl);
					initWisLibSensCor(320 + 40*electraLvl, 370 + 60*electraLvl, 270 + 30*electraLvl, 60);
					this.weaponAttack = 40 + 7*electraLvl;
					this.armorDef = 20 + 10*electraLvl;
					this.armorMDef = 28 + 14*electraLvl;
					this.bonusHP = 150 + 75*electraLvl;
					this.bonusLust = 676 + 96*electraLvl;
					this.level = 30 + 6*electraLvl;
				}
			}
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "light";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "indecent spider silk robe";
			this.lust = 30;
			this.lustVuln = .8;
			this.gems = 400 + rand(150);
			this.drop = new ChainedDrop().
					add(armors.INDESSR,1/10).
					add(consumables.L_DRAFT,1/4).
					add(consumables.VOLTTOP,0.7);
			this.rearBody.type = RearBody.RAIJU_MANE;
			this.arms.type = Arms.RAIJU;
			this.lowerBody = LowerBody.RAIJU;
			this.tailType = Tail.RAIJU;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (!player.hasStatusEffect(StatusEffects.RiverDungeonA)) this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 12 && flags[kFLAGS.ELECTRA_LVL_UP] < 19) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEromancer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicIntelligence, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) {
				this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EromancyBeginner, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 9) {
				this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicWisdom, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) {
				this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) {
				this.createPerk(PerkLib.EromancyExpert, 0, 0, 0, 0);
				this.createPerk(PerkLib.LimitBreakerHeart1stStage, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.LimitBreakerPsyche1stStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 13) {
				this.createPerk(PerkLib.HalfStepToInhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 14) {
				this.createPerk(PerkLib.EromancyMaster, 0, 0, 0, 0);
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 15) {
				this.createPerk(PerkLib.LegendaryIntelligence, 0, 0, 0, 0);
				this.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 16) {
				this.createPerk(PerkLib.InhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 17) {
				this.createPerk(PerkLib.LimitBreakerHeart2ndStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 18) {
				this.createPerk(PerkLib.LegendaryWisdom, 0, 0, 0, 0);
				this.createPerk(PerkLib.LimitBreakerPsyche2ndStage, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}
