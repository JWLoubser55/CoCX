/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
//import classes.PerkLib;
//import classes.StatusEffects;

public class MatangoScene extends BaseContent
{
	public function MatangoScene() {}

public function mantangoEncounter():void {
	clearOutput();
	outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest. At first, you marvel at the bioluminescent spectacle, exploring the beautiful mushroom forest, but your wonder is short lived as what sounded like a lusty woman moan coming from behind you interrupts your sightseeing.\n\n");
	outputText("Turning around to confront this new threat, you are greeted by the sight of a human woman… or what used to be one? Her body seems to be partially transformed into something that looks like mushroom frills in a fashion reminiscent of a dress, but no matter how you look at it, this dress is actually growing out of her body. Atop her head grows a small, white glowing mushroom cap, not unlike the local mushrooms.\n\n");
	outputText("She stumbles toward you at a slow, zombie-like pace. Those lust-glazed eyes and drooling smile of hers promises a “feels gud” time should she get the better of you.\n\n");
	outputText("<b>It's a fight!</b>");
	startCombat(new Matango());
}

public function winningOverMantango():void {
	clearOutput();
	outputText("The mushroom-infested woman falls on the floor, defeated. She looks at you frustrated, but can’t seem to fight anymore. Looking at what became of her body, something in you keenly knows whatever made a horny mess out of her is highly contagious. ");
	outputText("Unless you got a means to have indirect sex with her or got some sort of special immunity granted by your race or anatomy, it'd be best you passed on this fuck entirely. Regardless, normal sex isn’t an option here.\n\n");
	menu();
	addButton(14, "Leave", winningOverMantangoLeave);
	SceneLib.uniqueSexScene.pcUSSPreChecksV2(winningOverMantango);
}
public function winningOverMantangoLeave():void {
	outputText("Yeah, no. It ain’t worth the damn risk! You leave her be and resume your exploration.\n\n");
	cleanupAfterCombat();
}

public function losingToMantango():void {
	clearOutput();
	//if (rand(4) == 0) {
		outputText("You fall on the ground, defeated, but just as you are about to get thoroughly violated, a cave wyrm rampages through the area.\n\n");
		outputText("\"<i>GIVE ME YOUR COCK SHROOM BITCH, I NEED IT FOR MY EGGS!!</i>\"\n\n");
		outputText("Under your confused stare, the horny lizard steals away the mushroom infested woman and runs off into the dark. Damn, that was close, better not lose again. There’s no chance such luck will happen twice.\n\n");
		cleanupAfterCombat();/*
	}
	else {
		outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest.\n\n");
	}*/
}
}
}