/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Galia;

	public class GaliaFollower extends NPCAwareContent
	{
		
		public function GaliaFollower() 
		{}
		
		public function bringBackTheFemImp():void {
			clearOutput();
			outputText("You arrive back in camp just in time to spot Evangeline poking your recent impish acquisition with a stick taking swift notes on a paper with a semi manic smile.\n\n");
			outputText("\"<i>Oh my gosh! Oh my gosh!! Oh my GOSH!!! A female imp I never thought I’d see one of those! And it’s alive too!</i>\"\n\n");
			outputText("Evangeline suddenly realise you are staring awkwardly and rush to you.\n\n");
			outputText("\"<i>[name] you MUST allow me to do test on this thing I must study its ecology and function maybe I will even finish with a live dissection!</i>\"\n\n");
			outputText("Evangeline pout before turning back to you.");
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
				outputText("\n\nAmily annoyed reply right away.\n\n");
				outputText("\"<i>Get to the dissection already this thing is polluting our air! The sooner it's dead the better.</i>\"\n\n");
			}
			if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) outputText("\n\nJojo simply adds that killing it now is the merciful thing to do while.\n\n");
			if (CelessScene.instance.isCompanion()) outputText("\n\nCeless seems genuinely "+(CelessScene.instance.isCorrupt ? "curious" : "scared")+" of the imp.");
			//(If Alvina) outputText("\n\nWhile not physically present you can hear Alvina giggle in your mind replying that this thing would make an interesting lab rat for her black magic researches.\n\n");
			//(Siegweird) outputText("\n\nSiegweird propose to skip the dissection and simply kill it now.\n\n");
			outputText("Yea no one is going to perform any experiment or dissection on this imp until you authorize it. This much you make clear to Evangeline. She is disappointed at first but reply regardless.\n\n");
			outputText("\"<i>When you care enough about the progress of science tell me and we'll proceed with the tests.</i>\"\n\n");
			flags[kFLAGS.GALIA_TALKS] = 1;
			flags[kFLAGS.GALIA_LVL_UP] = 1;
			flags[kFLAGS.GALIA_AFFECTION] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function GaliaCampMainMenuSlave():void {
			clearOutput();
			outputText("Galia glances at you, eyes dulled with boredom, but still slightly miffed.\n\n");
			outputText("She sighs before speaking curtly to you, \"<i>What?</i>\"");
			menu();
			addButton(0, "Appearance", GaliaCampMainMenuSlaveAppearance);
			if (flags[kFLAGS.GALIA_AFFECTION] > 2) addButtonDisabled(1, "Talk", "???");
			else addButtonDisabled(1, "???", "If there was way to make Galia less hate you [name]... It would make life easier... or at least make her more TALKative, right?");//1 - talk
			addButton(2, "Spar", GaliaSparring).hint("Get into a quick battle with Galia!").disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
			//3 - sex
			addButtonDisabled(4, "???", "Can't tell you yet but i advise to look for that one cat merchant to be ready when this option opens ;)");//4 - give items
			if (flags[kFLAGS.GALIA_LVL_UP] >= 5) {
				if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Team", galiaHenchmanOption);
				else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
			}
			else addButtonDisabled(5, "???", "You need to let Evangeline perform 2nd experiment on Galia.");
			addButton(14, "Back", camp.campSlavesMenu);
		}
		
		public function GaliaCampMainMenuSlaveAppearance():void {
			clearOutput();
			outputText("Galia is a short, ");
			if (flags[kFLAGS.GALIA_AFFECTION] == 2) outputText("two-foot, three-inch");
			if (flags[kFLAGS.GALIA_AFFECTION] == 3) outputText("three-foot, six-inch");
			if (flags[kFLAGS.GALIA_AFFECTION] == 4) outputText("four-foot, nine-inch");
			if (flags[kFLAGS.GALIA_AFFECTION] == 5) outputText("six-foot");
			outputText(" tall feral imp. Her shaggy, unkempt mane still harbors some elegance to it, with the platinum blonde locks parted by the dual set of curved horns. To prevent her hair from dragging across the ground, she has braided it into twin tails for her stature to be taller than the length of her hair. Her eyes are a solid black, save for tiny red irises that peer toward you judgmentally, still in resentment from the transformation.\n\n");
			outputText("Her breasts are about ");
			if (flags[kFLAGS.GALIA_AFFECTION] == 2) outputText("DD");//5
			if (flags[kFLAGS.GALIA_AFFECTION] == 3) outputText("FF");//7-8
			if (flags[kFLAGS.GALIA_AFFECTION] == 4) outputText("H");//11
			if (flags[kFLAGS.GALIA_AFFECTION] == 5) outputText("JJ");//14
			outputText(" cups, which, given her ");
			if (flags[kFLAGS.GALIA_AFFECTION] == 2) outputText("diminutive ");if (flags[kFLAGS.GALIA_AFFECTION] == 2) outputText("small/short? ");
			outputText("figure, makes them seem almost too large for her shape. Her once athletic, toned body has long been replaced by soft, pliable flesh, much to her chagrin. Her wide, womanly hips almost force a sluggish, swaying gait as she moves around, coupled with the difficulty of all the mass in her ass that jiggles slightly with each step.\n\n");
			outputText("A pair of tiny, yet functional wings flap occasionally from her back. Her skin is a bright red hue, unobstructed by clothing or armor, save for a small loincloth tied at her waist that wraps up to her chest. Her feet are protected by tiny wooden sandals, and her hands are tipped with a set of dangerous claws, even post-transformation.\n\n");
			menu();
			addButton(14, "Back", GaliaCampMainMenuSlave);
		}  
		
		public function GaliaSparring():void {
			clearOutput();
			outputText("She nods as you ask her to fight, \"<i>Good. I was feeling a bit itchy lately... You won't hold a grudge if I didn't hold back on you, right? It's going to get rough!</i>\"\n\n");
			outputText("Without your input, she rushes in, ready to start another fight.");
			startCombat(new Galia());
		}
		public function GaliaWonSparring():void {
			clearOutput();
			outputText("She hovers over you defiantly, \"<i>To the winners goes the spoils.</i>\"\n\n");
			outputText("Before you're offered a chance to recover, Galia begins another round of beating, albeit slightly less violent than before.");
			pc.HPChange(player.maxHP() * 0.1, false, false);
			cleanupAfterCombat();
		}
		public function GaliaLostSparring():void {
			clearOutput();
			outputText("After some time, Galia calms down, her voice struggling not to break as she trods off to her resting place, \"<i>You... won this time... but I'll have the next... I swear...</i>\"");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.GALIA_DEFEATS_COUNTER]++;
				else flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.GALIA_LVL_UP] == 1) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 0.5));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 0.5), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 2;
				}
				if (flags[kFLAGS.GALIA_LVL_UP] < 4) {
					if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] >= flags[kFLAGS.GALIA_LVL_UP] + 1) {
						if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * (flags[kFLAGS.GALIA_LVL_UP] - 1)));
						else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * (flags[kFLAGS.GALIA_LVL_UP] - 1)), 0, 0);
						flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
						flags[kFLAGS.GALIA_LVL_UP]++;
					}
				}/*
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.GALIA_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 5;
				}*/
			}
			cleanupAfterCombat();
		}
		
		public function galiaHenchmanOption():void {
			menu();/*
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
				if (flags[kFLAGS.PLAYER_COMPANION_2] == "Nadia" || flags[kFLAGS.PLAYER_COMPANION_3] == "Nadia") addButtonDisabled(0, "Team (1)", "You already have Nadia accompany you.");
				else addButton(0, "Team (1)", galiaHenchmanOption2, 1).hint("Ask Nadia to join you in adventures outside camp.");
			}
			else {
				if (flags[kFLAGS.PLAYER_COMPANION_1] == "Nadia") addButton(5, "Team (1)", galiaHenchmanOption2, 21).hint("Ask Nadia to stay in camp.");
				else addButtonDisabled(5, "Team (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Nadia about accompaning you as first party member.");
			}
			if (player.hasPerk(PerkLib.IntermediateLeadership)) {
				if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
					if (flags[kFLAGS.PLAYER_COMPANION_1] == "Nadia" || flags[kFLAGS.PLAYER_COMPANION_3] == "Nadia") addButtonDisabled(1, "Team (2)", "You already have Nadia accompany you.");
					else addButton(1, "Team (2)", galiaHenchmanOption2, 2).hint("Ask Nadia to join you in adventures outside camp.");
				}
				else {
					if (flags[kFLAGS.PLAYER_COMPANION_2] == "Nadia") addButton(6, "Team (2)", galiaHenchmanOption2, 22).hint("Ask Nadia to stay in camp.");
					else addButtonDisabled(6, "Team (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Nadia about accompaning you as second party member.");
				}
			}
			else {
				addButtonDisabled(1, "Team (2)", "Req. Intermediate Leadership.");
				addButtonDisabled(6, "Team (2)", "Req. Intermediate Leadership.");
			}*/
			addButton(14, "Back", GaliaCampMainMenuSlave);
		}/*
		public function galiaHenchmanOption2(slot:Number = 1):void
		{
			clearOutput();
			if (slot < 21) {
				outputText("\"<i>Of course I'll help you out, [name]! With me around you, no harm will come to you!</i>\"\n\n");
				outputText("Nadia is now following you around.\n\n");
				var intNadia:Number = 100;
				var wisNadia:Number = 100;
				var healpowerNadia:Number = 2.5;
				var soulskillpowerNadia:Number = 7.25;/\*
				if (flags[kFLAGS.AURORA_LVL] >= 1) {
					if (flags[kFLAGS.AURORA_LVL] == 2) {
						intAyane += 22;
						wisAyane += 11;
						spellsoulskillpowerAyane += 0.1;
					}
					if (flags[kFLAGS.AURORA_LVL] == 3) {
						intAyane += 22;
						wisAyane += 11;
						spellsoulskillpowerAyane += 0.1;
					}
					if (flags[kFLAGS.AURORA_LVL] >= 4) {
						intAyane += 66 + (22 * (5 - flags[kFLAGS.AURORA_LVL]));
						wisAyane += 33 + (11 * (5 - flags[kFLAGS.AURORA_LVL]));
						spellsoulskillpowerAyane += 0.3 + (0.1 * (5 - flags[kFLAGS.AURORA_LVL]));
					}
				}*\/
				intNadia *= (1 + (0.2 * player.newGamePlusMod()));
				intNadia = Math.round(intNadia);
				wisNadia *= (1 + (0.2 * player.newGamePlusMod()));
				wisNadia = Math.round(wisNadia);
				healpowerNadia += (0.5 * player.newGamePlusMod());
				soulskillpowerNadia += (0.5 * player.newGamePlusMod());
				player.createStatusEffect(StatusEffects.CombatFollowerNadia, wisNadia, wisNadia, healpowerNadia, soulskillpowerNadia);
				if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Nadia";
				if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Nadia";
			}
			else {
				outputText("Nadia nods her head, \"<i>I’ll be here if you need need my assistance.</i>\"\n\n");
				outputText("Nadia is no longer following you around.\n\n");
				player.removeStatusEffect(StatusEffects.CombatFollowerNadia);
				if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
				if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
			}
			doNext(GaliaCampMainMenuSlave);
			cheatTime(1/12);
		}*/
	}
}