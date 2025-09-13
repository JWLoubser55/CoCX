/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class EcihtelFollower extends NPCAwareContent
{
	public function EcihtelFollower() 
	{
		
	}

public function coccoonFounded():void {
	clearOutput();
	outputText("As you explore the hills, you run into what appears to be twelve foot tall, oval shaped object. There's an air of suspicion as the area around it devoid of anything, even local flora. Scanning your surroundings for any surprise attacks from demons... or local fauna-- you approach object and inspect it.\n\n");
	outputText("Now closer, it appears to be some sort of cocoon with a partially translucent surface that shows something-- or someone inside. Seemingly left out to the wild for some time, it bears signs of various natural weapons like claw or bite marks, yet despite the attempts at it, the surface hasn't been pierced anywhere.\n\n");
	menu();
	addButton(1, "Leave", coccoonFoundedLeave);
	addButtonDisabled(3, "Crack", "Maybe you shouldn't crack this nut open... yet?");
}
public function coccoonFoundedLeave():void {
	clearOutput();
	outputText("You're not sure what's inside the cocoon, and checking isn't worth the risk. Some of marks reach quite deep, and maybe it would be easy to open for you, but still, it's too large of an unknown entity, and who knows what may find you as you try to pry it open.\n\n");
	doNext(explorer.done);
}
public function coccoonFoundedCrack():void {
	clearOutput();
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
}

}
}