/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

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
	if (flags[kFLAGS.ECIHTEL_FOLLOWER] == 1) outputText("You see that strange dragon-like demoness having made a small camp as she rests under some impromptu cover. You consider approaching her.\n\n");
	else {
		outputText("The risk is huge, you admit. You are not sure what unknown being is inside the cocoon, nor what it would do when you break the shell. But there are demons everywhere that are looking for a new soul to eat. They even tried to crack this object in their insatiable thirst for souls. If worst comes to worst, you would either fight that thing inside or run, leaving the problem for any demons to deal with.\n\n");
		outputText("With a firm resolve, you start to look for something to be used as a tool when cracking this large egg. Lucky for you, there are few large stones nearby that others trying to get in seem to have ignored.\n\n");
		outputText("Picking them up, you walk to the cocoon and start slamming it in places where there is one of the deeper cracks. Fifteen minutes later, you still haven’t broken the shell, but you can feel it would be any moment... then as if on queue, the cocoon surface breaks.\n\n");
		outputText("From the hole you tore, fluid starts to gush out. Not wanting to get drenched in the strange substance, you move a step away letting it flow until the level of fluid inside drops down. Afterward, there is small movement inside, and then another and another. Whoever was inside seems awoken by some of the fluid inside leaking out.\n\n");
		outputText("After another few minutes, the entity inside starts to tear itself out, which makes the strings appear like it was made of thin paper. A woman emerges from the remains of the rapidly hollowing shell.\n\n");
		outputText("She has long, luxurious purple hair-- wet from being submerged in that liquid. You notice black roses that someone may have interwoven into her hair. She has a pair of goat-like horns, and her face is decorated with black-rimmed eyes and slit pupils that still remain slightly unfocused.\n\n");
		outputText("Her skin has a pink shade, an unusual skin color that suggests she may have some demonic origins. Behind her unfurls dragon wings that send liquid with each of their flaps. As she steps out of the cocoon remains, you notice her legs have bone protrusions as if they were bone heels. Barred of any fabric covering her body, she is nude before you. Compared to other demonic beings, she shares similarities; looking like she's a pure woman with her labia visible to you and a pair of supple, yet slim breasts.\n\n");
		outputText("\"<i>Lethiceeeee!!!!</i>\" She yells suddenly and rushes at you with still unfocused eyes. Right as she reaches to grab you, she stops and her eyes finally lock its gaze. She stops motionlessly until you clear your throat.\n\n");
		outputText("\"<i>"+(silly()?"What year is it?":"How long have I been sealed?!")+"</i>\" She finally asks.\n\n");
		outputText("You reply that you do not know, to which she simply tilts her head. Then she looks at the sky, \"<i>The sky is looking worse than last time I saw it….</i>\" Her voice falls silent in quiet contemplation.\n\n");
		outputText("You consider pointing out her naked state but she starts walking away as if nothing happened. Finally, you have to ask where she’s going, especially given the fact she’ll attract some very unfortunate company with her breasts out and about.\n\n");
		outputText("\"<i>To Lethice’s stronghold, naturally,</i>\" she replies while casually looking at her body. Without warning, she utters a high pitched scream that attracts a few imps, jumping from who knows where. The imps rush toward their next meal.\n\n");
		outputText("\"<i>Soulless filth,</i>\" the woman utters in a low voice as she waves her hand toward them. And next thing you see if all attacking imps vanish in cross shaped explosions of pure energy. Clearly exhausted from the use of such magic, she staggers, nearly falling down.\n\n");
		outputText("\"<i>Weak, unclean flesh,</i>\" she complains as she struggles to stay upright. Falling deep into thoughts, she then turns back to you. \"<i>Do you know where I could recover until I could go find my kind?</i>\"\n\n");
		outputText("She sure does wield some immense power, and with the vitriol she carries toward Lethice, perhaps the two of you could help each other. That said, are you sure you want to bring her along? Who knows what she’s capable of.\n\n");
	}
	menu();
	if (flags[kFLAGS.ECIHTEL_FOLLOWER] == 1) addButton(1, "No", coccoonFoundedCrackNoRepeat);
	else addButton(1, "No", coccoonFoundedCrackNo);
	addButton(3, "Yes", coccoonFoundedCrackYes);
}
public function coccoonFoundedCrackNoRepeat():void {
	clearOutput();
	outputText("You head back to camp.\n\n");
	doNext(explorer.done);
}
public function coccoonFoundedCrackNo():void {
	clearOutput();
	outputText("You tell her you don’t know any place that could offer her safety.\n\n");
	outputText("She sighs softly before turning away. \"<i>Then I’ll have to find a place to recover by myself for a time being. Perhaps we’ll meet again.</i>\"\n\n");
	flags[kFLAGS.ECIHTEL_FOLLOWER] = 1;
	doNext(explorer.done);
}
public function coccoonFoundedCrackYes():void {
	clearOutput();
	outputText("You tell her you do know a place she could be safe and recover, she need only follow you.\n\n");
	outputText("For a moment, wariness, but given her lack of options, she seems to follow you without any complaint.\n\n");
	outputText("On way back she finds some rags that cover her slightly. And when asked about any name or something like that she only replies she not remember.\n\n");
	if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("\"<i>What have you brought [name]?</i>\" Amily wanders around the succubus-like woman before giving you a side eye, stepping back without another word.\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("\"<i>She looks like a demon, but also appears to wield a certain holiness within. Such a paradox.</i>\" Jojo remarks before returning to his duties.\n\n");
	if (vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) outputText("When walking past Vapula’s hiding spot in camp, you hear muffled mumbling that’s too quiet to make anything out of it. Yet the succubus walking next to you turns her gaze directly toward the spot for a fraction of a second. The Owca oppressor looks like she's struggling with something and then gives up, taking her gaze back to look ahead of her.\n\n");
	if (ceraphIsFollower() && !player.hasStatusEffect(StatusEffects.CeraphOff)) outputText("Despite not appearing in camp, you later are visited when you went out by Ceraph, who seems confused seeing new camp member from afar. Like someone she used to know yet it seems so alien now.\n\n");
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) outputText("\"<i>Who’s your friend, [name]? She’s not of a typical demon… What strange foiling, hmmm?</i>\" Siegweird chuckles softly. \"<i>Be wary, I doubt she fully realizes it yet herself, but who knows.</i>\"\n\n");
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12 && flags[kFLAGS.ALVINA_FOLLOWER] < 20 && !SceneLib.alvinaFollower.AlvinaPurified) {
		outputText("On your way to the Camp you spot Alvina casualy laid back against a tree glancing at you sideway giving you an amused smile.\n\n");
		outputText("\"<i>My oh my champion you wen't and collared THAT person out of all the demons you could tame. You do realise ifpeople find out this demon is Lethice there will be hell to pay? How bold, aren't you effraid folks will storm your camp with pitchfork and torches on a witch hunt. ");
		outputText("Not that it is my place to say anything seeing as I'm the reason she ended up like this but she do is Mareth most wanted criminal right now. If you ever change your mind and decide not to kill her still, I can always lock her up in a dimensional rift somewhere.</i>\"\n\n");
	}
	if (SceneLib.alvinaFollower.AlvinaPurified) {
		outputText("Alvina run to you the moment you arrive in the camp saying worringly.\n\n");
		outputText("\"<i>[name] why did you bring her here?! She's completely beyond saving as a person! I should know I'm the one who accidentaly created the demons there's no way you could seriously think she can be helped. She doesn't even has a soul left to redeem!</i>\"\n\n");
	}
	outputText("Seeing most of the camp, the pink skinned succubus decides to settle near the sparring area.\n\n");
	outputText("\"<i>Ecihtel.</i>\" she speaks when you are about to walk away. \"<i>I think that could be my name. And I think this may be useful to you.</i>\" She tosses a shining shard to you.\n\n");
	outputText("\n\n(<b>Ecihtel now available in the followers menu.</b>)");
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	flags[kFLAGS.ECIHTEL_FOLLOWER] = 2;
	doNext(explorer.done);
}
public function EcihtelMainMenu():void {
	clearOutput();
	outputText("When you approach, Ecihtel stops what she’s doing and turns to you. \"<i>Something you want my help with? I’m ready for slaying more demons, always.</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campFollowers);
}
/*
public function aaa():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}

public function aaa():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\"<i></i>\"\n\n");
}
*/
}
}