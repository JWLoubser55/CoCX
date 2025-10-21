/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class EliseFollower extends NPCAwareContent
{
	
	public function EliseFollower() 
	{}

public function EliseMainMenu():void {
	clearOutput();
	outputText("Elise glances at you, eyes dulled with boredom, but still with deep, blood induced loyalty.\n\n");
	outputText("She sighs before speaking curtly to you, \"<i>Yes?</i>\"\n\n");
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