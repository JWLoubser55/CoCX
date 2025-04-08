/**
 * @author Liadri
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
import classes.Scenes.Areas.LightlessReach.*;
import classes.Scenes.Areas.Lake.SwordInStone;
import classes.Scenes.SceneLib;

use namespace CoC;

public class LightlessReach extends BaseContent
{
	public var displacerbeastScene:DisplacerBeastScene = new DisplacerBeastScene();
	public var swordInStone:SwordInStone = new SwordInStone();

	public const areaLevel:int = 73;
	public function isDiscovered():Boolean {
		return SceneLib.exploration.counters.lightlessReach > 0;
	}
	public function canDiscover():Boolean {
		return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
	}
	public function timesExplored():int {
		return SceneLib.exploration.counters.lightlessReach;
	}

	public function LightlessReach() {
		onGameInit(init);
	}
	public var lightlessReachEncounter:GroupEncounter;
	private function init():void {
		lightlessReachEncounter = Encounters.group("lightless reach", /*{
			name: "discover rift",
			label : "New Area",
			kind  : 'place',
			unique: true,
			when: SceneLib.glacialRift.canDiscover,
			chance: Encounters.ALWAYS,
			call: SceneLib.glacialRift.discover
		},*/{
			name: "tombstone",
			label : "Tombstone",
			kind  : 'event',
			chance: 0.5,
			unique: true,
			when: function():Boolean {
				return !player.hasStatusEffect(StatusEffects.TookUmbralGravesword) && !player.hasStatusEffect(StatusEffects.UmbralGraveswordNever);
			},
			call: swordInStone.findUmbralGravesword
		}, /*{
			// ?? (lvl 65)
			// wendigoScene.encounterWendigo();
			name: "wendigo"
		}, {
			name: "snow lily",
			label : "Snow Lily",
			kind : 'monster',
			night : false,
			call: snowLilyEncounter
		}, {some werebeast for darkness (lvl 57)
			// Werewolf huntress
			name: "werewolf huntress",
			label : "Werewolf Huntress",
			kind : 'monster',
			day : false,
			call: SceneLib.werewolfFemaleScene.introWerewolfHuntress,
			chance: 0.50
		}, */{
			name: "displacerbeast",
			label : "Displacer Beast",
			kind : 'monster',
			call: function ():void {
				player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
				displacerbeastScene.displacerBeastEncounter();
			}
		}, {
			name: "darkness golem",
			label : "Darkness Golem",
			kind : 'monster',
			call: function ():void {
				player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
				golemEncounters()
			}
		}, {
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

	public function exploreLightlessReach():void {
		explorer.prepareArea(lightlessReachEncounter);
		explorer.setTags("lightless reach");
		explorer.prompt = "You explore the lightless reach.";
		explorer.onEncounter = function(e:ExplorationEntry):void {
			SceneLib.exploration.counters.lightlessReach++;
		}
		explorer.leave.hint("Leave the lightless reach");
		explorer.skillBasedReveal(areaLevel, timesExplored());
		explorer.doExplore();
	}

	public function nothingEncounter():void {
		clearOutput();
		outputText("You spend one hour exploring lightless reach but you don't manage to find anything interesting.");
		if (player.canTrain('tou', player.trainStatCap("tou",50))) {
			outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
			player.trainStat("tou", +1, player.trainStatCap("tou",50));
		}
		dynStats("tou", .5);
		endEncounter();
	}

	public function golemEncounters():void {
		clearOutput();
		outputText("As you take a stroll, from nearby crevice emerge huge golem. Looks like you have encountered 'true darkness golem'! You ready your [weapon] for a fight!");
		startCombat(new GolemTrueDarkness());
	}

}
}