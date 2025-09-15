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
	outputText("\"<i> "+player.mf("Master","Mistress")+"?</i>\"\n\n");
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