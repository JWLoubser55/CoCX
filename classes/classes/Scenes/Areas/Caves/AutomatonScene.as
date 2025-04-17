/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.StatusEffects;
import classes.Scenes.Camp.CampStatsAndResources;

public class AutomatonScene extends BaseContent
{
	public function AutomatonScene() {}

public function automatonEncounter():void {
	clearOutput();
	outputText("While exploring the cave system you run into what at first glance appears to be a genuine albeith weirdly dressed human. Amazed to have finally found someone to relate to in this hellhole you throw caution to the wind and run toward her. As you get closer you realize her skin pigmentation is unusual… like quicksilver. Furthermore she is surrounded by the bodies of still unconscious dark elves theres no denying who did it. ");
	outputText("The thing that is clearly no human turns to face you, its eyes glowing as she speaks in a dispassionate neutral voice before her tone changes to a more jovial one.\n\n");
	outputText("“New entity detected\n\n");
	outputText("… Analyzing… Designation: [race]. Evaluation: "+(player.blockingBodyTransformations()?"Negative , Species incompatible for reformating.":"Positive. Engaging social mode… Hello, I am a unit made to satisfy…CAPTURE… your desire would you mind us to have sex?")+"”\n\n");
	outputText("Okay yea its one of those again… you ready for combat and the thing responds with hostility.\n\n");
	outputText("\"<i>Aggression detected engaging pacification protocol.</i>\"\n\n");
	outputText("With this she reveals a sword hilt with a glowing light blade and ominously walks toward you.\n\n");
	if (silly()) outputText("\"<i>I am Melania blade of Mechania and I have never known defeat… is what I would like to say but there is only so much bad puns I can pull from the network and beside this would be copyright infringement. Resistance is futile you will be assimilated [race].</i>\"\n\n");
	startCombat(new Automaton());
}

public function winningOverAutomaton():void {
	clearOutput();
	if (monster.HP <= monster.minHP()) outputText("As you deliver the last hit the automaton body begins to fall apart");
	else {
		outputText("As you overload the automaton with lust it begins to smoke. It looks like you broke something in it or whatever. A few seconds later it explodes sending its part in all directions");
		player.takeFireDamage(Math.round(player.maxHP()*0.1),true);
	}
	outputText(". Looks like you broke the nasty thing beyond repair which is good.");
	if (CampStatsAndResources.EnergyCoreResc < 200) {
		CampStatsAndResources.EnergyCoreResc += 1;
		outputText(" Amidst the wreckage you find a single energy core.\n\n");
	}
	outputText("\n\n");
	if (player.hasStatusEffect(StatusEffects.PostAutomatonBeatdown)) player.removeStatusEffect(StatusEffects.PostAutomatonBeatdown);
	cleanupAfterCombat();
}

public function losingToAutomaton():void {
	clearOutput();
	if ((player.isRaceCached(Races.RAIJU) || player.isRaceCached(Races.THUNDERBIRD) || player.isRaceCached(Races.KIRIN)) && player.gender > 0) {
		outputText("You fall over on your knees, defeated. The automaton approaches you holding a hand to the side of her head as if holding a headset while staring blankly at you.\n\n");
		outputText("\"<i>Energy source detected analyzing… high voltage confirmed initiating harvesting protocol…</i>\"\n\n");
		outputText("Just as you thought shit couldn’t get any weirder the automaton tail begins to open, its metal part blossoming into what appears to be a " + (player.hasCock()?"suction tube":"bulb shaped end") + ". You’ve seen too much of this shit not to know where this is going and afraid you begin to crawl away before the metal woman kicks you onto your back exposing her obvious target! Not rushing anything she lay down on top of you forcefully initiating a kiss. Confused, you react instinctively and kiss back moaning as some of your voltage is extracted by her greedy tongue.\n\n");
		if (player.hasCock()) outputText("While you are distracted her tail suction cup firmly attaches itself to your charged cock and begins sucking you in. Now in a proper circuit your body reacts naturally and begins discharging all its voltz from both ends causing you to spasm and drool in delight as pleasure attempts to fry your brain… well not quite your body was tailor made to endure this kind of bliss and you ride the current of your consecutive orgasms as you cum load after load of plasma into the suction tubes");
		else outputText("While you are distracted her tail dildo firmly lodges itself into your charged cunny and begins fiercely vibrating. Now in a proper circuit your body reacts naturally and begins discharging all its voltz from both ends causing you to spasm and drool in delight as pleasure attempts to fry your brain… well not quite your body was tailor made to endure this kind of bliss and you ride the current of your consecutive orgasms as you cum load after load of plasma drenching your tight and the ground beneath you with your supercharged glowing girl juices");
		outputText(".\n\n\"<i>Battery fully charged unplugging.</i>\"\n\n");
		outputText("Her tail breaks off from your nethers as she lift off from you leaving you free to move but you’re still too shocked with big hearts in your eye and a dopey smile to notice anything as she leaves.\n\n");
		outputText("When you more or less come back to your senses she's long gone. Well that was an electrifying experience!\n\n");
		cleanupAfterCombat();
	}
	else {
		outputText("You fall over on your knees, defeated. The automaton approaches you with her electrified metallic tail poised to strike. You try to back off but she delivers a finishing discharge sending you unconscious.\n\n");
		if (player.hasStatusEffect(StatusEffects.PostAutomatonBeatdown)) {
			if (player.statusEffectv1(StatusEffects.PostAutomatonBeatdown) > 4) cleanupAfterCombat();
			else {
				player.addStatusValue(StatusEffects.PostAutomatonBeatdown, 1, 1);
				cleanupAfterCombat();
			}
		}
		else {
			player.createStatusEffect(StatusEffects.PostAutomatonBeatdown, 1, 0, 0, 0);
			cleanupAfterCombat();
		}
	}
}
}//outputText("\"<i></i>\"\n\n");
}