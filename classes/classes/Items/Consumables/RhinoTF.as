/**
 * Ormael - 30.05.2026
 */
package classes.Items.Consumables
{
import classes.BaseContent;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Races;
import classes.Races.DragonRace;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;

public class RhinoTF extends BaseContent
{

	public function RhinoTF()  {
		super();
	}

public function rhinoTFeffects(grilled:Boolean = false):void {
	var changes:int = 0;
	var changeLimit:int = 3 + player.additionalTransformationChances;
	if (grilled && player.racialScore(Races.RHINO, false) < 8) changeLimit = 0;
	// Stats Changes
	//------------
	if (rand(3) == 0 && player.str < 100) {
		if (player.str < 50) {
			outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
			dynStats("str", .5);
		}
		else {
			outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
		}
		dynStats("str", .5);
	}
	if (rand(3) == 0 && player.tou < 100) {
		outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
		dynStats("tou", 1);
	}
	if (rand(2) == 0 && player.spe > 80 && player.str >= 50) {
		outputText("\n\nYou begin to feel that the size of your muscles is starting to slow you down.");
		player.addCurse("spe", 1, 1);
	}
	if (rand(3) == 0 && player.tou < 50 && changes < changeLimit) {
		outputText("\n\nYour skin feels clammy and a little rubbery. You touch yourself experimentally and notice that you can barely feel the pressure from your fingertips. Consumed with curiosity, you punch yourself lightly in the arm; the most you feel is a dull throb!");
		dynStats("sen", -1);
	}
	if (rand(3) == 0 && player.inte > 15 && player.faceType == Face.RHINO && player.horns.count == 2) {
		outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
		player.addCurse("int", 1, 1);
	}
	if (rand(3) == 0 && player.racialScore(Races.RHINO, false) >= 2 && (rand(2) == 0 || !player.inRut) && player.hasCock()) {
		player.goIntoRut(true);
	}
	if (player.blockingBodyTransformations()) changeLimit = 0;
	// Sexual TFs
	//------------
	//Change a cock to rhino.
	if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) < player.cockTotal()) {
		for (var i:int = 0; i < player.cocks.length; i++) {
			if (player.cocks[i].cockType != CockTypesEnum.RHINO) {
				CoC.instance.transformations.CockRhino(i, player.cocks[i].cockLength, player.cocks[i].cockThickness, true).applyEffect();
				break;
			}
		}
		dynStats("lus", 20, "scale", false);
		changes++;
	}
	//Increase cock size of non-rhino up to 10 inches.
	if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.smallestCockLength() < 10 && player.cockTotal() - player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
		var cocksAffected:int = 0;
		for (i = 0; i < player.cockTotal(); i++) {
			if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength >= 10) continue; //Skip over if rhino cock.
			var i2:int = player.growCock(player.smallestCockIndex(), rand(2) + 1);
			dynStats("lib", 0.5, "lus", 3);
			cocksAffected++;
		}
		outputText("\n\n");
		player.lengthChange(i2, cocksAffected);
		changes++;
	}
	//Increase girth of rhino cock.
	if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
		for (i = 0; i < player.cockTotal(); i++) {
			if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockThickness < 3) {
				player.thickenCock(i, 0.5);
				dynStats("lib", 0.5, "lus", 3);
				break;
			}
		}
		changes++;
	}
	//Increase length of rhino cock.
	if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
		for (i = 0; i < player.cockTotal(); i++) {
			if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength < 18) {
				i2 = player.growCock(i, 1 + rand(2));
				outputText("\n\n");
				player.lengthChange(i2, 1);
				dynStats("lib", 0.5, "lus", 3);
				break;
			}
		}
		changes++;
	}
	//Grow balls
	if (rand(3) == 0 && changes < changeLimit && player.hasBalls() && player.ballSize < 4) {
		if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + simpleBallsDescript() + " have grown larger than a human's.");
		if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + sackDescript() + ". Walking becomes difficult as you discover your " + simpleBallsDescript() + " have enlarged again.");
		dynStats("lib", 1, "lus", 3);
		player.ballSize++;
		changes++;
	}
	//Boost vaginal capacity without gaping
	if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 40) {
		if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
		outputText("\n\nThere is a sudden... emptiness within your " + vaginaDescript(0) + ". Somehow you know you could accommodate even larger... insertions.");
		changes++;
	}
	//Boost anal capacity without gaping
	if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 60) {
		if (player.statusEffectv1(StatusEffects.BonusACapacity) < 60) {
			if (!player.hasStatusEffect(StatusEffects.BonusACapacity)) player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.BonusACapacity, 1, 5);
			outputText("\n\nYou feel... more accommodating somehow. Your " + assholeDescript() + " is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.");
			changes++;
		}
	}
	// Normal TFs
	//------------
	//Removes wings
	if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.wings.type > Wings.NONE) {
		outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades. After a moment the pain passes, though your wings are gone!");
		player.wings.type = Wings.NONE;
		changes++;
	}
	//Stone skin
	if (grilled && rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.hasPlainSkinOnly()) {
		outputText("You feel an itching sensation as your skin slowly petrify, but it still allow you to move becoming <b>tough gray stone skin</b>.");
		player.skin.setBaseOnly({color:"gray",adj:"tough",type:Skin.STONE});
		changes++;
	}
	//Fur/scales fall out
	if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && (player.hasCoat() || player.skinColor != "gray" || player.skinAdj != "tough")) {
		outputText("\n\n");
		if (player.hasCoat()) {
			switch (player.coatType()) {
				case Skin.FUR:
					outputText("You feel an itching sensation as your fur beings to fall off in clumps, <b>revealing tough gray skin</b> beneath it.");
					break;
				case Skin.SCALES:
					outputText("You feel an odd rolling sensation as your scales begin to shift, spreading and reforming as they grow and disappear, <b>becoming tough gray skin</b>.");
					break;
			}
		} else switch(player.skin.base.type){
			case Skin.GOO:
				outputText("You feel an itchy sensation as your gooey skin solidifies and thickens, <b>becoming tough gray skin</b>.");
				break;
			case Skin.PLAIN:
			default:
				outputText("You feel an itchy sensation as your [skin base] thickens, <b>becoming tough gray skin</b>.");
				break;
		}
		player.skin.setBaseOnly({color:"gray",adj:"tough",type:Skin.PLAIN});
		changes++;
	}
	//Arms change to regular
	if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.arms.type != Arms.HUMAN && player.arms.type != Arms.RHINO && player.arms.type != Arms.STONE_RHINO) {
		switch(player.arms.type) {
			case Arms.HARPY:
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating. The wing-like shape your arms once had is gone in a matter of moments, leaving [skin.type] behind.");
				break;
			case Arms.SPIDER:
				outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away. The glossy black coating is soon gone, leaving [skin.type] behind.");
				break;
			default:
		}
		player.arms.type = Arms.HUMAN;
		changes++;
	}
	//Change legs to normal
	if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.lowerBody != LowerBody.HUMAN && player.lowerBody != LowerBody.HOOFED_NO_FUR && player.lowerBody != LowerBody.STONE_HOOFED_NO_FUR) {
		if (player.isBiped()) outputText("You feel an odd sensation in your [feet]. Your [feet] shift and you hear bones cracking as they reform into normal human feet.");
		player.lowerBody = LowerBody.HUMAN;
		player.legCount = 2;
		changes++;
	}
	//Removes antennaes!
	if (rand(3) == 0 && changes < changeLimit && player.antennae.type > Antennae.NONE) {
		outputText("\n\nYour " + hairDescript() + " itches so you give it a scratch, only to have your [antennae] fall to the ground. What a relief. <b>You've lost your [antennae]!</b>");
		player.antennae.type = Antennae.NONE;
		changes++;
	}
	//Hair turns back to normal
	if (rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.HairHuman.isPossible()) {
		outputText("\n\n");
		CoC.instance.transformations.HairHuman.applyEffect();
		changes++;
	}
	//Restart hair growth
	if(rand(3) == 0 && changes < changeLimit && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0) {
		outputText("\n\nYou feel an itching sensation in your scalp as you realize the change. <b>Your hair is growing normally again!</b>");
		flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
		changes++;
	}
	//Remove gills
	if (rand(3) == 0 && changes < changeLimit && player.hasGills()) {
		if (player.gills.type == Gills.ANEMONE) outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
		else outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.");
		outputText("  <b>You no longer have gills!</b>");
		player.gills.type = Gills.NONE;
		changes++;
	}
	// Rhino TFs
	//------------
	//Stone Rhino
	if (grilled && changes < changeLimit) {
		if (rand(3) == 0 && changes < changeLimit && player.isBiped() && player.lowerBody != LowerBody.GARGOYLE && player.tailType != Tail.STONE_RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.TailStoneRhino.applyEffect();
			changes++;
		}
		if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.STONE_HOOFED_NO_FUR) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyStoneHoofedNoFurBipedal.applyEffect();
			changes++;
		}
		if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.STONE_RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsStoneRhino.applyEffect();
			changes++;
		}
		//Tier 3
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type == Horns.STONE_RHINO && player.horns.count == 2) {
			outputText("\n\n");
			CoC.instance.transformations.HornsStoneRhino.applyEffect();
			changes++;
		}
		//Tier 2
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type == Horns.STONE_RHINO && player.horns.count == 1) {
			outputText("\n\n");
			CoC.instance.transformations.HornsStoneRhino.applyEffect();
			changes++;
		}
		//Tier 1
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type != Horns.STONE_RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.HornsStoneRhino.applyEffect();
			changes++;
		}
	}
	else if (!grilled) {
		//Change ears to rhino
		if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.ears.type != Ears.RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.EarsRhino.applyEffect();
			changes++;
		}
		//Change face to rhino
		if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.RHINO && player.skinColor == "gray" && player.faceType != Face.RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.FaceRhino.applyEffect();
			changes++;
		}
		//Change tail to rhino
		if (rand(3) == 0 && changes < changeLimit && player.isBiped() && player.lowerBody != LowerBody.GARGOYLE && player.tailType != Tail.RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.TailRhino.applyEffect();
			changes++;
		}
		//Change legs to rhino
		if (rand(3) == 0 && changes < changeLimit && player.lowerBody != LowerBody.HOOFED_NO_FUR) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyHoofedNoFurBipedal.applyEffect();
			changes++;
		}
		//Change arms to rhino
		if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsRhino.applyEffect();
			changes++;
		}
		//Gain rhino horns
		//Tier 3
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type == Horns.RHINO && player.horns.count == 2) {
			outputText("\n\n");
			CoC.instance.transformations.HornsRhino.applyEffect();
			changes++;
		}
		//Tier 2
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type == Horns.RHINO && player.horns.count == 1) {
			outputText("\n\n");
			CoC.instance.transformations.HornsRhino.applyEffect();
			changes++;
		}
		//Tier 1
		if (rand(3) == 0 && changes < changeLimit && player.faceType == Face.RHINO && player.horns.type != Horns.RHINO) {
			outputText("\n\n");
			CoC.instance.transformations.HornsRhino.applyEffect();
			changes++;
		}
	}
	// Other Changes
	//------------
	//Gain height
	if (rand(2) == 0 && changes < changeLimit && player.tallness < 102) {
		var growth:Number = rand(5) + 3;
		//Slow rate of growth near ceiling
		if (player.tallness > 90) growth = Math.floor(growth / 2);
		//Constrain height growth
		if (growth == 0) growth = 1; //Never 0
		if (growth > 6) growth = 6; //Constrain growth to 6 inches
		//Flavor texts. Flavored like 1950's cigarettes. Yum.
		if (growth < 3) outputText("\n\nYou shift uncomfortably as you realize you feel off balance. Gazing down, you realize you have grown SLIGHTLY taller.");
		if (growth >= 3 && growth < 6) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
		if (growth == 6) outputText("\n\nStaggering forwards, you clutch at your head dizzily. You spend a moment getting your balance, and stand up, feeling noticeably taller.");
		player.tallness += growth;
		changes++;
	}
	//Thick Skin perk
	if (rand(2) == 0 && changes < changeLimit && !player.hasPerk(PerkLib.ThickSkin)) {
		outputText("\n\nSlowly, ");
		if (!player.hasCoat()) outputText("your [skin base]");
		else outputText("the skin under your [skin coat]");
		outputText(" begins to feel duller, almost... thicker.  You pinch yourself and find that your epidermis feels more resistant to damage, almost like natural armor!\n<b>(Thick Skin - Perk Gained!)</b>");
		player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
		changes++;
	}
	//Gain muscle tone
	if (rand(2) == 0 && player.tone < 80) {
		if (player.tone < 50) player.modTone(80, 2 + rand(2));
		else player.modTone(80, 1 + rand(2));
	}
	//Gain thickness
	if (rand(2) == 0 && player.thickness < 80) {
		if (player.thickness < 50) player.modThickness(80, 2 + rand(2));
		else player.modThickness(80, 1 + rand(2));
	}
	//Slow hair production
	if (rand(3) == 0 && changes < changeLimit && flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] > 0) {
		outputText("\n\nYou feel a tingling sensation in your scalp. After a few seconds it stops… that was odd.");
		flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
		changes++;
	}
	flags[kFLAGS.TIMES_TRANSFORMED] += changes;
	if (grilled) player.refillHunger(40);
}
}
}