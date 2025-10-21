/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class BarometzScene extends BaseContent
	{
		public function barometzDeepwoods():void {
			clearOutput();
			outputText("While exploring the deep woods you suddenly walk unto the sight of a large centauress with dark skin the color of bark and greenish fur. A quick review confirms to you that she is a strange mix of plant, animal and human.\n\n");
			outputText("Her pelt is covered with vines which seem to grow naturally from her back while what you mistook for a tail is a lush set of leaves. On her head she sports a pair of spiraling horns like those of a ram. Her greenish eyes with pupils slitted horizontally like those of a goat stares at you with open hostility. The centauress staff is pointed at you ready to unleash combat magic.\n\n");
			outputText("\"<i>Outsider, you have invaded a sacred ground for this transgression you shall be met with "+(player.hasVagina()?"vaginal":"anal")+" punishment now bend over!</i>\"\n\n");
			outputText("Uh wait what?\n\n");
			outputText("Something beneath the centauress' hindquarter explodes with movement as a huge greenish flared cock accompanied by a set of writing tentacles slides out of the hermaphrodite taur sheath flailing around and dripping with goop at her excitement.\n\n");
			outputText("\"<i>Ahh damn do I love to dispense punishment… come here!</i>\"\n\n");
			outputText("Yea no, that's not happening! You ready yourself for battle as you engage the forest guardian.\n\n");
			startCombat(new Barometz());
		}
		//outputText("\"<i></i>\"\n\n");
		public function barometzDeepwoodsWon():void {
			clearOutput();
			outputText("The Barometz sensing her imminent defeat pulls out a final gambit creating a wall of tall grass to block as she runs for it. You know better than to chase after a galloping centaur it looks like you will have to content yourself with the gems and loot she dropped.\n\n");
			cleanupAfterCombat();
		}
		
		public function barometzDeepwoodsLost():void {
			clearOutput();
			outputText("As you fall onto the ground, defeat the barometz circle, your form smirking.\n\n");
			outputText("\"<i>Now to keep you in place so you don’t escape.</i>\"\n\n");
			outputText("She waves a few sign causing roots underground to bind your arm and legs as she trots behind you. As you begin to struggle against the restraint you glimpse two hoofed leg move past each side of you as a large flared head side against your [ass] seeking purchase. As the hardening member finally finds your entryway, ");
			outputText("small tentacle like tendrils shoot into you and stretch your "+(player.hasVagina()?"vagina":"hole")+" wide for the massive horsecock to join in. With one motion you are now impaled by the massive equine penis of the Barometz while her other tentacle still wriggles inside your abused hole.\n\n");
			outputText("\"<i>Hiiiiiiiiii, this is so great Its been so long since I fucked! Cmon slut give me a good time.</i>\"\n\n");
			outputText("Your protest are swiftly silenced as the horny tentacled centauress ravages your hole with her composite of dicks turning your insides into a mess. You swing forward and backward as the vegetaur thrusts wantonly into you, its many tentacles taking turns going in and out.\n\n");
			outputText("\"<i>Ahhhn that’s it slut mmmh… I’m about to cum take it all in!</i>\"\n\n");
			outputText("Before you can protest you feel the many cocks fucking your hole all thrusting in at the same time and expending as they unleash ropes of cum one after another inyo your ravaged hole. One even slide out just in time to shower your back with semen.\n\n");
			outputText("A single kick sends you sprawling over forward as the Barometz run back into the undergrowth vanishing from sight after marking her territory. You pass out exausted from the ordeal only waking hours later before you proceed to clean up and redress heading back to camp to recover.\n\n");
			if (player.hasVagina()) player.sexReward("cum", "Vaginal");
			else player.sexReward("cum", "Anal");
			cleanupAfterCombat();
		}
	}
}