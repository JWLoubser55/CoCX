/**
 * ...
 * @author ...
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;

public class HollowScene extends BaseContent
	{
		
		public function HollowScene() 
		{}
		
		public function encounterWhite():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("Walking through the shifting sands of the desert, you start to notice the landscape takes on a strange character; bone-white sand fades into the gold grains you are used to, a blood red horizon paints the sky in choking waves, offsetting the dunes' restless gray. Your feet dug furrows in the sand as you stalk in this fever dream-like vista while a white sandstorm blows overhead.\n\n");
			outputText("That's when you feel it– a presence that makes your blood run cold, as if you've been stabbed with a knife.\n\n");
			outputText("A pale feminine figure wearing a jagged mask burst from the storm like a bullet. Her limbs bent with too much speed, her tail whipping through the air like a lash of steel. She slammed into a dune, sending up a cloud of the ash - colored sand. You ready yourself for conflict as this is the twisted natural marethian greeting, the pale figure emerges from the cloud.\n\n");
			outputText("It looks emaciated and unnaturally thin like someone that hasn't eaten in weeks. The skin of this strange creature looks like a combination of chitin and armor. Stranger still is the mask it wears–the grimace sends alarm bells ringing through your mind. Her horns bare an aggressive zigzag pattern–a reticle zeroing in on you. ");
			outputText("A hairline crack runs across her mask, revealing jagged teeth bared in a rictus grin, twin black pits for eyes, and those white irises–glaring at you.\n\n");
			startCombat(new Hollow());
		}
		
		public function lostToWhite():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("You crumple from her last blow, on your back, sand biting your skin.\n\n");
			outputText("White towers over you, her mask fractured glowing with feral joy. Her claws pin you down, her maw splitting wide enough to engulf your face. The pull begins—your soul wrenched upward, trembling in her grip, a pale ember in a cage.\n\n");
			outputText("The pain is unbearable, molten wire dragging through your veins as she drinks. You feel yourself dimming, strength waning from cutting waves. But then—her body convulses.\n\n");
			outputText("The wound you left earlier in the fight splits wider. Cracks race across her torso like shattered porcelain. She shudders, coughing up smoke, spasms racking her frame.\n\n");
			outputText("She tries to keep drinking, tries to finish you, but her mask fractures further, glowing with fissures. She snarls, desperate. And then she collapses on top of you.\n\n");
			outputText("Her voice breaks apart, into a  whisper but then a static scream: \"<i>Don’t—leave me—</i>\"\n\n");
			outputText("Her form disintegrates into pale dust, dissolving in your grasp then bursts into an ashy cloud. When the storm clears, you are alone. Scarred, weakened, but alive.\n\n");
			player.createStatusEffect(StatusEffects.ChainOfFate,0,24,0,0);
			cleanupAfterCombat();
		}
		
		public function wonWithWhite():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("The final strike cracks her mask. A shockwave ripples across the wasteland, throwing dust and shards into the night air. The pale hollow staggers, her grin broken, the jagged mask splitting across her face.\n\n");
			outputText("She drops to one knee, body heaving through an empty chest. Her tail lashes once, twice then falls limp. A sea of black with white points stare at you, burn into you, unblinking.\n\n");
			outputText("Then she laughs.\n\n");
			outputText("It’s not a sound carried on air—it’s in your head, a jagged noise like glass grinding inside your skull. Her body begins to crumble, soulforce unraveling into pale ash.\n\n");
			outputText("But before she scatters, she lunges. She's going for your throat! You ready yourself for one more bout, midair the emaciated blur bursts into a cloud of pale ash.\n\n");
			outputText("The world goes white.\n\n");
			outputText("You feel something coursing below your skin—hot, jagged, venomous. A scream of \"<i>Mine. Mine. Mine.</i>\" bursts inside your head as the pale cloud disintegrates around you. When the ash settles, you are alone on the dunes.\n\n");
			player.createStatusEffect(StatusEffects.ChainOfFate,0,24,0,0);
			cleanupAfterCombat();
		}
		
		private function a():void {
			outputText("\n\n");
			outputText("\"<i></i>\"\n\n");
		}
	}
}