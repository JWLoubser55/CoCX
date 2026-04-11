/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class StellaFollower extends NPCAwareContent
{
	
	public function StellaFollower() 
	{}
//goblin that have all traits of succubus (up to 12 tiny horns) and atavism mutation of double bat wings ^^, very flat due to not have yet any daughters so she also pretty horny all the time and desperate to get pregnant
//cursed by ezekiel so in combat or outside combat it apply on enemies/potential studs Ezekiel Curse causing life drain, looking for stud that can not start dying due to curse (those with Ezekiel Blessing perk)
//other side effect of curse will be her giving birth to exactly copies of her so already been succubus goblin like looking daughters ^^

public function StellaMainMenu():void {
	clearOutput();
	outputText("Hearing your steps, she turns toward you, admiring you with her heartshaped pupils before speaking in a sultry tone.\n\n");
	outputText("\"<i>Do you need something from this lil one "+player.mf("master","mistress")+"?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", StellaMainMenuAppearance);
	//addButton(4, "Spar", stellaSparsWithPC).hint("Ask Stella for a mock battle.")
	//	.disableIf((flags[kFLAGS.PLAYER_COMPANION_1] == "Stella" || flags[kFLAGS.PLAYER_COMPANION_2] == "Stella"), "You can't fight against her as long she's in your team.")
	//	.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	addButton(14, "Back", camp.campSlavesMenu);
}

public function StellaMainMenuAppearance():void {
	clearOutput();
	outputText("Stella is a 4ft tall green skinned corrupted goblin. She has long, orange hair and bangs draping at the side of her face as the rest is styled into a flowing pair of twin ponytails, parted by a pair of pointed ears and three pairs of tiny demonic horns. Her face humanoid in appearance with plump, orange lips and sharp teeth behind them. A long, orange tongue occasionally peeks out from her lips, easily reaching two feet at full length.  Her eyes are gleaming amber in color.\n\n");
	outputText("She has human-shaped arms with her pointy, claw-like demonic nails painted orange in color. Two normal, well-formed legs grow down from her hips ending in mostly human feet, apart from the horns protruding straight down from the heel, as the base of her spine extends into a spade-tipped tail swaying behind her. Her waspish hips sway side to side in a graceful stride, drawing attention to her jiggly bottom. Two pairs of large bat-like demon-wings fold behind her shoulders.\n\n");
	outputText("She wears a white and gold corset, similar in appearance to inquisitor's corset, showing off her lean musculature and body covered with various demonic pleasure runes.\n\n");
	outputText("She has small A cup breasts. Her nipples are orange in color.\n\n");
	outputText("Between her legs is a lubricant drooling amber vagina. It has been magically altered to be like succubus and take insertions of any size with no trouble. She has a 1 inch clit.\n\n");
	outputText("She has a tight anus between her cheeks right where it should be.\n\n");
	menu();
	addButton(14, "Back", StellaMainMenu);
}

public function stellaSparsWithPC():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	startCombat(new Syth());
}

public function stellaWonSparring():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	cleanupAfterCombat();
}

public function stellaLostSparring():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");/*
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.STELLA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.STELLA_LVL_UP] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction), 0, 0);
			flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.STELLA_LVL_UP] = 2;
		}
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.STELLA_LVL_UP] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
			flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.STELLA_LVL_UP] = 3;
		}
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.STELLA_LVL_UP] == 3) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3), 0, 0);
			flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.STELLA_LVL_UP] = 4;
		}
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.STELLA_LVL_UP] == 4) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4), 0, 0);
			flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.STELLA_LVL_UP] = 5;
		}
		if (flags[kFLAGS.STELLA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.STELLA_LVL_UP] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5), 0, 0);
			flags[kFLAGS.STELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.STELLA_LVL_UP] = 6;
		}
	}*/
	cleanupAfterCombat();
}
/*
public function aaa():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

public function aaa():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

public function aaa():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
*/
}
}