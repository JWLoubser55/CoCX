/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
	
	public class WaizAbiFollower extends NPCAwareContent implements SaveableState
	{
		public static var WaizAbiState:Number;//state or status (friend, lover, etc.)
		public static var WaizAbiAffection:Number;
		public static var WaizAbiWrathMulti:Number;
		public static var WaizAbiHPMulti:Number;
		public static var WaizAbiSoulforceMulti:Number;
		public static var WaizAbiLustMulti:Number;
		public static var WaizAbiOtherSecondaryBarsMulti:Number;//mana, fatigue ?and hunger?
		public static var WaizAbiStrMulti:Number;
		public static var WaizAbiSpeMulti:Number;
		public static var WaizAbiTouMulti:Number;
		public static var WaizAbiWisMulti:Number;
		public static var WaizAbiIntMulti:Number;
		public static var WaizAbiLibMulti:Number;
		public static var WaizAbiSensMulti:Number;

		public function stateObjectName():String {
			return "WaizAbiFollower";
		}

		public function resetState():void {
			WaizAbiState = 0;
			WaizAbiAffection = 0;
			WaizAbiWrathMulti = 1;
			WaizAbiHPMulti = 1;
			WaizAbiSoulforceMulti = 1;
			WaizAbiLustMulti = 1;
			WaizAbiOtherSecondaryBarsMulti = 1;
			WaizAbiStrMulti = 1;
			WaizAbiSpeMulti = 1;
			WaizAbiTouMulti = 1;
			WaizAbiWisMulti = 1;
			WaizAbiIntMulti = 1;
			WaizAbiLibMulti = 1;
			WaizAbiSensMulti = 1;
		}

		public function saveToObject():Object {
			return {
				"WaizAbiState": WaizAbiState,
				"WaizAbiAffection": WaizAbiAffection,
				"WaizAbiWrathMulti": WaizAbiWrathMulti,
				"WaizAbiHPMulti": WaizAbiHPMulti,
				"WaizAbiSoulforceMulti": WaizAbiSoulforceMulti,
				"WaizAbiLustMulti": WaizAbiLustMulti,
				"WaizAbiOtherSecondaryBarsMulti": WaizAbiOtherSecondaryBarsMulti,
				"WaizAbiStrMulti": WaizAbiStrMulti,
				"WaizAbiSpeMulti": WaizAbiSpeMulti,
				"WaizAbiTouMulti": WaizAbiTouMulti,
				"WaizAbiWisMulti": WaizAbiWisMulti,
				"WaizAbiIntMulti": WaizAbiIntMulti,
				"WaizAbiLibMulti": WaizAbiLibMulti,
				"WaizAbiSensMulti": WaizAbiSensMulti
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WaizAbiState = o["WaizAbiState"];
				WaizAbiAffection = o["WaizAbiAffection"];
				WaizAbiWrathMulti = o["WaizAbiWrathMulti"];
				WaizAbiHPMulti = o["WaizAbiHPMulti"];
				WaizAbiSoulforceMulti = o["WaizAbiSoulforceMulti"];
				WaizAbiLustMulti = o["WaizAbiLustMulti"];
				WaizAbiOtherSecondaryBarsMulti = o["WaizAbiOtherSecondaryBarsMulti"];
				WaizAbiStrMulti = o["WaizAbiStrMulti"];
				WaizAbiSpeMulti = o["WaizAbiSpeMulti"];
				WaizAbiTouMulti = o["WaizAbiTouMulti"];
				WaizAbiWisMulti = o["WaizAbiWisMulti"];
				WaizAbiIntMulti = o["WaizAbiIntMulti"];
				WaizAbiLibMulti = o["WaizAbiLibMulti"];
				WaizAbiSensMulti = o["WaizAbiSensMulti"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function WaizAbiFollower() //adorable bimbo monkey... err sayian
		{
			Saves.registerSaveableState(this);
		}
		//WaizAbiStory: 1 - x, 2 - x, 3 - x
		public function bimboMonkey():void {
			clearOutput();
			outputText("\"<i>O Hai there,</i>\" she says looking over you from head to feet and back. \"<i>Mmmmm maybe you could put a good 'fight'...If not, beating you down could be...Fun...</i>\" Her voice trails off, her gaze dropping to your [legs], her eyes half-lidded. She licks her lips slowly, gaze slowly moving back up your frame.\n\n");
			outputText("On one hand, her muscular arms flex, but on the other, she's giving you a rather lascivious glance. You ask her why she's speaking in riddles. Is the bimbo asking for a fight, or a fuck?</i> You ask, only to get a smile, her lip curling ever so slightly.\n\n");
			outputText("\"<i>Oh, poor little champion. Faced with a choice, and you don't know how to react.</i>\" She smirks, bringing one hand to grasp her formidible breast. \"<i>Maybe this is one thing that you get to choose. I get my fun either way.</i>\" She awaits your reaction, blatantly oogling your body while she sips from her wine glass.\n\n");
			menu();
			addButton(1, "Sex", bimboMonkeySex);
			addButton(2, "Fight", bimboMonkeyFight);
			if (WaizAbiState == 1 && flags[kFLAGS.SPIRIT_STONES] >= 3 && player.hasItem(consumables.DEBIMBO, 1) && player.hasItem(useables.D_E_ICHOR, 1)) addButton(3, "Drink", bimboMonkeyDrink);
			if (silly()) {
				if (WaizAbiState == 0) addButtonIfTrue(12, "'DRINK'", bimboMonkeyDrink1, "You need to have 2 spirit stones.", flags[kFLAGS.SPIRIT_STONES] >= 2);
				addButton(13, "'FIGHT'", bimboMonkeyMockFight);
			}
			addButton(14, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
		}//outputText("\"<i></i>\"\n\n");
		public function bimboMonkeySex():void {
			clearOutput();
			outputText("Then maybe a good 'fight'?\n\n");
			outputText("\"<i>Really???</i>\" her eyes light up, and she leaps to her feet, carelessly putting her glass to one side. After getting up she grabs your hand, and leads you to the entrance.\n\n");
			outputText("\"<i>Stop right there!</i>\" An angry voice calls to you, heavy footsteps getting closer. You turn, catching sight of your pursuer. She's a pale blue skinned woman, with average-sized breasts and hips, both hidden under a layer of light armor. She pivots, unfolding a single snow-white wing, forcefully putting the limb between you and the bimbo monkey. Your would-be paramour lets out an annoyed groan, but a single glare from the angelic woman is all it takes to cow her. The blue-skinned woman forces her way in, glaring at you with her lips curled in disgust.\n\n");
			outputText("\"<i>Return home, milady. Someone needs to be taught a lesson.</i>\" The newcomer silently glares at the bimbo-monkey, who eventually looks down and away, leaving the area with a huff. Once she's gone, the blue-skinned angel points towards the Soul Arena. \"<i>What's it going to be, sex-freak? Are you gonna join me in the ring, or do I need to drag you there myself?</i>\"\n\n");
			outputText("Slightly annoyed by the interruptionto your 'fight', you give the angel a slow nod, entering the arena.\n\n");
			outputText("\"<i>Lesson one.</i>\" She sinks into a low combat stance, unfolding her wings. <i>\"What happens when a pervert tries to take advantage of milady? Let me demonstrate!</i>\"");
			startCombat(new Koshya());
		}
		public function bimboMonkeyFight():void {
			clearOutput();
			outputText("You're in the mood for a good beatdown.\n\n");
			outputText("\"<i>Ohhh, a beatdown? Well i can get behind that too.</i>\" she slowly puts the glass down. After getting up she takes your hand in a surprisingly strong grip, leading you out of the bar.\n\n");
			outputText("You follow her past the marketplace, around the lesson hall and into the Soul Arena. You quickly find an empty arena, and the bimbo monkey grins as you begin to face off. She leans back, a sudden wind slamming into you as she screams. Her eyes begin to glow red, her tail whipping behind her. As she roars, teeth glinting, she takes a step towards you...and a blur of motion lands between you two. The bimbo monkey tries to dodge around, but a white wing intercepts. As she turns to face you, you get a better look at this interloper. She has pale blue skin, and an unassuming face, just feminine enough to leave no doubt as to her gender. Her build is completely unspectacular, bust, hips and muscles almost tailored to be as average as possible.\n\n");
			outputText("\"<i>Ma'am, this battle is beneath you. I shall take your place in this battle.</i>\" She speaks gently, but the look in her eyes is stern. She may be acting as a servant, but this...almost sounds like an order.\n\n");
			outputText("\"<i>But why can't I even fight? No fucks, no fights... You're supposed to be my servant, not my nanny.</i>\" The bimbo monkey pouts but still obeys, jumping toward the nearby stands. \"<i>This time, I'll let it slide. But you won't interrupt my next fight...</i>\"\n\n");
			outputText("\"<i>Of course milady.</i>\" The angel woman brings her gaze to you. \"<i>Of course, you may still watch. This one should be able to provide you some entertainment.</i>\"\n\n");
			startCombat(new Koshya());
		}
		public function bimboMonkeyDrink():void {
			clearOutput();
			player.destroyItems(consumables.DEBIMBO, 1);
			player.destroyItems(useables.D_E_ICHOR, 1);
			flags[kFLAGS.SPIRIT_STONES] -= 3;
			statScreenRefresh();
			WaizAbiState = 2;
			outputText("It seems that she enjoys drinking good wine. Maybe you could find something that would live up to her idea of a strong, alcoholic beverage.\n\n");
			outputText("\"<i>An alcohol beverage I’ve not tried? I'm... interested. Go on.</i>\" The monkey places down the glass as her angel companion scrutinized you with such intensity as if she would like to bore a hole in you by simply staring. Under both gazes, you excuse yourself for a moment.\n\n");
			outputText("Walking to the barman you put a few Spirit Stones on the bar and ask for two glasses, asking which one of the wines he got is of decent quality. While listening to the names, you pull out two bottles from your inventory and pour equal amounts in each glass. You pick a wine that seemed appropriate and pour it in the drinks. Mixing with the previously poured substance, its shade turns darker, nearly black. Hopefully it’ll do as you take both glasses to the table and put them before both monkey and angel.\n\n");
			outputText("The blue skinned woman looked at the glass before her with suspicion, asking her companion to not quaff so quickly. She took it to her hand to look at from a few angles, even sniffing, trying to find something suspicious. After a moment, she tasted the liqueur herself. After all her prodding, she couldn’t find anything weird, but before she said a word of approval, the monkey had already grabbed the glass and quenched her thirst in one breath.\n\n");
			outputText("\"<i>Tastes... weird. A bit alcoholic and a bit of something else.</i>\" She licks her lips as she suddenly grabs her heart, uttering a low groan.\n\n");
			outputText("The angel immediately turns her attention to you, \"<i>What did you add...</i>\" but she is interrupted in the middle of the sentence. \"<i>Koshya… I feel… My head hurts. Please, take me to our room.</i>\" The monkey seems to be a bit different. It appears adding those few extra things to wine is starting to work.\n\n");
			outputText("\"<i>I would find you soon after I help milady,</i>\" blue-skinned angel uttered in your direction before helping her monkey boss walk to their room.\n\n");
			outputText("Now alone at the table, you look at the one empty, and the other half drank glass. You didn't put anything toxic in their drinks. Just something that could help become a bimbo, and to think more 'clearly'. Who knows, maybe it will have a good outcome.\n\n");
			doNext(curry(SceneLib.journeyToTheEast.enteringInn, false));
			advanceMinutes(15);
		}
		public function bimboMonkeyDrink1():void {
			clearOutput();
			flags[kFLAGS.SPIRIT_STONES] -= 2;
			statScreenRefresh();
			WaizAbiState = 1;
			outputText("Seeing how she sipped her wine, you excuse yourself and walk with your Arrogant Young "+player.mf("Masterly","Mistressly")+" gait toward the barman. With a routine practiced to perfection, you slam your hand on the counter with enough force through the contact of your palm that everyone could hear it as you yelled.\n\n");
			outputText("\"<i>Two bottles of your FINEST wine.</i>\" The Barman, amazed by your AYM aura, scrambled to the backroom and brought back ONE SINGLE bottle of one million years old wine called 'T.H.E. F.I.N.E.S.T. W.I.N.E.'\n\n");
			outputText("\"<b>TWO bottles!</b>\" You are practically yelling at which barman who shrunk back and mumbled in a barely audible voice. \"<i>The Young Arrogant Mistress at table No.5 ordered one bottle half an hour ago.</i>\"\n\n");
			outputText("Looking back at the famous table no.5 you see a person that farmed the aura of YAM by simply breathing. Calculating silently in your mind, you decide it's not worth fighting over one more bottle with a fellow YAM. \"<i>Fine but i will only let it slide this ONE TIME, understood?</i>\" you proclaim while grabbing the bottle, tossing a few spirit stones at the table.\n\n");
			outputText("Returning triumphantly to the table you cast your gaze toward the monkey while opening your bottle.\n\n");
			outputText("\"<i>Mhmmm,</i>\" she licks her lips in anticipation of tasting THAT wine when the arrogant sidekick... Well, more mean, blue-skinned assistants unceremoniously take the opened bottle out of your hands to start pouring it into the monkey’s empty wine glass. \"<i>Enough aura farming here. Milady will forever and ever remember your gesture.</i>\"\n\n");
			outputText("Realizing you opened your mouth so much that a large egg could fit in your pie hole, you shut it up before the angel finished filling the glass as she turned her face, shooting daggers into you with that lethal glower.\n\n");
			outputText("\"<i>Some thing else?</i>\" she asks. Seeing as the bimbo boss already started becoming intoxicated and practically forgetting your existence, you turn toward the exit, leaving the masses amazed at your generosity of dropping the matter of being totally ignored.\n\n");
			doNext(curry(SceneLib.journeyToTheEast.enteringInn, false));
			advanceMinutes(15);
		}
		public function bimboMonkeyMockFight():void {
			clearOutput();
			outputText("\"<i>It's Rumbling Timeeeeee!!!!!!!</i>\"\n\n");
			startCombat(new WaizAbi());
		}
		
		public function WaizAbiAndKoshyaArriveAtTheCamp():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function WaizAbiMainMenu():void {
			
		}
		
		/*public function c():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		
		public function b():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		
		public function a():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}*/
	}
}