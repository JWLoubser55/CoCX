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
			flags[kFLAGS.HOLLOW_TYPE] = 0;
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
			player.createStatusEffect(StatusEffects.ChainOfFate,0,24,0,1);
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
			player.createStatusEffect(StatusEffects.ChainOfFate,0,24,0,1);
			cleanupAfterCombat();
		}
		
		public function encounterHollow1():void {
			encounterHollow(1);
		}
		public function encounterHollow2():void {
			encounterHollow(2);
		}
		private function encounterHollow(area:Number):void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("The dunes are restless tonight. Soulforce crawls across your skin in prickling waves, warning you before the sound reaches your ears.\n\n");
			outputText("A low rasp, wet and ragged, echoes from behind a jagged rock. Then it emerges—thin as famine, with limbs too long and a mask that looks half-melted, like clay left in a fire. Its teeth jut out in crooked rows, gnashing without rhythm, a hollow mimicry of hunger.\n\n");
			outputText("A yawning hole opens and closes in its chest, half-decayed. Something like a strangled scream and a wail echoes from it as though reliving its final moments. Empty sockets lock onto you, and for a moment, you think the thing is cognizant.\n\n");
			outputText("The Hollow screeches and lunges, claws outstretched, its jagged mask splitting with the force of its cry.\n\n");
			if (area == 1) flags[kFLAGS.HOLLOW_TYPE] = 1;
			else flags[kFLAGS.HOLLOW_TYPE] = 2;
			startCombat(new Hollow());
		}
		
		public function lostToHollow():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			if (player.hasStatusEffect(StatusEffects.ChainOfFate) || player.hasStatusEffect(StatusEffects.DarkSign) || !player.blockingBodyTransformations()) {
				outputText("It’s faster than you thought.\n\n");
				outputText("The Hollow’s claws rake across your [chest], sparks of pain exploding as your soulforce falters. You fall back onto the ground, your vision swimming with black and white static.\n\n");
				outputText("It looms over you, the abyssal hole in its chest yawning. Its mask splits, the jaw unhinging far too wide. The pull begins.\n\n");
				outputText("Your soul jerks upward, thrumming in the grip of its hunger. Vitality drains from [skin] as light leaks out of you thread by thread. The sensation of molten earth poured across your [chest] blooms in your head. Your skin starts as though you’re being unraveled from the inside.\n\n");
				outputText("But then—it stops.\n\n");
				outputText("The Hollow shudders, convulses, and rips itself away from you. Your soul slips back into your body, weak and tattered, but intact. The Hollow screeches, its hunger unsated, before fleeing like a feral beast.\n\n");
				outputText("You are alive. But the scar it left behind aches like fire, a reminder of how close you came to being nothing more than another ember to feed the endless hunger of these creatures.\n\n");
				player.negativeLevel += 9;
				cleanupAfterCombat();
			}
			else {
				outputText("The creature stabs its talons into your chest with brutal, tearing force. Hooks curl into warm, yielding flesh. Searing waves of agony batter your psyche. Its cold and unfeeling eyes gaze into your [eyes], as though trying to drain your very life with its stare alone.\n\n");
				outputText("You try to struggle, but its grip tightens—claws sinking deeper like stones dropped in a swamp.Its mask, an abomination of jagged teeth, gleams with menace, eager to tear into [skin].\n\n");
				outputText("It lunges.\n\n");
				outputText("Teeth tear through your shoulder with a sickening crunch. A searing pulse of agony flashing white overwhelms your vision. The world narrows to the sound of gnawing and your own heartbeat slowing, stuttering, and then stopping.As your body crumples, the creature straightens. A pale mist—your essence—spills from your lips. It inhales greedily, the mask crackling with a satisfied laugh.\n\n");
				outputText("The walking mouth moves on, and you are left as little more than a strip of flesh upon the ground.\n\n");
				EventParser.gameOver();
			}
		}
		
		private function a():void {
			outputText("\n\n");
			outputText("\"<i></i>\"\n\n");
		}
	}
}