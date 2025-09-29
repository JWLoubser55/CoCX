/**
 * @author Ormael
 * Area with lvl 35-60 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Dungeons.RiverDungeon.EarthElemental;
import classes.Scenes.Monsters.CaveGolems;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.Monsters.WerespiderScene;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Caves extends BaseContent
	{
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		public var cavewyrmScene:CaveWyrmScene = new CaveWyrmScene();
		public var matangoScene:MatangoScene = new MatangoScene();
		public var automatonScene:AutomatonScene = new AutomatonScene();
		public var werespiderScene:WerespiderScene = new WerespiderScene();
		public var darkslimeScene:DarkSlimeScene = new DarkSlimeScene();

		public function Caves() {
			onGameInit(init);
		}

		//Caves: lvl 48-66
		//Tunnels: lvl 71-95
		//Bedrock: lvl 100-135
		private var _cavesEncounter:GroupEncounter = null;
		private var _tunnelsEncounter:GroupEncounter = null;
		public function get cavesEncounter():GroupEncounter {
			return _cavesEncounter;
		}
		public function get tunnelsEncounter():GroupEncounter {
			return _tunnelsEncounter;
		}

		private function init():void {
			const fn:FnHelpers    = Encounters.fn;
			_cavesEncounter = Encounters.group("caves", {
				name: "discoverashlands",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.ashlands.canDiscover,
				chance: 30,
				call: discoverAshlands
			}, {
				name: "discovertundra",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.tundra.canDiscover,
				chance: 30,
				call: discoverTundra
			}, {
				name: "discovertunnels",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: canDiscoverTunnels,
				chance: 30,
				call: discoverTunnels
			}, {
				name: "gunparts",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) == 0 && player.hasKeyItem("Touhouna M3") < 0
				},
				call: partsofTouhounaM3
			}, {
				name: "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.ETNA_AFFECTION] >= 5
				},
				chance: cavesChance,
				call: manticoreEncounterFn
			}, {
				name: "mine",
				label : "Mine",
				kind  : 'place',
				when: function ():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained
				},
				call: cavesMine
			}, {
				name: "cavewyrn",
				label : "Cave Wyrm",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					cavewyrmScene.berserkingCaveWyrmEncounter();
				}
			}, {
				name: "matango",
				label : "Matango",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					if (player.hasPerk(PerkLib.FungalNobility) && player.perkv1(PerkLib.FungalNobility) < player.matangoControlLimit()) matangoScene.gainingMatango();
					else matangoScene.mantangoEncounter();
				}
			}, {
				name: "darkelf",
				label : "Dark Elf",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkelfScene.introDarkELfScout();
				}
			}, {
				name: "gemgolem",
				label : "Gem Golem",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					gemGolemEncount()
				}
			}, {
				name: "",
				label : 'Walk',
				kind : 'walk',
				when: function ():Boolean {
					return true
				},
				call: findNothing
			}, {
				name: "findebon",
				label : "Ebonbloom",
				kind  : 'item',
				call: findEbonBloom
			}, {
				name: "findcrystal",
				label : "M. Crystal",
				kind  : 'item',
				call: findCrystal
			}, {
				name: "findeyedrops",
				label : "Eyedrops",
				kind  : 'item',
				call: findEyeDrops
			}, {
				name: "findnothing",
				label : "Walk",
				kind  : 'walk',
				call: findNothing
			}, {
				name: "demonProjects",
				label : "DemLab Subject",
				kind  : 'monster',
				chance: 0.2,
				when: function ():Boolean {
					return SceneLib.exploration.demonLabProjectEncountersEnabled();
				},
				call: curry(SceneLib.exploration.demonLabProjectEncounters, 1)
			});
			_tunnelsEncounter = Encounters.group("tunnels", {
				name: "discovercliffs",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.cliffs.canDiscover,
				chance: 30,
				call: discoverCliffs
			}, {
				name: "discoverlightlessreach",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.lightlessReach.canDiscover,
				chance: 30,
				call: discoverLightlessReach
			}, {
				name: "mine",
				label : "Mine",
				kind  : 'place',
				when: function ():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained
				},
				call: cavesMine
			}, {
				name: "discoverebonlab",
				label : "Ebon Labyrinth",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.EBON_LABYRINTH] < 1
				},
				chance: 30,
				call: SceneLib.dungeons.ebonlabyrinth.ebonlabyrinthdiscovery
			}, {
				name: "automaton",
				label : "Automaton",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					automatonScene.automatonEncounter();
				}
			}, {
				name: "werespider",
				label : "Werespider",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					werespiderScene.werespiderEncounter();
				}
			}, /*{
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					//antworker.();
					clearOutput();
					//outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling like you are becoming slightly tougher counts.");
					break;
			}, */{
				name: "darkelf",
				label : "Dark Elf",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkelfScene.introDarkELfSlaver();
				}
			}, /*{
				name: "darkslime",
				label : "Dark Slime",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkslimeScene.cavesDarkSlimeEncounter();
				}
			},*/{
				name: "adamantinegolem",
				label : "Adamantine Golem",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					adamantineGolemEncount()
				}
			}, {
				name: "earth ele",
				label : "Earth Elemental",
				kind  : 'monster',
				when: fn.ifLevelMin(88),
				call: bedrockEarthElemental
			}, {
				name: "",
				label : 'Walk',
				kind : 'walk',
				when: function ():Boolean {
					return true
				},
				call: findNothing
			}, {
				name: "findnothing",
				label : "Walk",
				kind  : 'walk',
				call: findNothing
			});
		}

		public const areaLevel:int = 45;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.caves > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.beach.isDiscovered();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.caves;
		}
		public function discover():void {
			SceneLib.exploration.counters.caves = 1;
			clearOutput();
			outputText("As you explore the area you run into a somewhat big hole in the landscape. You look inside unsure as it seems to lead into the depths of Mareth. Resolving yourself to chase the demons wherever they go you decide to still enter the hole discovering a full world of linked tunnels beneath Mareth ground.\n\n");
			outputText("<b>You've discovered the Caves!</b>");
			endEncounter(120);
		}
		
		public const areaLevelTunnels:int = 68;
		public function isDiscoveredTunnels():Boolean {
			return SceneLib.exploration.counters.tunnels > 0;
		}
		public function canDiscoverTunnels():Boolean {
			return !isDiscoveredTunnels() && adjustedPlayerLevel() >= areaLevelTunnels;
		}
		public function timesExploredTunnels():int {
			return SceneLib.exploration.counters.tunnels;
		}
		public function discoverTunnels():void {
			SceneLib.exploration.counters.tunnels = 1;
			clearOutput();
			outputText("As you explore the caves you step into a path that does not seem to be naturaly made. Examining it properly reveals this area has been dug through by some collosal beast. Whatever monsters awaits you down there in the darkness of these tunnels is bound to be far more dangerous.\n\n");
			outputText("<b>You have found the tunnels!</b>");
			endEncounter(120);
		}
		
		public const areaLevelBedrock:int = 51;
		public function isDiscoveredBedrock():Boolean {
			return SceneLib.exploration.counters.bedrock > 0;
		}
		public function canDiscoverBedrock():Boolean {
			return !isDiscoveredBedrock() && adjustedPlayerLevel() >= areaLevelBedrock;
		}
		public function timesExploredBedrock():int {
			return SceneLib.exploration.counters.bedrock;
		}
		public function discoverBedrock():void {
			SceneLib.exploration.counters.bedrock = 1;
			clearOutput();
			outputText("\n\n");
			outputText("<b>You've discovered the Bedrock!</b>");
			endEncounter(120);
		}

		public function exploreCaves():void {
			explorer.prepareArea(cavesEncounter);
			explorer.setTags("caves");
			explorer.prompt = "You explore the gloomy caves.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.caves++;
			}
			explorer.leave.hint("Leave the gloomy caves");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
		public function exploreTunnels():void {
			explorer.prepareArea(tunnelsEncounter);
			explorer.setTags("caves", "tunnels");
			explorer.prompt = "You explore the gloomy tunnels.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.tunnels++;
			}
			explorer.leave.hint("Leave the gloomy tunnels");
			explorer.skillBasedReveal(areaLevel, timesExploredTunnels());
			explorer.doExplore();
		}

		public function cavesChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function discoverTundra():void {
			clearOutput();
			outputText("While exploring one of the many tunnels you begin to see a bluish light, curious as to where this opens you take it all the way to the surface and begin to feel chilly, it's definitely cold out there. What awaits you beyond the exit is the sight of endless tundra and icebound mountains.\n\n");
			outputText("<b>You've discovered the Tundra!</b>");
			SceneLib.exploration.counters.tundra = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function discoverAshlands():void {
			clearOutput();
			outputText("While exploring one of the many tunnels you begin to see a red light, curious as to where this opens you take it all the way to the surface as the heat starts to increase dramatically the cool fresh air of the tunnel replaced by a warm and smoky air, it's definitely very hot out there. ");
			outputText("What awaits you beyond the exit is the sight of a field of ashes and lava with volcanoes in the backside.\n\n");
			outputText("<b>You've discovered the Ashlands!</b>");
			SceneLib.exploration.counters.ashlands = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function discoverLightlessReach():void {
			clearOutput();
			outputText("While exploring the tunnels you find the entrance to a hole that seems to delves deeper into the dark. The depths of the hole are beyond any and all light and the oppressive darkness within is near suffocating. This is no place for the sane no or those who walk into the light.\n\n");
			outputText("<b>You've discovered the Lightless Reach!</b>");
			SceneLib.exploration.counters.lightlessReach = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function discoverCliffs():void {
			clearOutput();
			outputText("While exploring one of the many narrow tunnels, you spot a bright light from afar. Curious as to where this opens, you walk ahead as gusts of wind barrel at you from the pathway ahead. What awaits beyond the exit is a large, rocky shelf located somewhere in the middle of the cliff. ");
			outputText("Beyond, yet between floating islands, you see in the distance a set several of massive columns connected to seemingly an endless abyss below as clouds circle above.\n\n");
			outputText("<b>You've discovered the Cliffs!</b>");
			SceneLib.exploration.counters.cliffs = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function findEbonBloom():void {
			clearOutput();
			outputText("You're exploring the vast cave system when you come across a small cavern. As you head further into the cavern you spot something glinting just up ahead. A small crack in the ceiling lets a sliver of light shine down on a dark metallic looking flower growing on top of a stone pillar. ");
			outputText("Your eyes widen in surprise when you recognize it to be a rare Ebonbloom. Seeing that nothing else is around, you make your way over to the flower then try to pluck it. It doesn't budge at first but with a little more effort you manage to pull the flower free. ");
			if (silly()) outputText("You suddenly hear dramatic music play as the cavern around you begins to cave in. You don your brown explorer's hat and whip as you make your way out of the collapsing cavern, dodging falling rocks in the process. By the skin of your teeth you escape from the cavern with your treasure in hand. ");
			inventory.takeItem(useables.EBONBLO, explorer.done);
		}

		private function findCrystal():void {
			clearOutput();
			outputText("As you explore the cave, you run into a weird neon blue crystal that glow in the dark. You pack it in your backpack in case it could be sold for a decent amount" + (silly() ? ", perhaps to a drug dealer" : "") + ". ");
			inventory.takeItem(consumables.METHIRC, explorer.done);
		}

		private function findEyeDrops():void {
			clearOutput();
			outputText("As you explore the cave, you run into a bottle of eye drops. You pack it in your backpack in case it could be sold for a decent amount. ");
			inventory.takeItem(consumables.EYEDROP, explorer.done);
		}

		private function findNothing():void {
			clearOutput();
			outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling like you are becoming slightly tougher counts.");
			dynStats("tou", .5);
			endEncounter();
		}

		private function manticoreEncounterFn():void {
			player.createStatusEffect(StatusEffects.InsideSmallSpace, 0, 0, 0, 0);
			if (rand(2) == 0) {
				player.createStatusEffect(StatusEffects.WildManticore, 0, 0, 0, 0);
				SceneLib.etnaScene.repeatEnc();
			} else {
				SceneLib.bashemathScene.repeatEncWM();
			}
		}
	
		private function bedrockEarthElemental():void {
			clearOutput();
			outputText("While wandering bedrock you spot a nice large rock to climb on and get a good vantage of the area from. You begin climbing onto the rocky formation when the ground around begins to shake. You drop from the rock as soon as it begins to rise from the ground, a massive woman made out of solid stone stretching out of the ground to stare at you. ");
			outputText("This fully manifested Gnome was just minding her own business sleeping when you accidentally woke her up and now that her nap and sweet happy dreams are ruined she is going to take her anger on you. Mother nature is having a rough day and she isn’t taking your excuse nicely anymore. Nah today she’s determined to answer by crushing you until you turn into fertilizers!\n\n");
			outputText("You ready for combat as the gnome lifts her rocky hands up and begins throwing a tantrum.");
			flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 6;
			startCombat(new EarthElemental());
		}

		public function partsofTouhounaM3():void {
			clearOutput();
			outputText("As you explore the caves you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Touhouna M3 in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Touhouna M3", 0, 0, 0, 0);
			endEncounter();
		}

		private function cavesMine():void {
			clearOutput();
			outputText("You stumble across a vein of Ebony, this looks like suitable material for your gargoyle form.\n");
			outputText("Do you wish to mine it?");
			menu();
			addButton(0, "Yes", cavesSiteMine);
			addButton(1, "No", explorer.done);
		}

		private function cavesSiteMine():void {
			if (Forgefather.materialsExplained != 1) endEncounter();
			else {
				if (player.fatigue > player.maxOverFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					endEncounter();
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the ebony, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementEbonySupply(minedStones);
				player.mineXP(player.MiningMulti());
				findGem();
			}
		}

		private function findGem():void {
			if (player.miningLevel > 4) {
				if (rand(4) == 0) {
					inventory.takeItem(useables.AMEGEM, curry(explorer.done,120));
					player.mineXP(player.MiningMulti() * 2);
				}
				else {
					outputText("After attempting to mine Amethysts, you ended up with only unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any Amethysts.");
				endEncounter(120);
			}
		}

		private function gemGolemEncount():void {
			clearOutput();
			outputText("As you take a stroll, a golem emerges from the nearby shadow. Looks like you've encountered a gem golem! You ready your [weapon] for a fight!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOLEMS);
			flags[kFLAGS.GOLEM_ENEMY_TYPE] = 20;
			startCombat(new CaveGolems());
		}
		private function adamantineGolemEncount():void {
			clearOutput();
			outputText("As you take a stroll, a golem emerges from the nearby shadow. Looks like you've encountered an adamantine golem! You ready your [weapon] for a fight!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOLEMS);
			flags[kFLAGS.GOLEM_ENEMY_TYPE] = 21;
			startCombat(new CaveGolems());
		}
	}
}
