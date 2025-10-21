/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.DeepSea.AbyssalSharkScene;
import classes.Scenes.Areas.Ocean.*;
import classes.Scenes.Dungeons.RiverDungeon.WaterElemental;
import classes.Scenes.NPCs.CeaniScene;
import classes.Scenes.Places.Boat.SharkGirlScene;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class Ocean extends BaseContent
	{
		public var ceaniScene:CeaniScene = new CeaniScene();
		public var sharkGirlScene:SharkGirlScene = new SharkGirlScene();
		public var scyllaScene:ScyllaScene = new ScyllaScene();
		public var abyssalsharkScene:AbyssalSharkScene = new AbyssalSharkScene();
		
		public const areaLevel:int = 63;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.ocean > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.ocean;
		}
		
		public const areaLevelInnerOcean:int = 89;
		public function isDiscoveredInnerOcean():Boolean {
			return SceneLib.exploration.counters.oceanInner > 0;
		}
		public function canDiscoverInnerOcean():Boolean {
			return !isDiscoveredInnerOcean() && adjustedPlayerLevel() >= areaLevelInnerOcean;
		}
		public function timesExploredInnerOcean():int {
			return SceneLib.exploration.counters.oceanInner;
		}
		
		public function discover():void {
			SceneLib.exploration.counters.ocean = 1;
			clearOutput();
			outputText("You journey around the beach, seeking demons to fight");
			if(player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the sand is cool under your feet.   Soft waves lap against the muddy sand of the sea-shore.   You pass around a few dunes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the sea boat!</b>");
			endEncounter(120);
		}
		
		public function discoverInnerOcean():void {
			clearOutput();
			outputText("As you sail over the coastal waters, you reach an unfamiliar region. Marked by much cooler, darker waters beneath you. As you look around, you could almost swear you could saw faint rays of light deep off in the distance... Is it a lighthouse?\n\n<b>You've discovered the Ocean!</b>");
			SceneLib.exploration.counters.oceanInner = 1;
			endEncounter(120);
		}
		
		public function Ocean() {
			onGameInit(init);
		}

		private var _oceanEncounter:GroupEncounter = null;
		public function get oceanEncounter():GroupEncounter {
			return _oceanEncounter;
		}

		private var _oceanInnerEncounter:GroupEncounter = null;
		public function get oceanInnerEncounter():GroupEncounter {
			return _oceanInnerEncounter;
		}

		private function init():void {
			_oceanEncounter = Encounters.group("coastal waters", {
				name: "fishing",
				label : "Fishing",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return player.hasKeyItem("Fishing Pole") >= 0
				},
				call: fishing
			}, {
				name: "ocean",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: canDiscoverInnerOcean,
				call: discoverInnerOcean,
				chance: Encounters.ALWAYS
			}, {
				name: "nothing",
				chance:  0.25,
				call: findNothing,
				label:'Walk',
				kind:'walk'
			}, {
				name: "ceani",
				label : "Ceani",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return (model.time.hours >= 12 && model.time.hours <= 22) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] >= 4
				},
				chance: oceanChance,
				call: ceaniScene.oceanInteractionsAfterArcheryTraining
			}, {
				name: "seaanemone",
				label : "Sea Anemone",
				kind : 'monster',
				call: function ():void {
					flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 2;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					SceneLib.boat.anemoneScene.mortalAnemoneeeeee();
				}
			}, {
				name: "sharkgirl",
				label : "Shark girl",
				kind : 'monster',
				call: function ():void {
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					sharkGirlScene.oceanSharkGirlEncounter();
				}
			}, {
				name: "tigersharkgirl",
				label : "Tigershark girl",
				kind : 'monster',
				call: function ():void {
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 2;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					sharkGirlScene.oceanTigersharkGirlEncounter();
				}
			}, {
				name  : "arigean",
				label : "Arigean",
				kind : 'monster',
				when: function ():Boolean {
					return flags[kFLAGS.THE_TRENCH_ENTERED] == 0
				},
				call  : SceneLib.graydaScene.graydaEncounter
			}, {
				name  : "weresharkMale",
				label : "Wereshark (M)",
				kind : 'monster',
				day : false,
				call  : SceneLib.weresharkScene.weresharkEncounter,
				chance: 0.50
			}, {
				name: "water ele",
				label : "Water Elemental",
				kind  : 'monster',
				call: costalWatersWaterElemental
			})
			_oceanInnerEncounter = Encounters.group("inner ocean", {
				name: "fishing",
				label : "Fishing",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return player.hasKeyItem("Fishing Pole") >= 0
				},
				call: fishing
			}, {
				name: "sharkgirlpack",
				label : "Shark girls pack",
				kind : 'monster',
				call: function ():void {
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					sharkGirlScene.oceanSharkGirlsPackEncounter();
				}
			}, {
				name: "scylla",
				label : "Scylla",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					scyllaScene.oceanScyllaEncounter();
				}
			}, {
				name: "juvenileabyssalshark",
				label : "Juvenile A. Shark",
				kind : 'monster',
				chance:  0.75,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					player.createStatusEffect(StatusEffects.InWater,0,0,0,0);
					abyssalsharkScene.oceanJuvenileAbyssalSharkEncounter();
				}
			}, {
				name: "water ele",
				label : "Water Elemental",
				kind  : 'monster',
				call: innerOceanWaterElemental
			})
		}

		public function exploreOcean():void {
			explorer.prepareArea(oceanEncounter);
			explorer.setTags("coastal waters","water");
			explorer.prompt = "You explore the coastal waters surface.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.ocean++;
			}
			explorer.leave.hint("Leave the coastal waters");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
		public function exploreInnerOcean():void {
			explorer.prepareArea(oceanInnerEncounter);
			explorer.setTags("ocean","water");
			explorer.prompt = "You explore the ocean surface.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.oceaninner++;
			}
			explorer.leave.hint("Leave the ocean");
			explorer.skillBasedReveal(areaLevelInnerOcean, timesExploredInnerOcean());
			explorer.doExplore();
		}

		public function oceanChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
	
		private function costalWatersWaterElemental():void {
			clearOutput();
			outputText("While wandering costal waters you feel the need to take a leak. Thankfully the area is full of pristine water to cleanly deliver into. A few seconds later the dirty deed is done and you prepare to move out when you hear a low grumbling like the sound of an incoming tidal wave. Slowly turning around you spot what appears to be a very pissed up woman taping her pristine semi transparent foot against the water surface. ");
			outputText("This fully manifested undine was guarding this body of water… water you accidentally went and polluted with your defects. While water elementals are generally benevolent the one thing they despise the most is the despoilment of their source and you just went and soiled hers. The waters quickly begin to churn violently as the vengeful elemental prepares to deliver divine punishment. It’s a fight!\n\n");
			flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 5;
			startCombat(new WaterElemental());
		}
		private function innerOceanWaterElemental():void {
			clearOutput();
			outputText("While wandering ocean you feel the need to take a leak. Thankfully the area is full of pristine water to cleanly deliver into. A few seconds later the dirty deed is done and you prepare to move out when you hear a low grumbling like the sound of an incoming tidal wave. Slowly turning around you spot what appears to be a very pissed up woman taping her pristine semi transparent foot against the water surface. ");
			outputText("This fully manifested undine was guarding this body of water… water you accidentally went and polluted with your defects. While water elementals are generally benevolent the one thing they despise the most is the despoilment of their source and you just went and soiled hers. The waters quickly begin to churn violently as the vengeful elemental prepares to deliver divine punishment. It’s a fight!\n\n");
			flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 6;
			startCombat(new WaterElemental());
		}

		private function findNothing():void {
			clearOutput();
			outputText("You row for over an hour, until your arms practically burn with exhaustion from all the rowing.\n\n");
			if (rand(2) == 0) {
				//50/50 strength/speed
				if (rand(2) == 0 && player.str < 150) {
					outputText("Despite the exaustion, you feel like you have become stronger.");
					dynStats("str", .5);
				}
				//Toughness
				else if (player.spe < 150) {
					outputText("Despite the exaustion, you feel like you have become faster.");
					dynStats("spe", .5);
				}
			}
			endEncounter();
		}

		private function fishing():void {
			clearOutput();
			outputText("This is a calm day on the ocean, you managed to hold your boat just a mile or two away from the brewing storm that constantly rage over the area and, while you found nothing of note, couldn’t help yourself but to enjoy a few hour using your newly acquired fishing pole.\n\n");
			outputText("<b>You got a fish!</b>");
			inventory.takeItem(consumables.FREFISH, explorer.done);
		}
	}

}
