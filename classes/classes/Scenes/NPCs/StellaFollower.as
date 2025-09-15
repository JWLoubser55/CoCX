/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class StellaFollower extends NPCAwareContent
{
	
	public function StellaFollower() 
	{}
//goblin that have all traits of succubus (up to 12 tiny horns) and atavism mutation of double bat wings ^^, very flat due to not have yet any daughters so she also pretty horny all the time and desperate to get pregnant
//cursed by ezekiel so in combat or outside combat it apply on enemies/potential studs Ezekiel Curse causing life drain, looking for stud that can not start dying due to curse (those with Ezekiel Blessing perk)
//other side effect of curse will be her giving birth to exactly copies of her so already been succubus goblin like looking daughters ^^

public function StellaMainMenu():void {
	clearOutput();
	outputText("Hearing your steps, she turns toward you, admiring you with her heartshaped pupils before speaking in a sultry tone.\n\n");
	outputText("\"<i>Do you need something from this lil one "+player.mf("master","mistress")+"?</i>\"\n\n");
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