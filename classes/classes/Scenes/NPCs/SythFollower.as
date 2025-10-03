/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class SythFollower extends NPCAwareContent
{
	
	public function SythFollower() 
	{}
//corrupted male salamander with demonic traits and was forcefeed bro brew in the past
//protected younger sister from demons, got captured, corrupted then AN slavers get him during raid on demons prison/lab and put him into slave pens

public function SythrilMainMenu():void {
	clearOutput();
	outputText("Hearing your footsteps Sythril stops one of his daily exercises and awaits what would be your command.\n\n");
	outputText("\"<i>"+player.mf("Master","Mistress")+"?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", SythrilMainMenuAppearance);
	//addButton(4, "Spar", sythrilSparsWithPC).hint("Ask Sythril for a mock battle.")
	//	.disableIf((flags[kFLAGS.PLAYER_COMPANION_1] == "Sythril" || flags[kFLAGS.PLAYER_COMPANION_2] == "Sythril"), "You can't fight against him as long he's in your team.")
	//	.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	addButton(14, "Back", camp.campSlavesMenu);
}

public function SythrilMainMenuAppearance():void {
	clearOutput();
	outputText("You eye Sythril, taking in the well over eight feet worth of salamander towering over you. His crimson scales glisten in the illumination he basks in, further highlighted by the countershading of his yellow stomach. His amber eyes flick slowly around before settling on you with an increasingly smug grin from his snout. His jawline is rather slick for a salamander, but still sharp and angular, a testament to his manliness, which is likely a side effect of the corruption inside him.\n\n");
	outputText("With each breath, the faint corrupt scarring along his body becomes more apparent with the cadence of each rise and fall. He's extremely broad with his powerful shoulders, moving idly as his arms twitch and flex now and then. Along his strapping back are a set of powerful, demonic wings, massive when he stretches out his wingspan, as they must be to hold up such a massive salamander.\n\n");
	outputText("He leers at you with a teasing grin whilst you eye him. His body is herculean, sculpted biceps that are easily larger than your head supported with broad shoulders and a thick neck that tightens as his grin betrays more teeth.\n\n");
	outputText("Sythril flexes his expansive pecs at you, each one easily larger than an entire melon with each nipple poking out toward you as he continues flaunting himself, clearly trying to entice you with his body.\n\n");
	//outputText("Below his pillar-like waist are his mountainous legs with visible contours of muscle down his scarred, scaled thighs to the massive calves that support nearly a literal ton of pure muscle. His twin [reptilian/demonic] dicks ooze volatile, purple precum that splatters over the floor before him. ([reptile]Still partially within his slit, several inches are still exposed from his cloaca.) At full length, each dick is about a foot in length and just over two inches thick.\n\n");
	outputText("Below his pillar-like waist are his mountainous legs with visible contours of muscle down his scarred, scaled thighs to the massive calves that support nearly a literal ton of pure muscle. His twin demonic dicks ooze volatile, purple precum that splatters over the floor before him. At full length, each dick is about a foot in length and just over two inches thick.\n\n");
	outputText("He cocks his head slightly, \"<i>Enjoying me, "+player.mf("master","mistress")+"? There's so much more I can do, you know...</i>\"\n\n");
	menu();
	addButton(14, "Back", SythrilMainMenu);
}

public function sythrilSparsWithPC():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	startCombat(new Syth());
}

public function SythrilWonSparring():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	cleanupAfterCombat();
}

public function SythrilLostSparring():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");/*
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] >= 1) flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER]++;
		else flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] == 1 && flags[kFLAGS.SYTHRIL_LVL_UP] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction), 0, 0);
			flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.SYTHRIL_LVL_UP] = 2;
		}
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] == 2 && flags[kFLAGS.SYTHRIL_LVL_UP] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
			flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.SYTHRIL_LVL_UP] = 3;
		}
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] == 3 && flags[kFLAGS.SYTHRIL_LVL_UP] == 3) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3), 0, 0);
			flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.SYTHRIL_LVL_UP] = 4;
		}
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] == 4 && flags[kFLAGS.SYTHRIL_LVL_UP] == 4) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4), 0, 0);
			flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.SYTHRIL_LVL_UP] = 5;
		}
		if (flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] == 5 && flags[kFLAGS.SYTHRIL_LVL_UP] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5), 0, 0);
			flags[kFLAGS.SYTHRIL_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.SYTHRIL_LVL_UP] = 6;
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