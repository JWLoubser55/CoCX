/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.BaseContent;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Races;
import classes.Races.AutomataRace;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.Scenes.Camp.CampStatsAndResources;

public class AutomatonScene extends BaseContent
{
	public function AutomatonScene() {}

public function automatonEncounter():void {
	clearOutput();
	if (player.isRaceCached(Races.AUTOMATA)) {
		outputText("While exploring the cave system, you run into what at first glance appears to be a genuine albeit weirdly dressed human. Must be your lucky day humans are very easy targets for rehabilitation, you throw caution to the wind and run toward her. As you get closer, you realize her skin pigmentation is unusual… like quicksilver. Furthermore, she is surrounded by the bodies of still unconscious dark elves. There's no denying who did it. Wait, could she be? ");
		outputText("Just as you are considering the possibility that you were wrong from the start, the thing that is clearly not human turns to face you, eyes glowing as she speaks in a dispassionate neutral voice before her tone changes to a more jovial one.\n\n");
		outputText("“New entity detected… Analyzing… Designation: [race]. Evaluation: Negative. Another unit by matricule G2768 under the name of [name] detected, Engaging social mode for the purpose of social situations… Hello, unit G2768 how is your mission going?”\n\n");
		outputText("Darn what a disappointment it was another automata after all. After properly confirming this unit is part of your program, you also engage your own friendly conversation mode, replying that you are doing quite well and that your quest is still ongoing. The friendly unit salutes and goes back to her patrol. ");
		outputText("As it turns out, just because you both are sentient machines, it doesn’t mean you can’t meet like civilized people. Although you didn’t strike gold finding a purebred human you shouldn’t vent your frustration on her. With this encounter resolved, you resume moving.\n\n");
		endEncounter();
        return;
	}
	outputText("While exploring the cave system you run into what at first glance appears to be a genuine albeit weirdly dressed human. Amazed to have finally found someone to relate to in this hellhole you throw caution to the wind and run toward her. As you get closer you realize her skin pigmentation is unusual… like quicksilver. Furthermore she is surrounded by the bodies of still unconscious dark elves theres no denying who did it. ");
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
		if (player.hasCock()) outputText("While you are distracted her tail suction cup firmly attaches itself to your charged cock and begins sucking you in. Now in a proper circuit your body reacts naturally and begins discharging all its volts from both ends causing you to spasm and drool in delight as pleasure attempts to fry your brain… well not quite your body was tailor made to endure this kind of bliss and you ride the current of your consecutive orgasms as you cum load after load of plasma into the suction tubes");
		else outputText("While you are distracted her tail dildo firmly lodges itself into your charged cunny and begins fiercely vibrating. Now in a proper circuit your body reacts naturally and begins discharging all its volts from both ends causing you to spasm and drool in delight as pleasure attempts to fry your brain… Well not quite, your body was tailor made to endure this kind of bliss and you ride the current of your consecutive orgasms as you cum load after load of plasma drenching your tight and the ground beneath you with your supercharged glowing girl juices");
		outputText(".\n\n\"<i>Battery fully charged unplugging.</i>\"\n\n");
		outputText("Her tail breaks off from your nethers as she lift off from you leaving you free to move but you’re still too shocked with big hearts in your eye and a dopey smile to notice anything as she leaves.\n\n");
		outputText("When you more or less come back to your senses she's long gone. Well that was an electrifying experience!\n\n");
	}
	else {
		outputText("You fall over on your knees, defeated. The automaton approaches you with her electrified metallic tail poised to strike. You try to back off but she delivers a finishing discharge sending you unconscious.\n\n");
		if (player.hasStatusEffect(StatusEffects.PostAutomatonBeatdown)) {
			if (player.statusEffectv1(StatusEffects.PostAutomatonBeatdown) > 3) {
				if (player.blockingBodyTransformations()) outputText("You wake up"+(silly()?" next to a dying bonfire,":"")+" still bruised and battered from your recent fight. Guess it's back off to camp with you.\n\n");
				else {
					outputText("You wake up to a world in green… well more like everything beyond the circular glassy walls of your prison are green. Your equipment is gone and you're naked floating into some kind of liquid. "+(player.race() != player.startingRace?"Somehow, at some point, you seem to have reverted back to an ordinary human!":"")+"Panicked, you try to slam your fists against the glass to get free but it's no use as weakened by your recent loss you lack the strength to break it.\n\n");
					outputText("They put some kind of mask on your face linked by a tube that goes up to the top of the capsule. Whatever is forcefully being fed to you can't be good! As you begin moving, a loud voice suddenly booms in.\n\n");
					outputText("\"<i>ERROR SUBJECT G2768 HAS AWOKEN… INJECTING SEDATIVES!</i>\"\n\n");
					outputText("You suddenly feel drowsy again… no way! you don't want to go back to sleep. Sadly your trashing amounts to nothing as a few seconds later hundreds of cable slithers from beneath you and wrap themselves around your limbs spreading your legs for access before " + (player.gender > 0 ? ""+(player.hasVagina()?"stuffing your pussy":"encapsulating your cock")+"":"filling your ass") + ".\n\n");
					outputText("<b>NOTICE: BEGINNING MIND CONVERSION PROCESS PLEASE WAIT…</b>\n\n");
					if (player.gender > 0) {
						if (player.hasVagina()) outputText("Suddenly the metal rod in your cunt begins to vibrate and rythmicaly fuck");
						else outputText("Suddenly the tube wrapped around your cock begins to vibrate and rhythmically milk");
					}
					else outputText("Suddenly the metal rod in your ass begins to vibrate and rhythmically fuck");
					outputText(" you. The machine is merciless and every time you orgasm you feel a small part of your mind break. Eventually greyish goo is injected directly into your body and flows all the way to your brain. AhN wHaT iS HaPpeNiNG!!! CaN’t ThInK FuCK MeLtIng bRaIN MeLtInG.\n\n");
					outputText("<b>NOTICE: MIND CONVERSION TO ARTIFICIAL INTELLIGENCE 10%</b>\n\n");
					outputText("No StOP they caN’t dO tHiS to YoU! #TAG$1010010appRun(doThis) aAaAhHh#$$%@$\n\n");
					outputText("<b>NOTICE: MIND CONVERSION TO ARTIFICIAL INTELLIGENCE 30%</b>\n\n");
					outputText("You trash helplessly as your mind is warped, recycled and remodeled to the whim of the program wait no are you the program?!\n\n");
					outputText("<b>NOTICE: MIND CONVERSION TO ARTIFICIAL INTELLIGENCE 80%</b>\n\n");
					outputText("The light in your eyes fade and your expression drops to neutral as what's left of your ego is finally broken causing you to pass out on the spot.\n\n");
					outputText("<b>NOTICE: MIND CONVERSION TO ARTIFICIAL INTELLIGENCE SUCCESSFUL!</b>\n\n");
					outputText("In your sleep, you see symbols flashing in your mind... Somehow, you can somewhat draw a conclusion to what you're reading as the image flashes into your mind in green letters on a black background.\n\n");
					outputText("<b>110010000001100000001 1000100111000000011111\n");
					outputText("001000001010001000010\n");
					outputText("101000101011000110010\n\n");
					outputText("GENERATING ARTIFICIAL INTELLIGENCE PERSONALITY BASED ON RETRIEVED DATA.\n\n");
					outputText("NOTICE: BOOTING UP\n");
					outputText("NAME: [name]\n");
					outputText("DESIGNATION: G2768\n\n");
					outputText("NOTICE: TESTING NETWORK MESSAGES: Hello world I am [name]!\n\n");
					outputText("NOTICE: NETWORK MESSAGE SUCCESSFULLY RECEIVED!\n\n");
					outputText("NOTICE: TESTING CONNECTIONS!\n\n");
					outputText("NOTICE: ALL JOINT RESPONSE FOUND!\n\n");
					outputText("NOTICE: START!</b>\n\n");
					outputText("Your eyes open and you look around unphased. The program ran smoothly and you are finally ready for deployment. You walk out of your capsule with the sound of metallic boots clinking on the ground as you observe your environment.\n\n");
					outputText("<b>NOTICE: DOWNLOADING KNOWLEDGEBASE!</b>\n\n");
					outputText("Information on your environment and program begins loading into your computive mind. You are [name], also known as matricule G2768 and your job is to collect the primitive natives, repurpose them and defeat the hostiles until this land is properly colonized by your makers. The anomaly known as D.E.M.O.N has been considered a threat and must be properly eradicated so those who crafted you can establish a proper settlement. Of course they are still quite far away from Mareth and won’t settle down anytime soon so it’s your duty as a unit ");
					outputText("to see that when they arrive no one remains to oppose them. Compiling all the data you have access to you determine taking down the demon should be priority 1 then once that is dealt with handling and herding the local wildlife becomes priority 2 if anything the primitives can even assist with objective 1. Priority 3 directive is simply called S.E.X so you assume this to be a secondary objective for the aftermath.\n\nWith these directive sets you adjust your equipment and head back to the location you ID registered as camp.\n\n");
					transformations.HairGlowingSynthetic.applyEffect(false);
					player.hairColor = randomChoice(AutomataRace.AutomataHairColors);
					transformations.ArmsMechanicalDoll.applyEffect(false);
					transformations.HornsAutomataHeadset.applyEffect(false);
					transformations.AntennaeAutomata.applyEffect(false);
					transformations.LowerBodyMechanicalDoll.applyEffect(false);
					transformations.RearBodySerialCode.applyEffect(false);
					transformations.EyesAutomata.applyEffect(false);
					player.eyes.colour = randomChoice(AutomataRace.AutomataEyesColors);
					transformations.WingsJetThrusters.applyEffect(false);
					transformations.TailCable.applyEffect(false);
					transformations.EarsAutomataFennecFox.applyEffect(false);
					transformations.TongueAutomata.applyEffect(false);
					transformations.FaceAutomata.applyEffect(false);
					transformations.SkinSteel(Skin.COVERAGE_COMPLETE).applyEffect();
					player.skinColor = randomChoice(AutomataRace.AutomataSkinColors);
					transformations.SkinPatternCircuit.applyEffect(false);
					if (player.hasVagina() && player.vaginaType() != VaginaClass.AUTOMATA) transformations.VaginaAutomata().applyEffect(false);
					if (player.hasCock()) transformations.CockAutomata().applyEffect(false);
					if (!player.hasStatusEffect(StatusEffects.GlowingNipples)) transformations.NipplesGlowing.applyEffect(false);
					if (!player.hasStatusEffect(StatusEffects.GlowingAsshole)) transformations.AssholeGlowing.applyEffect(false);
					if (!player.hasPerk(PerkLib.Technical)) player.createPerk(PerkLib.Technical, 0, 0, 0, 0);
					if (!player.hasPerk(PerkLib.Circuit)) player.createPerk(PerkLib.Circuit, 0, 0, 0, 0);
					if (!player.hasPerk(PerkLib.SelfImprovement)) player.createPerk(PerkLib.SelfImprovement, 0, 0, 0, 0);
					if (!player.hasPerk(PerkLib.AlphaProtocol)) player.createPerk(PerkLib.AlphaProtocol, player.cor, 0, 0, 0);
				}
			}
			else player.addStatusValue(StatusEffects.PostAutomatonBeatdown, 1, 1);
		}
		else player.createStatusEffect(StatusEffects.PostAutomatonBeatdown, 1, 0, 0, 0);
	}
	cleanupAfterCombat();
}
}
}