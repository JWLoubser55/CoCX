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
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.EtnaFollower;
import classes.internals.*;
import classes.Scenes.Combat.CombatAbilities;

use namespace CoC;

	public class Etna extends Monster
	{
		public var etnaScene:EtnaFollower = SceneLib.etnaScene;

		public function moveClawCombo():void {
			var countitgood:Number = 2;
			if (flags[kFLAGS.ETNA_LVL_UP] >= 5) countitgood += 2;
			if (flags[kFLAGS.ETNA_LVL_UP] >= 10) countitgood += 2;
			if (flags[kFLAGS.ETNA_LVL_UP] >= 15) countitgood += 2;
			createStatusEffect(StatusEffects.Attacks, countitgood, 0, 0, 0);
			eAttack();
		}

		public function moveTailSpike():void {
			TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 6) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 9) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 12) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 15) TailSpike();
		}
		public function TailSpike():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText("'s tail curls over and shoots a spike at you. The bony spike ");
			if (rand(100) < (this.spe - player.spe) / 2) {
				if (CombatAbilities.EAspectAir.isActive()) {
					outputText("hits wind wall doing no damage to you.");
					CombatAbilities.EAspectAir.advance(true);
				}
				else {
					var tailspikedmg:Number = Math.round(this.str / 10);
					var lustdmg:Number = Math.round(this.lib / 4);
					player.addCombatBuff('spe',-4, "Manticore Venom", "ManticoreVenom");
					outputText("hits the mark dealing ");
					player.takePhysDamage(tailspikedmg, true);
					outputText(" damage and poisoning you. Your movements slow down and you feel extremely aroused. ");
					player.takeLustDamage(lustdmg, true);
				}
			}
			else {
				outputText("misses its mark.");
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) outputText("\n\n");
		}

		public function moveTakeFlight():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" takes flight, aiming with her tail as she prepares to unleash a volley of spikes at you!");
			createStatusEffect(StatusEffects.Flying,7,0,0,0);
		}

		public function moveBoobCrash():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna flies down");
			else outputText("The flying manticore dives");
			outputText(" in your direction crashing into you breasts first! For a few seconds you go red in confusion and arousal as your face is lost in her cleavage then she pulls off leaving you dazed and aroused as she readies her next attack!");
			var boobcrashdmg:Number = Math.round(this.str / 6);
			var lustdmg:Number = Math.round(this.lib / 2);
			player.takeLustDamage(lustdmg, true);
			player.takePhysDamage(boobcrashdmg, true);
			if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			removeStatusEffect(StatusEffects.Flying);
		}

		public function moveBite():void {
			var bitedmg:Number = Math.round(this.str / 20);
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" bites into your ");
			if (hasStatusEffect(StatusEffects.Pounce)) outputText("arm");
			else if (player.lowerBody == 26) outputText("tentacle");
			else outputText("tail");
			outputText(" making you yelp in surprise. She breaks out of the grapple grinning. You took ");
			player.takePhysDamage(bitedmg, true);
			outputText(" damage!");
			if (hasStatusEffect(StatusEffects.Constricted)) removeStatusEffect(StatusEffects.Constricted);
			if (hasStatusEffect(StatusEffects.ConstrictedScylla)) removeStatusEffect(StatusEffects.ConstrictedScylla);
			if (hasStatusEffect(StatusEffects.Pounce)) removeStatusEffect(StatusEffects.Pounce);
		}

		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla)) {
				moveBite();
			}
			else if (statusEffectv1(StatusEffects.Flying) == 3) {
				moveBoobCrash();
			}
			else if (hasStatusEffect(StatusEffects.Flying)) {
				moveTailSpike();
			}
			else {
				var choice:Number = rand(10);
				if (choice < 5) moveClawCombo();
				if (choice > 4 && choice < 8) moveTailSpike();
				if (choice > 7) moveTakeFlight();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] >= 2 && EtnaFollower.EtnaInfidelity != 2) etnaScene.etnaRapeIntro2();
			else if (flags[kFLAGS.ETNA_AFFECTION] > 75) etnaScene.etnaReady2Come2Camp();
			else if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1 && flags[kFLAGS.ETNA_AFFECTION] > 15) etnaScene.etnaRape3rdWin();
			else etnaScene.etnaRapeIntro();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) etnaScene.etnaRapeYandere();
			etnaScene.etnaRapesPlayer();
		}

		override public function get long():String {
			var str:String = "";
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				if (hasStatusEffect(StatusEffects.Flying)) str += "Etna is circling you in the air readying a salvo of spike to throw at you.";
				else str += "Etna is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			}
			else {
				if (hasStatusEffect(StatusEffects.Flying)) str += "The manticore is circling you in the air readying a salvo of spike to throw at you.";
				else str += "The manticore is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			}
			return str;
		}

		public function Etna()
		{
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Etna";
				this.long = "";
			}
			else {
				this.a = "the ";
				this.short = "manticore";
				this.long = "";
			}
			if (flags[kFLAGS.ETNA_LVL_UP] < 1) {
				initStrTouSpeInte(210, 265, 370, 190);
				initWisLibSensCor(190, 380, 180, 60);
				this.weaponAttack = 44;
				this.armorDef = 24;
				this.armorMDef = 6;
				this.bonusHP = 140;
				this.bonusLust = 596;
				this.level = 36;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 1 && flags[kFLAGS.ETNA_LVL_UP] < 10) {
				var etnaLvl:Number = flags[kFLAGS.ETNA_LVL_UP];
				initStrTouSpeInte(210 + 20*etnaLvl, 265 + 30*etnaLvl, 370 + 60*etnaLvl, 190 + 30*etnaLvl);
				initWisLibSensCor(180 + 30*etnaLvl, 380 + 50*etnaLvl, 180 + 30*etnaLvl, 60);
				this.weaponAttack = 44 + 8*etnaLvl;
				this.armorDef = 24 + 8*etnaLvl;
				this.armorMDef = 6 + 2*etnaLvl;
				this.bonusHP = 140 + 60*etnaLvl;
				this.bonusLust = 596 + 86*etnaLvl;
				this.level = 36 + 6*etnaLvl;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 17) {
				initStrTouSpeInte(550, 775, 1390, 700);
				initWisLibSensCor(700, 1230, 690, 60);
				this.weaponAttack = 180;
				this.armorDef = 160;
				this.armorMDef = 40;
				this.bonusHP = 1160;
				this.bonusLust = 2058;
				this.level = 138;
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
			this.hairColor = "red";
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "skimpy black bikini";
			this.lust = 30;
			this.lustVuln = .8;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.S_SWMWR,1/12).
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			this.wings.type = Wings.MANTICORE_LARGE;
			this.rearBody.type = RearBody.LION_MANE;
			this.arms.type = Arms.LION;
			this.lowerBody = LowerBody.LION;
			this.tailType = Tail.MANTICORE_PUSSYTAIL;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 11 && flags[kFLAGS.ETNA_LVL_UP] < 18) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 1) this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 4) this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 7) this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 9) {
				this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 10) this.createPerk(PerkLib.LimitBreakerHeart1stStage, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 11) {
				this.createPerk(PerkLib.HalfStepToInhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LimitBreakerPsyche1stStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 13) this.createPerk(PerkLib.InhumanSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 14) {
				this.createPerk(PerkLib.NakedTruth, 0, 0, 0, 0);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 15) {
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 16) this.createPerk(PerkLib.LimitBreakerHeart2ndStage, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 17) {
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.LimitBreakerPsyche2ndStage, 0, 0, 0, 0);
			}
			checkMonster();
		}

	}

}
