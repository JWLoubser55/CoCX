/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
//import classes.PerkLib;
//import classes.StatusEffects;

public class AutomatonScene extends BaseContent
{
	public function AutomatonScene() {}

public function automatonEncounter():void {
	clearOutput();
	outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest.\n\n");
	outputText("<b>It's a fight!</b>");
	startCombat(new Automaton());
}

public function winningOverAutomaton():void {
	clearOutput();
	outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest.\n\n");
	cleanupAfterCombat();
}

public function losingToAutomaton():void {
	clearOutput();
	outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest.\n\n");
	cleanupAfterCombat();
}
}
}