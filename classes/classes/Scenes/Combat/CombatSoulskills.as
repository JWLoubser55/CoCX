/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.Weapons.Tidarion;
import classes.Monster;
import classes.PerkLib;
import classes.Races;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.AetherTwinsFollowers;
import classes.Scenes.NPCs.Jojo;
import classes.Scenes.NPCs.JojoScene;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;
import classes.Items.JewelryLib;

public class CombatSoulskills extends BaseCombatContent {
	private var multiTrustDNLag:Number = 0;
	public function CombatSoulskills() {
	}

	internal function soulskillCooldownImpl(duration:int = 2, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	internal function soulskillTier2CooldownImpl(duration:int = 4, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	internal function soulskillTier3CooldownImpl(duration:int = 10, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	private function sfT():Number {
		var sfT:Number = 0.8;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 3) sfT -= 0.1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4) sfT -= 0.1;
		return sfT;
	}

	internal function soulskillModImpl():Number {
		var modss:Number = 1;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.hasPerk(PerkLib.SoulApprentice)) modss += .1;
		if (player.hasPerk(PerkLib.SoulPersonage)) modss += .1;
		if (player.hasPerk(PerkLib.SoulWarrior)) modss += .1;
		if (player.hasPerk(PerkLib.SoulSprite)) modss += .2;
		if (player.hasPerk(PerkLib.SoulScholar)) modss += .2;
		if (player.hasPerk(PerkLib.SoulGrandmaster)) modss += .2;
		if (player.hasPerk(PerkLib.SoulElder)) modss += .4;
		if (player.hasPerk(PerkLib.SoulExalt)) modss += .4;
		if (player.hasPerk(PerkLib.SoulOverlord)) modss += .4;
		if (player.hasPerk(PerkLib.SoulTyrant)) modss += .6;
		if (player.hasPerk(PerkLib.SoulKing)) modss += .6;
		if (player.hasPerk(PerkLib.SoulEmperor)) modss += .6;
		if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) modss += .25;
		if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) modss += .5;
		if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) modss += .75;
		if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) modss += 1;
		if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) modss += 1.25;
		if (player.hasPerk(PerkLib.SeersInsight)) modss += player.perkv1(PerkLib.SeersInsight);
		if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modss *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
		if (player.hasPerk(PerkLib.InariBlessedKimono)) modss += ((100 - player.cor) * .01);
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) modss += (player.cor * .01);
		if (player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) modss += (player.perkv1(PerkLib.MummyLord) * 0.05);
		if (player.hasPerk(PerkLib.DaoOfTraning) && player.perkv1(PerkLib.DaoOfTraning) > 1) modss += (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) * 0.001;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 1) modss += .2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2) modss += .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 3) modss += .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4) modss += .1;
		if (player.necklaceName == "Yin Yang Amulet") modss += .15;
		if (player.armorName == "Traditional clothes") modss += .4;
		if (player.headJewelry == headjewelries.DEATHPR) modss += .2;
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .2;
			}
			else {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .4;
			}
		}
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2 && player.soulforce >= Math.round(player.maxSoulforce() * sfT())) modss *= 2;
		if (player.hasPerk(PerkLib.MunchkinAtClosedDoorsCultivation)) modss *= 2;
		modss = Math.round(modss * 100) / 100;
		return modss;
	}

	internal function soulskillPhysicalModImpl():Number {
		var modssp:Number = player.psoulskillPowerStat.value;
		var modsspb:Number = 1;
		if (soulskillMod() > 1) modsspb += soulskillMod() - 1;
		if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssp += .5;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssp += .5;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssp += .5;
		}
		if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssp += 1;
			if (player.hasPerk(PerkLib.SoulScholar)) modssp += 1;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssp += 1;
		}
		if (player.hasPerk(PerkLib.FleshBodyElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssp += 1.5;
			if (player.hasPerk(PerkLib.SoulExalt)) modssp += 1.5;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssp += 1.5;
		}
		if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssp += 2;
			if (player.hasPerk(PerkLib.SoulKing)) modssp += 2;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssp += 2;
		}
		if (player.hasPerk(PerkLib.FleshBodyTyrantStage)) {
			if (player.hasPerk(PerkLib.SoulAncestor)) modssp += 2.5;
		}
		if (player.hasPerk(PerkLib.FleshBodyFoMApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssp += 1.25;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssp += 1.25;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssp += 1.25;
		}
		if (player.hasPerk(PerkLib.FleshBodyFoMWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssp += 2.5;
			if (player.hasPerk(PerkLib.SoulScholar)) modssp += 2.5;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssp += 2.5;
		}
		if (player.hasPerk(PerkLib.FleshBodyFoMElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssp += 3.75;
			if (player.hasPerk(PerkLib.SoulExalt)) modssp += 3.75;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssp += 3.75;
		}
		if (player.hasPerk(PerkLib.FleshBodyFoMOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssp += 5;
			if (player.hasPerk(PerkLib.SoulKing)) modssp += 5;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssp += 5;
		}
		if (player.hasPerk(PerkLib.FleshBodyFoMTyrantStage)) {
			if (player.hasPerk(PerkLib.SoulAncestor)) modssp += 6.25;
		}
		if (player.hasStatusEffect(StatusEffects.MartialTraining) && player.statusEffectv2(StatusEffects.MartialTraining) > 3) modssp += (0.1 * (player.statusEffectv2(StatusEffects.MartialTraining) - 3));
		if (player.hasPerk(PerkLib.BrutalBlows)) modssp += 0.05;
		if (player.perkv1(IMutationsLib.HumanBonesIM) >= 4 && player.racialScore(Races.HUMAN) > 17) modssp += 1;
		if (player.hasAetherTwinsTierWeaponMSword() || player.hasAetherTwinsTierWeaponLSword() || player.hasAetherTwinsTierWeaponLSpear() || player.hasAetherTwinsTierWeaponLScythe()) modssp += 0.4;
		if (player.hasAetherTwinsTierLeftSword() || player.hasAetherTwinsTierLeftSpear() || player.hasAetherTwinsTierLeftScythe()) modssp += 0.4;
		if (modsspb > 1) modssp *= modsspb;
		modssp = Math.round(modssp * 100) / 100;
		return modssp;
	}

	internal function soulskillMagicalModImpl():Number {
		var modssm:Number = player.msoulskillPowerStat.value;
		var modssmb:Number = 1;
		if (soulskillMod() > 1) modssmb += soulskillMod() - 1;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssm += .5;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssm += .5;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssm += .5;
		}
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssm += 1;
			if (player.hasPerk(PerkLib.SoulScholar)) modssm += 1;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssm += 1;
		}
		if (player.hasPerk(PerkLib.DaoistElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssm += 1.5;
			if (player.hasPerk(PerkLib.SoulExalt)) modssm += 1.5;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssm += 1.5;
		}
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssm += 2;
			if (player.hasPerk(PerkLib.SoulKing)) modssm += 2;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssm += 2;
		}
		if (player.hasPerk(PerkLib.DaoistTyrantStage)) {
			if (player.hasPerk(PerkLib.SoulAncestor)) modssm += 2.5;
		}
		if (player.hasPerk(PerkLib.DaoistMDHiFApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssm += 1.25;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssm += 1.25;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssm += 1.25;
		}
		if (player.hasPerk(PerkLib.DaoistMDHiFWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssm += 2.5;
			if (player.hasPerk(PerkLib.SoulScholar)) modssm += 2.5;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssm += 2.5;
		}
		if (player.hasPerk(PerkLib.DaoistMDHiFElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssm += 3.75;
			if (player.hasPerk(PerkLib.SoulExalt)) modssm += 3.75;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssm += 3.75;
		}
		if (player.hasPerk(PerkLib.DaoistMDHiFOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssm += 5;
			if (player.hasPerk(PerkLib.SoulKing)) modssm += 5;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssm += 5;
		}
		if (player.hasPerk(PerkLib.DaoistMDHiFTyrantStage)) {
			if (player.hasPerk(PerkLib.SoulAncestor)) modssm += 6.25;
		}
		if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 2) {
			var wfb:Number = 0.5;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 3) wfb += 0.25;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) wfb += 0.25;
			if (player.tailCount >= 3) wfb *= 2;
			modssm += wfb;
		}
		if (player.hasPerk(PerkLib.DaoOfTraning)) modssm += (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) * 0.01;
		if (player.hasPerk(PerkLib.BrutalSpells)) modssm += 0.1;
		if (player.perkv1(IMutationsLib.HumanSmartsIM) >= 4 && player.racialScore(Races.HUMAN) > 17) modssm += 1;
		if (player.shieldName == "spirit focus") modssm += .25;
		if (player.armor == armors.DEATHPO) modssm += .5;
		if (player.armor == armors.DEATHPGA) modssm += 2;
		if (player.hasAetherTwinsTierWeaponLSword() || player.hasAetherTwinsTierWeaponLStaff()) modssm += 0.4;
		if (player.hasAetherTwinsTierLeftStaff() || (player.shield == shields.AETHERS && (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Large Spears"))) modssm += 0.4;
		if (modssmb > 1) modssm *= modssmb;
		modssm = Math.round(modssm * 100) / 100;
		return modssm;
	}

	internal function soulskillcostmultiImpl():Number {
		var multiss:Number = 1;
		if (player.level >= 27 && player.wis >= 100) multiss += 1;//początek używania Dao of Elements
		if (player.level >= 54 && player.wis >= 200) multiss += 1;//początek zdolności latania
		if (player.level >= 78 && player.wis >= 300) multiss += 1;//początek tworzenia klonów
		//if (player.level >= 126 && player.wis >= 400) multiss += 1;//początek czegoś tam
		multiss = Math.round(multiss * 100) / 100;
		return multiss;
	}

	internal function soulskillCostImpl():Number {
		var modssc:Number = player.soulskillcostStat.value;
		if (soulskillMod() > 1) {
			if (player.hasPerk(PerkLib.MunchkinAtClosedDoorsCultivation)) modssc += (soulskillMod() - 1) * 0.05;
			else modssc += (soulskillMod() - 1) * 0.1;
		}
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistElderStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) modssc -= .1;
		if (player.headJewelry == headjewelries.FOXHAIR) modssc -= .2;
		if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modssc -= (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.02);
		if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) modssc -= .1;
		if (player.perkv1(IMutationsLib.HumanParathyroidGlandIM) >= 4 && player.racialScore(Races.HUMAN) > 17) modssc -= .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2 && player.soulforce >= Math.round(player.maxSoulforce() * sfT())) modssc *= 1.5;
		if (modssc < 0.1) modssc = 0.1;
		modssc = Math.round(modssc * 100) / 100;
		return modssc;
	}
	/*
	 * Code needed for later so would stay here for a while more
	 * 
	public function spellMight(silent:Boolean = false):void {
		var doEffect:Function = function():* {
			var MightBoostCap:Number = 1.5;
			MightBoostCap *= player.intStat.core.max;
			MightBoostCap = Math.round(MightBoostCap);
			var MightBoost:Number = player.intStat.core.value;
			//MightBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells
			if (MightBoost < 10) MightBoost = 10;
			if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
			MightBoost *= spellModBlack();
			//MightBoost = FnHelpers.FN.logScale(MightBoost,MightABC,10);
			MightBoost = Math.round(MightBoost);
			if (MightBoost > MightBoostCap) MightBoost = MightBoostCap;
			var MightDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) MightDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) MightDuration += 5;
			tempTou = MightBoost;
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) tempInt = Math.round(MightBoost * 1.25);
			else tempStr = MightBoost;
			var oldHPratio:Number = player.hp100/100;
			var buffValues:Object = {"tou.mult":tempTou/100};
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				buffValues["int.mult"] = Math.min( tempInt/100, player.intStat.mult.value/2);
			} else {
				buffValues["str.mult"] = Math.min( tempStr/100, player.strStat.mult.value/2);
			}
			player.buff("Might").setStats(buffValues).combatTemporary(MightDuration);
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
		};
		if (silent)	{ // for Battlemage
			doEffect.call();
			return;
		}
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (50 * spellMightCostMultiplier())) player.HP -= (50 * spellMightCostMultiplier());
		else useMana((50 * spellMightCostMultiplier()),6);
		var tempStr:Number = 0;
		var tempTou:Number = 0;
		var tempInt:Number = 0;
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxOverLust() && !SceneLib.combat.tyrantiaTrainingExtension()) doNext(endLustLoss);
		else enemyAI();
	}*/
	/*
	//Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	public function mantisMultiSlash():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var mMSC:Number = 25;
		var mMSAC:Number = 1;
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) mMSC *= 0.8;
		if (player.hasPerk(PerkLib.PhantomStrike)) mMSC *= 2;
		if (monster.plural) fatigue(physicalSpecialsCost(mMSC*3), USEFATG_PHYSICAL);
		else fatigue(physicalSpecialsCost(mMSC), USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You ready your wrists mounted scythes and prepare to sweep them towards [themonster].\n\n");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attacks!\n\n");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attacks with superior quickness!\n\n");
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attacks.\n\n");
			enemyAI();
			return;
		}
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 1) mMSAC += 1;
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 2) mMSAC += 1;
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 3 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 3) mMSAC += 2;
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 4 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 4) mMSAC += 4;
		if (monster.plural) mMSAC *= 4;
		flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = mMSAC;
		mantisMultipleAttacks();
	}
	public function mantisMultipleAttacks():void {
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(2);
		//adjusting to be used 60/105% of base speed while attacking depending on insect-related perks possesed
		if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) damage *= 1.75;
		//bonuses if fighting multiple enemies
		if (monster.plural) {
			if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 1) damage *= 1.75;
			else damage *= 1.15;
		}
		//other bonuses
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 2;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = combat.gallopDamageBoost(damage);
		damage = combat.physicalAbilityDamageAmplification(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		doPlayerPhysDamage(damage);
		outputText("Your scythes swiftly sweeps against [themonster], dealing <b>[font-damage]" + damage + "[/font]</b> damage!");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doPlayerPhysDamage(damage);
			outputText(" (<b>[font-damage]" + damage + "[/font]</b>)");
			damage *= 2;
		}
		outputText("\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] >= 1) {
			flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
			mantisMultipleAttacks();
			return;
		}
		outputText("\n");
		enemyAI();
	}
	 public function tripleThrust():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;//fizyczny atak
	 clearOutput();
	 if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
	 outputText("<b>Your current soulforce is too low.</b>");
	 doNext(combatMenu);
	 return;
	 }
	 outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
	 if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
	 enemyAI();
	 return;
	 }
	 var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
	 soulforcecost = Math.round(soulforcecost);
	 player.soulforce -= soulforcecost;
	 var damage:Number = 0;
	 damage += combat.meleeDamageNoLagSingle();
	 damage *= 1.75;
	 //other bonuses
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
	 if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
	if (player.armor == armors.SPKIMO) damage *= 1.2;
	if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
	if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
	if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= soulskillPhysicalMod();
	 doPlayerPhysDamage(damage);
	 outputText("Your [weapon] hits thrice against [themonster], dealing <b>[font-damage]" + damage + "[/font]</b> damage! ");
	 checkAchievementDamage(damage);
	 combat.WrathGenerationPerHit2(5);
	 combat.heroBaneProc(damage);
	 outputText("\n\n");
	 if (monster.HP <= monster.minHP()) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}