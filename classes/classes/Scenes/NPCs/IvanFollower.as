/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class IvanFollower extends NPCAwareContent
{
	
	public function IvanFollower() 
	{}//Minotaur - possible: blacksmith helper, scavenger (like Marble), camp building helper

public function IvanMainMenu():void {
	clearOutput();
	outputText("Approaching his bedroll and calling his name, the minotaur stops in his tracks as he stands before you with head bowed.\n\n");
	outputText("\"<i>What can I do for you "+player.mf("master","mistress")+"?</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campSlavesMenu);
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