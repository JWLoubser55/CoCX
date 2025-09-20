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
		outputText("You enter the trap door, finding it leading into what looks to be a cave. Seeing no resistance, you decide to jump in.\n\n");
		outputText("Dropping into the cave, you land on your feet. You make your way down the dark tunnel before you until you reach an odd scene. You find a snake-morph in peculiar clothing, the garment seemingly eastern in fashion sense, colored with black and red. He’s setting a game on a stone slap table. From the looks of it, you believe it’s Mahjong. \"<i>Ah, new guessstsss.</i>\" He finishes setting the game quickly before getting up to greet you.\n\n");
		outputText("\"<i>My name isss Shaytan, and I welcome you to our little humble shop.</i>\" He says, his tongue rolling out with every S in his words.\n\n");
		outputText("Curious, you ask what he sells here. The snake chuckles, a sinister grin on his face, \"<i>Why, Sssla- I mean, people of courssse. People who are... Unfortunate enough to be locked behind cagesss and bound by chainsss.  Many are foolsss who didn’t have enough capital, runaway fugitivesss, and so much more.</i>\"\n\n");
		outputText("\"<i>I assssume you are here to check my waresss, perhapsss find a diamond in the rough?</i>\" He leans down and gestures for you to follow, leading you towards a tunnel lined with torches. At the end, you find yourself in the room filled wall to wall with locked cages. \"<i>Before you can shop, all shoppersss get a cussstomary pendant.</i>\" Reaching into a desk, he gives you a small glass pendant. \"<i>It letsss me know you are a cussstomer, and not sssome ssself righteousss fool.</i>\"\n\n");
		outputText("He turns to you, gesturing at the many slaves he holds captive, \"<i>Feel free to browssse. If any of them catch your eye, I will be there to assssissst you.</i>\" You sheepishly thank Shaytan, and turn to face the cages.\n\n");
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
	outputText("You tell Shaytan you did all you wanted today, and that you’ll be leaving now. You could see the serpent’s eye twitch, seeing as you bought nothing and only wastes his time. \"<i>I sssee,</i>\" he holds back his annoyance, and remains courteous, \"<i>very well. May you find sssomething worth buying on your nexsst visssit.</i>\" He gives you a short bow, and you turn and walk away.\n\n");
	outputText("Exiting the trapdoor, you spot something from the corner of your eye, two familiar figures who quickly retreat as you exit. It seems Shaytan’s guards were on high alert, but that doesn't matter to you right now. You ignore them and return to the Bazzar.\n\n");
	doNext(SceneLib.bazaar.enterTheBazaar);
}
private function browseSlaves():void {
	clearOutput();
	outputText("Wandering around the room, you find various beings that seem like they’d be appealing to own. You’re not sure what you would buy them for yet, but you could always use more hands at your camp, there should be no harm in a purchase or two. A few come to mind, which do you want?\n\n");
	menu();
	if (flags[kFLAGS.STELLA_FOLLOWER] >= 1) addButtonDisabled(0, "Slave 1", "SOLD");
	else {
		addButton(0, "Slave 1", browseSlavesStella);
	}
	if (flags[kFLAGS.IVAN_FOLLOWER] >= 1) addButtonDisabled(1, "Slave 21", "SOLD");
	else {
		addButton(1, "Slave 2", browseSlavesIvan);
	}
	if (flags[kFLAGS.SYTHRIL_FOLLOWER] >= 1) addButtonDisabled(2, "Slave 3", "SOLD");
	else {
		addButton(2, "Slave 3", browseSlavesSythril);
	}
	if (flags[kFLAGS.ELISE_FOLLOWER] >= 1) addButtonDisabled(3, "Slave 4", "SOLD");
	else {
		if (player.isRace(Races.VAMPIRE, 2) || player.isRace(Races.DRACULA)) addButton(3, "Slave 4", browseSlavesElise);
	}
	addButton(14, "Back", trapDoor);//min price is 1,000 spirit stones or 10,000 gems - 1:10 prices exchange ratio (spirit stones for cultivator slaves and gems for rest)
}
private function browseSlavesStella():void {
	clearOutput();
	outputText("As you approach one of the cages, you see a small goblin with three pairs of demonic horns, a tail and two pairs of small bat wings. Her body is covered with various demonic pleasure runes. The plaque next to her warns about her body having a draining effect on anyone getting in direct contact with her.\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 10,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Sssstella, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonIfTrue(6, "Yes", curry(browseSlavesYes, 1, 10000, "goblin", "Stella"), "You don't have 10,000 gems.", player.gems >= 10000);
	addButton(8, "No", browseSlavesNo);
}
private function browseSlavesIvan():void {
	clearOutput();
	outputText("You approach one of the cages, seeing a tall minotaur, gaunt and hobbled over, his ribs visible due to lack of enough food. His hands have calluses as if it was working with tools all in his life. The plaque next to him mentions him as a blacksmith that could even work the toughest to processed materials.\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 10,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Ivan, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonIfTrue(6, "Yes", curry(browseSlavesYes, 2, 10000, "minotaur", "Ivan"), "You don't have 10,000 gems.", player.gems >= 10000);
	addButton(8, "No", browseSlavesNo);
}
private function browseSlavesSythril():void {
	clearOutput();
	outputText("Curiosity gets the best of you as you decide to approach one of the cages. Before you is well over eight feet of illustrious salamander scales that color your vision red. A closer look reveals faded scars amongst scales that pulse with an eerie purple glow. ");
	outputText("" + (player.cor >= 60 ? "That sickly sweet aura you know all too well. Makes you almost crack a smile.":"An unnatural sensation or presence, you aren't sure which, but it creeps along your spine. Corruption has made its home in this salamander.") + " Further supporting his demonic appearance is a set of expansive bat-like wings behind him, much like you'd expect from the demons in the realm.\n\n");
	outputText("" + (player.tallness >= 96 ? "You meet his gaze and he grins at you, there's a hint of a challenge in that smile. ":"") + "His body screams at you, muscles that would look at home on wild beasts of the plains pepper his huge frame. Biceps bigger than your head connect to broad shoulders, in between scales you spot stretch marks that pulse with that same purple glow. Strong, corded muscles flex all along his neck as his grin reveals sharp teeth.\n\n");
	outputText("Your one-sided ogling is interrupted by a sudden movement of him pressing his chest into the iron bars. Expansive pecs squish against the cold metal provoking pink nipples to stand erect. He seems to be flexing his Herculean build, trying to taunt you –an attempt at seduction. He shows off muscles that would look at home on wild beasts of the plains pepper his huge frame. ");
	outputText("Biceps bigger than your head connect to broad shoulders, in between scales you spot stretch marks that pulse with that same purple glow. Strong corded muscles flex all along his neck as his grin reveals sharp teeth. You meet his gaze  for the first time and get the feeling that perhaps the only thing preventing him from breaking out of the cage and ravaging you on the sight is the obedience entrained upon him.\n\n");
	outputText("Yet before you can truly admire his stare, you are treated to a glorious sight as gemini pythons jump out at you – splattering pre at his scaled feet. Twin demonic dicks ooze volatile, purple precum that stains the floor. Your eyes rover upwards, tracing the impressive contours of massive calves that support this living pillar. They lead into huge meaty scaled thighs; both defined and bare scars that glow purple. ");
	outputText("Those strong legs connect to a pillar-like waist that flows into two mountainous legs. His meaty scaled thighs coordinate with his massive calves that support the living monument of muscle, both defined contours and scars that mar this statuesque man. The plaque next to her mentions his frame is due to ingesting bro brew.\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 10,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Sssssythril, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonIfTrue(6, "Yes", curry(browseSlavesYes, 3, 10000, "salamander", "Sythril"), "You don't have 10,000 gems.", player.gems >= 10000);
	addButton(8, "No", browseSlavesNo);
}
private function browseSlavesElise():void {
	clearOutput();
	outputText("You approach one of the cages, seeing a woman a little on the tall side. Her face is dappled in many piercings from brow to ear and lips. Looking down, you can see that her navel is also sporting decently sized piercing. The plaque next to her mentions she's a werewolf with faint traces of vampire blood in her body.\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads 10,000 gems. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in Elissssse, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonIfTrue(6, "Yes", curry(browseSlavesYes, 4, 10000, "werewolf", "Elise"), "You don't have 10,000 gems.", player.gems >= 10000);
	addButton(8, "No", browseSlavesNo);
}
private function browseSlaves5():void {
	clearOutput();
	outputText("You approach one of the cages, seeing {insert slave description}\n\n");
	outputText("Having caught your interest, you look to the price tage tied to the cage. It reads {slave price}. A bit pricy, but that’s what you expected from this place. Shaytan approaches from behind, \"<i>Ah, I sssee you are interesssted in {slave’s name {add S’s as needed}}, are you looking to buy thisss one?</i>\"\n\n");
	menu();
	addButtonDisabled(6, "Yes", "Soon (tm)");
	addButton(8, "No", browseSlavesNo);
}
private function browseSlavesYes(slaveNumber:Number, slavePrice:Number, slaveRace:String, slaveName:String):void {
	clearOutput();
	player.gems -= slavePrice;
	outputText("You nod, telling Shaytan that this slave is exactly what you were looking for. His grin grows wide, showing his fangs, \"<i>Very good, I shall get the ownership transssfer ready.</i>\" He unlocks the cage, and drags the "+slaveRace+"’s by their chains, leading them to the main counter.\n\n");
	outputText("You pay your due, dropping "+slavePrice+" gems into Shaytan’s hands, he instantly gots to work. A quick ownership transfer was done, which involved pricking your finger, and allowing your blood to drop onto "+slaveName+"’s enslavement tattoo. Just like that, the transfer was complete.\n\n");
	outputText("\"<i>May they ssserve you well, dear cussstomer, I look forward to your next visssit.</i>\" You thank the slaver for his service, and proceed to take "+slaveName+" out of the den and back to camp. This is going to be interesting.\n\n");
	if (slaveNumber == 1) {
		outputText("(<b>Stella has been added to the Slaves menu!</b>)\n\n");
		flags[kFLAGS.STELLA_FOLLOWER] = 1;
	}
	if (slaveNumber == 2) {
		outputText("(<b>Ivan has been added to the Slaves menu!</b>)\n\n");
		flags[kFLAGS.IVAN_FOLLOWER] = 1;
	}
	if (slaveNumber == 3) {
		outputText("(<b>Sythril has been added to the Slaves menu!</b>)\n\n");
		flags[kFLAGS.SYTHRIL_FOLLOWER] = 1;
	}
	if (slaveNumber == 4) {
		outputText("(<b>Elise has been added to the Slaves menu!</b>)\n\n");
		flags[kFLAGS.ELISE_FOLLOWER] = 1;
	}
	statScreenRefresh();
	doNext(camp.returnToCampUseOneHour);
}
private function browseSlaves2Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves3Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves4Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlaves5Yes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
private function browseSlavesNo():void {
	clearOutput();
	outputText("After some consideration, you decide against it. You have no need for a slave like this. Shaytan simply nods, \"<i>I underssstand, no one perssson desssiresss every available tool.</i>\" He backs away, returning to his counter where he watches you, \"<i>If you find sssomething elssse interesssting, I will be there.</i>\"\n\n");
	outputText("You back away from the cage, continuing your aimless wandering through the cave of slaves. Perhaps something else here can be of use to you.\n\n");
	doNext(browseSlaves);
}

private function moreOptionsBackdoor():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

}
}