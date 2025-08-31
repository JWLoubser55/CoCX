
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.PerkLib;
import classes.CoC;

public class DarkSlimeEmpressScene extends BaseContent {
    public function DarkSlimeEmpressScene() {}

    public function encounter():void {
        clearOutput();
		if(flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]==0){
		outputText("As you enter the next room, you start hearing moans. You’re greeted to quite a sight, before you are hundreds of slimy shapes, making out and fucking each other in the most obsene display you've ever seen. Confused, you try and figure if you stepped into some kind of orgy, until you notice one slime at the back of the room who stands out. \n");
        outputText("Wearing a crown seemingly made of goop, this regal purple woman sits on a pair of stone slabs, which serves as a makeshift throne.\n\n");
        outputText("\"<i>Why now my loyal subjects, it seems we have a guest. Welcome to my domain, intruder.\nI hope you intend on joining the feast, in my honor of course. Guests… are always welcome.</i>\"\n\n");
        outputText("All of the slimes suddenly drop their activities, drooling at you with keen interest. You get a very bad feeling. This is when you notice that all of them are linked to one another through small trails of slime on the ground. The slimes take on a makeshift formation, drawing what appears to be slimy spears and bows, all pointed at you.\n\n");
        outputText("Seeing this; you try to run for it. But the purple empress waves her hand, slime seals shut the room's entrance. The dark slime sitting atop the throne giggles, the other slimes follow suit.\n\n");
        outputText("\"<i>I hope you are in the mood, because soon you and I are going to become very.. intimate.</i>\"\n\n");
        outputText("<b>It's too late to escape now, it's a fight!</b>");
		}
		if (flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]==1 || flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]==2){
			
			if (flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]==1) {
				outputText("As you enter the next room, you're greeted by a familiar sight. Before you are hundreds of slimy shapes, making out and fucking each other in the most obsene display you've ever seen.");
				outputText("And at the back of the room, sitting on a makeshift throne, a familiar figure. A dark purple, slimy woman with a goopy crown resting atop her head.");
				
				outputText("\"<i>Why now my loyal subjects, it seems we have a guest.. oh, a returning guest at that. Welcome back to my domain intruder I hope you intend on joining the feast this time, in my honor of course.</i>\"\n\n");
				outputText("All of the slimes suddenly drop their activities, drooling at you with keen interest. The slimes take on a makeshift formation, drawing what appears to be slimy spears and bows, all pointed at you.\n\n");
				outputText("Seeing this, you try to run for it but the purple empress's slimes had already sealed the room's entrance. The dark slime sitting atop the throne giggles, the other slimes follow suit.\n\n");
				outputText("\"<i>I hope you are in the mood, because soon you and I are going to become very.. intimate.</i>\"\n\n");
			}
			else{
				outputText("As you enter the next room,  you’re greeted by a odd sight. \nThe floor is covered in purple goo. Just as you wonder what happened here, you see her. \n");
				outputText("A familiar figure, a dark purple, slimy woman. She looks up at you, rage visible in her eyes.\n\n");
				outputText("\"<i><b>YOU!</b></i>\" she yells as some of the purple goo seals the room's entrance.\n");
				if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME))outputText("\"<i>I'm going to enjoy ripping my crown out of you.</i>\""); 
				else outputText("\"<i>I'm going to make you regret taking my crown from me.</i>\"");
				outputText(" She says as slimes slowly form from the purple goo covering the floor.");
			}
		}
		if (flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS] == 3){
			outputText("As you enter the next room, you're greeted to a odd, yet familiar sight." +
			"\nThe floor is covered in purple goo, and a empty makeshift throne sits empty; reminding you of the fallen sovereign who's life you clamed as your own." +
			"\nYou grab up some of the goo covering the floor and leave.\n\n");
			
			inventory.takeItem(consumables.DSLIMEJ,endEncounter)
		}
		
		
		if(flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]==0) flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS] = 1;
		if (flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS]<2) startCombat(new DarkSlimeEmpress(), true);
    }
    
    public function defeatedBy():void {
        clearOutput();
        outputText("As you fall defeated, the slimes start to cover you. Encasing you in jelly.\n\n");
			if (player.hasKeyItem("Slimy Crown") == -1) {
				outputText("\"<i>It is but customary that one should kneel before their empress. Some punishment is in order.</i>\"");
			}
			else {
				outputText("\"<i>I should punish you for the humiliation from last time. But first, I'll take my crown back.</i>\" ");
				if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME)) outputText("She rips out a part of your gooey body; absorbing it. ");
				else outputText("She slides a slimy tendril down your throat; pulling out a slimy crown. She then absorbs it into her body. ");
				outputText("A crown proceeds to form on her head.\n");
				outputText("\"<i>Now then, shall we continue?</i>\" She turns to sit on her makeshift throne. \nAs she sits down, she waves her hand.");
			}
        outputText("\n\nThe slimes begin to violate you in every way possible. You want to scream in pleasure but when you do a slime takes advantage of your open mouth to pour down your throat. You feel yourself melt and dissolve as your memory and mind become increasingly confused. You are [name] but at the same time you are Clarissa, Elisabeth, Sabrina, and a hundred more confusing names ");
        outputText("float into your mind until you finally understand. You are one but many, everything but nothing. Just one consciousness amongst the hundreds that live within the empress’s immortal jelly. Your body is made of slime but there is only one core to rule them all, the core of your beloved empress. ");
        outputText("The first order she gives is an easy one, to resume the feast, and you’re all too happy to partake. \nA few months later a new human will visit this hall, it will be your greatest pleasure to give him or her a warm, gooey welcome.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    public function defeat():void {
        clearOutput();
		outputText("The purple empress falls to the floor, defeated.");
		menu();
		addButton(14, "Leave", runLeave);
		if (player.hasKeyItem("Slimy Crown")==-1) addButton(14, "Take Crown", crownLeave);
		
		addButtonIfTrue(12, "Merge", DSEMerge, "Req. Dark Slime Core and Slimy Crown", player.hasKeyItem("Slimy Crown")>-1 && player.hasPerk(PerkLib.DarkSlimeCore), "Try to absorb her into yourself.");
    }
	
	private function DSEMerge():void {
		clearOutput();
		outputText("The empress’s purple legion falter as she collapses to the floor." +
		"\nTaking this chance you approach the uncrowned sovereign, looking down at her weakened form." +
		"\nShe looks up at you, eyes still burning with rage, but without the energy to even speak, let alone defy you."+
		"\n\nMuch like a starving wolf standing before a wounded deer; you're unable to stop yourself." +
		"\nYou begin to encase her in your gooey body. \nImmediately she  tries to resist, but she is far too weak to stop you." +
		"\n\nAs your purple bodies start to merge she begins to moan, seemingly in intense pleasure. " +
		"\nWhile you also feel pleasure, you also feel something more.. hunger."+
		"\nAt first you thought you were just craving pleasure just like the other residents of this world, but this is something else." +
		"\nYou suck her body into yours more aggressively than before." +
		"\nSensing your goal has changed, the fallen empress desperately tries to free herself, but she has no means of doing so." + 
		"\nSlowly, you absorb her gooey mass into your own. \nShe appears to enjoy the process, despite the rage and sorrow displayed on her sill visible face." +
		"\n\nNow all that seems to remain of her is a second, alien feeling core, within your mass." +
		"\nUnable to fully control the second core, you try to slowly push it next to your original core." +
		"\n\nIt brushes against the first core, a shock of pleasure runs throughout your gooey body." +
		"\nEven brushing the cores against each other was enough to send shockwaves of pleasure through your body, so pushing them together should feel even better." +
		"\nEnticed by the pleasure it brought, you try to push the cores together." +
		"\n\nYou feel your mind breaking, your senses are overloaded, you can feel only intense pleasure. You can't even tell if your eyes are open or not." +
		"\nOnce the feeling subsides, you no longer feel two cores inside your body. " +
		"\nYou look down at yourself, and you see only one core, noticeably larger than before. Not only that, but some other things have changed, you now look more like the empress." +
		"\nAfter examining your body, you deside to leave. \n\n" );
		outputText("You exit the room and return to the corridor you were previously in.\n\n");
		player.slimeFeed();
		
        CoC.instance.transformations.HairGoo.applyEffect(false);
        CoC.instance.transformations.ArmsGoo.applyEffect(false);
        CoC.instance.transformations.LowerBodyGoo.applyEffect(false);
        CoC.instance.transformations.RearBodyMetamorphicGoo.applyEffect(false);
        CoC.instance.transformations.EyesFiendish.applyEffect(false);
        CoC.instance.transformations.EyesChangeColor(["red"]).applyEffect(false);
        CoC.instance.transformations.EarsElfin.applyEffect(false);
        CoC.instance.transformations.FaceHuman.applyEffect(false);
        CoC.instance.transformations.TongueHuman.applyEffect(false);
        CoC.instance.transformations.VaginaHuman().applyEffect(false);
        CoC.instance.transformations.AntennaeNone.applyEffect(false);
        CoC.instance.transformations.HornsNone.applyEffect(false);
        CoC.instance.transformations.WingsNone.applyEffect(false);
		player.createPerk(PerkLib.TransformationImmunity2, 11, 0, 0, 0);
		player.createPerk(PerkLib.DarkSlimeEmpressCore, 0, 0, 0, 0);
		CoC.instance.mainViewManager.updateCharviewIfNeeded();
		player.updateRacialParagon(Races.DARKSLIME);
		
		outputText("\n\n<b>Gained New Perk: Sovereign's Dark Slime Core - Increased control over external slime.</b>");
		outputText("\n\n<b>Gained Perk: Transformation Immunity!</b> "+PerkLib.TransformationImmunity2.longDesc+"\n");
		flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS] = 3;
		outputText("\n\n");
		
		beforeLeave();
	}
	
	private function runLeave():void {
		outputText("The empress’s purple legion falter, the slimes blocking the exit fall off. \n");
		outputText("You don't wait long enough for the sovereign to recover her composure. You rush for the exit, the empress screaming orders as you leave. Thankfully slimes are not overly fast and you manage to make it back to the corridor junction you came from.\n\n");
		beforeLeave()
	}
	private function crownLeave():void {
		outputText("The empress’s purple legion falter, the slimes blocking the exit fall off. \n");
		outputText("You take this chance to grab the slimy crown above her head. \n");
		if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME)) outputText("<b>It melts into you.</b> \n");
		else outputText("It melts in your hand, falling into a puddle on the ground. \n\n");
		if (player.isRaceCached(Races.DARKSLIME) && !player.hasPerk(PerkLib.DarkSlimeCore)) outputText("As it melts into you, a crystal like gem seems to form within you.\n");
		outputText("You don't wait long enough for the sovereign to recover her composure. You rush for the exit, the empress screaming orders as you leave. Thankfully slimes are not overly fast and you manage to make it back to the corridor junction you came from.\n\n");
        if (player.hasKeyItem("Slimy Crown")==-1 &&(player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME))){
			
			outputText("\n\n(Key Item Gained: Slimy Crown)");
			player.createKeyItem("Slimy Crown", 0, 0, 0, 0);
			if (player.isRaceCached(Races.DARKSLIME) && !player.hasPerk(PerkLib.DarkSlimeCore)) player.gainPerk(PerkLib.DarkSlimeCore, true);
			flags[kFLAGS.ENCOUNTERED_DARKSLIME_EMPRESS] = 2;
		}
		beforeLeave();
	}
	
	private function beforeLeave():void {
		if (player.hasStatusEffect(StatusEffects.TFDealer1) && player.statusEffectv1(StatusEffects.TFDealer1) < 1) player.addStatusValue(StatusEffects.TFDealer1, 1, 1);
        else player.createStatusEffect(StatusEffects.TFDealer1, 1, 0, 0, 0);
		menu();
		addButton(1, "Next", cleanupAfterCombat);
	}
}
}
