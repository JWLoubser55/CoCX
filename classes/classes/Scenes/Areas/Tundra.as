/**
 * @author Ormael
 * Area with lvl 40-55 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Lake.SwordInStone;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.Tundra.*;
import classes.Scenes.Dungeons.RiverDungeon.IceElemental;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Tundra extends BaseContent
	{
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		public var swordInStone:SwordInStone = new SwordInStone();

		public const areaLevel:int = 50;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.tundra > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.tundra;
		}

		public function Tundra()
		{
			onGameInit(init);
		}
		public var tundraEncounter:GroupEncounter;
		private function init():void {
			tundraEncounter = Encounters.group("tundra", {
				name: "discover rift",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.glacialRift.canDiscover,
				chance: Encounters.ALWAYS,
				call: SceneLib.glacialRift.discover
			},{
				name: "tombstone",
				label : "Tombstone",
				kind  : 'event',
				chance: 0.5,
				unique: true,
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookGlacialGraveaxe) && !player.hasStatusEffect(StatusEffects.GlacialGraveaxeNever);
				},
				call: swordInStone.findGlacialGraveaxe
			}, /*{
				// ?? (lvl 65)
				// wendigoScene.encounterWendigo();
				name: "wendigo"
			}, */{
				name: "frostgiant",
				label : "Young Frost Giant",
				kind : 'monster',
				night : false,
				call: frostGiantEncounter
			}, {
				name: "snow lily",
				label : "Snow Lily",
				kind : 'monster',
				night : false,
				call: snowLilyEncounter
			}, {
				name: "fafnir tear",
				label : "Fafnir Tear",
				kind  : 'item',
				call: findATear,
				chance: 0.25
			}, /*{some werebeast for cold climate (lvl 57)
				// Werewolf huntress
				name: "werewolf huntress",
				label : "Werewolf Huntress",
				kind : 'monster',
				day : false,
				call: SceneLib.werewolfFemaleScene.introWerewolfHuntress,
				chance: 0.50
			}, */{
				name: "ice golem",
				label : "Ice Golem",
				kind : 'monster',
				call: golemEncounters
			}, {
				name: "ice ele",
				label : "Ice Elemental",
				kind  : 'monster',
				call: tundraIceElemental
			}, {
				// choice[choice.length] = 5; Find Alabaster
				name: "alabaster",
				label : "Mine",
				kind  : 'place',
				when: function():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained;
				},
				call: alabasterEncounter
			}, {
				name: "xmascoalcollection",
				label : "coal coll",
				kind  : 'event',
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.WinterFlash) || (player.hasItem(consumables.COAL___, 10) && player.hasStatusEffect(StatusEffects.WinterFlash) && player.statusEffectv1(StatusEffects.WinterFlash) < 1);
				},
				call: chrismasEventCoalCollection
			}, {
				//Find nothing!
				// choice[choice.length] = 6;
				chance: 0.25,
				name: "nothing",
				call: nothingEncounter,
				label:'Walk',
				kind:'walk'
			}, {
				name: "demonProjects",
				label : "DemLab Subject",
				kind  : 'monster',
				chance: 0.2,
				when: function ():Boolean {
					return SceneLib.exploration.demonLabProjectEncountersEnabled();
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			});
		}

		public function exploreTundra():void {
			explorer.prepareArea(tundraEncounter);
			explorer.setTags("tundra");
			explorer.prompt = "You explore the tundra.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.tundra++;
			}
			explorer.leave.hint("Leave the tundra");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		public function nothingEncounter():void {
			clearOutput();
			outputText("You spend one hour exploring tundra but you don't manage to find anything interesting.");
			if (player.canTrain('tou', player.trainStatCap("tou",50))) {
				outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
				player.trainStat("tou", +1, player.trainStatCap("tou",50));
			}
			dynStats("tou", .5);
			endEncounter();
		}
	
		private function tundraIceElemental():void {
			clearOutput();
			outputText("We awaits for... ");
			outputText("Lia writing nice intro here.\n\n");//lvl 70
			flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] = 5;
			startCombat(new IceElemental());
		}

		public function alabasterEncounter():void {
			clearOutput();
			outputText("You stumble across a vein of Alabaster, this looks like suitable material for your gargoyle form.\n");
			outputText("Do you wish to mine it?");
			menu();
			addButton(0, "Yes", tundraSiteMine);
			addButton(1, "No", explorer.done);
		}

		public function golemEncounters():void {
			clearOutput();
			outputText("As you take a stroll, from nearby trees emerge huge golem. Looks like you have encountered 'true ice golem'! You ready your [weapon] for a fight!");
			startCombat(new GolemTrueIce());
		}

		public function snowLilyEncounter():void {
			clearOutput();
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
				menu();
				addButton(0, "Yes", explorer.done);
				addButton(1, "No", alrauneScene.alrauneGlacialRift);
			} else {
				alrauneScene.alrauneGlacialRift();
			}
		}

		public function frostGiantEncounter():void {
			clearOutput();
			outputText("You wander the chilling landscape of the Tundra. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Young Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
			startCombat(new YoungFrostGiant());
		}


		private function tundraSiteMine():void {
			if (Forgefather.materialsExplained != 1) endEncounter();
			else {
				clearOutput();
				if (player.fatigue > player.maxOverFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					endEncounter();
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the alabaster, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementAlabasterSupply(minedStones);
				player.mineXP(player.MiningMulti());
				findGem();
			}
		}

		private function findATear():void {
			outputText("While exploring the tundra you spot a peculiar white flower. It glows feintly as if from some magical residue.");
			inventory.takeItem(consumables.F_TEAR, explorer.done);
		}

		private function findGem():void {
			if (player.miningLevel > 4) {
				if (rand(4) == 0) {
					inventory.takeItem(useables.SAPPGEM, curry(explorer.done,120));
					player.mineXP(player.MiningMulti() * 2);
				}
				else {
					outputText("After attempting to mine Sapphires, you ended with only unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any Sapphires.");
				endEncounter(120);
			}
		}

		public function chrismasEventCoalCollection():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.WinterFlash)) {
				outputText("\"<i></i>\"\n\n");
				outputText("\"<i></i>\"\n\n");
				menu();//model.time.hours >= 18
				addButton(0, "Yes", chrismasEventCoalCollectionYes);
				addButton(1, "Sorry no", explorer.done);
			}
			else {
				outputText("While wandering the rift, you encounter a strange sight. What you mistake at first for an ordinary centaur turns out to be something else altogether! The taur maiden’s head is crowned by her large antlers, and her back is draped in shaggy fur. Her short, puffy tail is more reminiscent of a reindeer than a horse’s. As you approach her, she turns around and trots toward you.\n\n");
				outputText("\"<i>Adventurer! I and my master are in dire need of your help, please do the right thing and help me save the snowy eve. Only YOU can prevent the disaster that is about to strike this land!</i>\"\n\n");
				outputText("You tell her to slow down and tell you what she needs you to do. Yes, you are a champion, "+(player.cor >= 50 ? "well you used to be one at least,":"")+" and you won’t stand by idly when someone ask for your assistance"+(player.cor >= 50 ? " doubly so if a nice reward is promised at the end":"")+".\n\n");
				outputText("\"<i>Coal, that is the problem. We have run out of coal! So many people have been naughty this year, and the father has run out of coal to send to them! I need you to collect at least 10 coal and bring them back to me so that everyone can receive a fitting gift! It must have been those pests in the swamp, or maybe the salamander stole the reserve for their smith work. ");
				outputText("Please help us save the celebration before it is too late!.</i>\"\n\nThe cervid woman is clearly distressed, you promise her to be on the lookout for coal before heading out back into the blizzard.\n\n");
				player.createStatusEffect(StatusEffects.WinterFlash, 0, 0, 0, 0);
				endEncounter();
			}
		}
		
		private function chrismasEventCoalCollectionYes():void {
			player.destroyItems(consumables.COAL___, 10);
			player.addStatusValue(StatusEffects.WinterFlash, 1, 1);
			if (player.isRaceCached(Races.DEER, 3)) {
				outputText("You deliver the coal to the cervid woman who nods in appreciation.\n\n");
				outputText("\"<i>Yes! This will be perfect! I thank you for your assistance… umm come to think of it, could you also assist me with something else?</i>\"\n\n");
				outputText("Before you can even consider, she has already roped you into her idea.\n\n");
				outputText("\"<i>One of my partners got sick and won’t be able to take to the sky this year. I was going to look for a replacement, but you came by just in time. Hope you wouldn’t mind, but could you help me pull the good father’s cart across the country while he delivers gifts across every house? By the by, the job is tonight.</i>\"\n\n");
				outputText("Looking at yourself, you do more or less have the body to pull a cart, and since she offered a reward for it, you may as well help her to the very end. She hands to you what appears to be an amulet of which the ornament is a set of jingling bells.\n\n");
				outputText("\"<i>This will let you take to the sky with us, it also should greatly improve your movement based abilities now we have a bit of time before the job so how about we had a few drinks, you and I, don’t you worry about paying, it will all be on my tab.</i>\"\n\n");
				outputText("The remainder of the evening is a blur. You remember drinking a lot of eggnog, then putting on a harness and helping pull out a heavy sleigh across the sky with the help of eight more cervid girls at the front guiding everyone. When you wake up in the morning, still feeling groggy from the alcohol, you notice something strange. Your nose is quite itchy. ");
				outputText("Looking at yourself in a pond of water, you discover it has turned red as a tomato and can even produce light to smite the naughty!\n\n<b>Acquired ability Winter Flash!</b>\n\n");
				player.addStatusValue(StatusEffects.WinterFlash, 1, 1);
				inventory.takeItem(necklaces.WBCOLLAR, explorer.done);
				doNext(camp.returnToCampUseTwelveHours);
			}
			else {
				outputText("You deliver the coal to the cervid woman who nods in appreciation.\n\n");
				outputText("\"<i>Yes, this will be perfect! I thank you for your assistance… umm come to think of it, you could probably use these.</i>\"\n\n");
				outputText("She tosses at you what appears to be an amulet of which the ornament is a set of jingling bells.\n\n");
				outputText("\"<i>One of my partners got sick and won’t be able to take to the sky this year. That's fine, though, if you have a centaur friend or someone who got the hindquarters of one, these will let you take to the sky! It also greatly improves movement based abilities. Oh right I was about to forget, before I leave, a merry winter’s eve to you!</i>\"\n\n");
				outputText("To your surprise, she suddenly takes off running upward into the sky to gods know where. A second before, she was right in front of you, and now she’s gone. You can hear the faint sound of jingling bells in the distance as she vanishes into the blizzard along with the loud, cheerful laughter of an old man.\n\n");
				inventory.takeItem(necklaces.WBCOLLAR, explorer.done);
			}
		}
	}
}
