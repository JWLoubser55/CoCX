package classes.Scenes.Places
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

import coc.view.ButtonDataList;

public class SlaveDen extends BaseContent
{
	
	public function SlaveDen() 
	{}

public function trapDoor():void {
	clearOutput();
	if (flags[kFLAGS.BAAZAR_SLAVE_DEN] > 0) {
		outputText("You enter the den, quickly finding Shaytan tending to paperwork. He looks up at you, \"<i>Ah, welcome back. Here to browssse my waresss again?</i>\"\n\n");
	}
	else {
		outputText("<b>THIS IS A PLACEHOLDER INTRODUCTION. The first real intro will be added once it’s completely written… and Orm have times to code all the bloated shit in. Apology for the inconvenience.</b>\n\n");
		outputText("You enter the trap door.\n\n");
		outputText("You drop into the slaver’s cave, this time landing on your feet. You make your way down the dark tunnel until you reach a familiar scene. You find a snake-morph, in particular clothing, an eastern garment fashion in black and red color. He’s setting a new game on a stone slap, from the looks of it, you believe it’s Mahjong. \"<i>Ah, new guestsss</i>\" He quickly finishes setting the game before getting up to greet you.\n\n");
		outputText("\"<i>My name is Sssshaytan, for I welcome to our little humble shop.</i>\" He said as his tongue continues rolls out from this words.\n\n");
		outputText("You asked, what does he sells here. The snakeman simply said \"<i>Why, Ssslav- I mean, people of course. People who are…. Unfortunate enough to be locked behind cagessss and chains.  Mostly foolsss who didn’t have enough coinssss, runaway fugitivesss and many more, ssss~</i>\"\n\n");
		outputText("\"<i>I assssume you are here to check my waresss, perhapsss find a diamond in the rough?</i>\" He bows and gestures you to follow, leading through the tunnel of torches. You find yourself in the room, filled wall to wall with cages of various slaves. He turns to look at you, gesturing at the many slaves he holds, \"<i>Feel free to browssse. If any of them catch your eye, then let me know.</i>\" You thank Shaytan, and turn to face the cages.\n\n");
		flags[kFLAGS.BAAZAR_SLAVE_DEN] = 1;
	}
	menu();
	addButtonDisabled(0, "Talk", "Writers have Sage Time break now so cum later.");
	addButton(1, "Browse", browseSlaves);
	addButtonDisabled(4, "More options???", "Only for VIP customers and currently under renovation due to last slaves ramapage after they were released by Blind Purity undercover cultivator.");
	addButton(14, "Leave", trapDoorLeave);
}
private function trapDoorLeave():void {
	clearOutput();
	outputText("You tell Shaytan you did all you wanted today, and that you’ll be leaving now. You could see the serpent’s eye twitch, seeing as you bought nothing and only wastes his time. \"<i>I sssee,</i>\" he holds back his annoyance, and remains courteous, \"<i>very well. May you find something worth buying on your next visit.</i>\" He gives you a short bow, and you turn and walk away.\n\n");
	outputText("Exiting the trapdoor, you spot something from the corner of your eye, two familiar figures who quickly retreat as you exit. It seems Shaytan’s guards were on high alert, but that doesn't matter to you right now. You ignore them and return to the Bazzar.\n\n");
	doNext(SceneLib.bazaar.enterTheBazaar);
}
private function browseSlaves():void {
	clearOutput();
	outputText("Wandering around the room, you find various beings that seem like they’d be appealing to own. You’re not sure what you would buy them for yet, but you could always use more hands at your camp, there should be no harm in a purchase or two. A few come to mind, which do you want?\n\n");
	menu();
	addButton(0, "Slave 1", browseSlaves1);
	addButton(1, "Slave 2", browseSlaves2);
	if (player.isRace(Races.VAMPIRE, 2) || player.isRace(Races.DRACULA)) addButton(2, "Slave 3", browseSlaves3);
	addButton(14, "Back", trapDoor);//min price is 100 spirit stones or 1,000 gems - 1:10 prices exchange ratio (spirit stones for cultivator slaves and gems for rest)
}
private function browseSlavesNo():void {
	clearOutput();
	outputText("\"<i>I underssstand, no one perssson desssiresss every available tool.</i>\" He backs away, returning to his counter where he watches you, \"<i>If you find sssomething elssse interesssting, I will be there.</i>\"\n\n");
	outputText("You back away from the cage, continuing your aimless wandering through the cave of slaves. Perhaps something else here can be of use to you.\n\n");
	doNext(browseSlaves);
}
private function browseSlaves1():void {
	clearOutput();
	outputText("You approach one of the cages, seeing (goblin - nothing more here as desc is pending Pyro qc-ing)\n\n");//small goblin with three pairs of demonic horns, tail and two pairs of small bat wings. Her body is covered with various demonic pleasure runes. Plaque next to her warns about her body have draining effect on anyone getting in direct contact with her.
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 1,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Sssstella, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves1Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves2():void {
	clearOutput();
	outputText("You approach one of the cages, seeing (minotaur - nothing more here as desc is pending Pyro qc-ing)\n\n");//
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 1,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Ivan, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves2Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves3():void {
	clearOutput();
	outputText("You approach one of the cages, seeing (werewolf - nothing more here as desc is pending Pyro qc-ing)\n\n");//
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 1,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Elissssse, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves3Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves4():void {
	clearOutput();
	outputText("You approach one of the cages, seeing {insert slave description}\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads {slave price}. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in {slave’s name {add S’s as needed}}, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves4Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves5():void {
	clearOutput();
	outputText("You approach one of the cages, seeing {insert slave description}\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads {slave price}. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in {slave’s name {add S’s as needed}}, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves5Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

private function moreOptionsBackdoor():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

}
}