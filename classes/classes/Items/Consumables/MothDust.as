package classes.Items.Consumables {
import classes.BodyParts.*;
import classes.CoC;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Races.MothRace;

public class MothDust extends Consumable {
    public function MothDust() {
        super("MothDus", "MothDust", "a handful of luminescent dust", 6, "A strange golden powder that reminds you of dew sparkling in the moonlight.");
        withTag(U_TF);
        refineableInto(
                AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
                AlchemyLib.DEFAULT_ESSENCE_DROP_TABLE(AlchemyLib.AE_MOTH)
        )
    }
    override public function useItem():Boolean {
        player.slimeFeed();
        //Changes done
        var changes:Number = 0;
        //Change limit
        var changeLimit:Number = 2;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (changeLimit == 1) changeLimit = 2;
        changeLimit += player.additionalTransformationChances;
		clearOutput();
        outputText("Opening up the bag of powder you begin to pour it down your mouth and the dust makes you sneeze.");
        //Statistical changes:
        //-Raises speed to 100.
        if (rand(2) == 0 && changes < changeLimit && player.MutagenBonus("spe", 1)) {
            outputText("\n\nHearing a sudden sound you suddenly move by reflex to the side with such speed you nearly trip.  Seems your reaction speed has increased as well as your mobile execution.");
            changes++;
        }
        //disable changes if blocking
        if (player.blockingBodyTransformations()) changeLimit = 0;
        //tail
        if (changes < changeLimit && rand(3) == 0 && player.tailType != Tail.MOTH_ABDOMEN) {
            outputText("\n\n");
            CoC.instance.transformations.TailMoth.applyEffect();
            changes++;
        }
        //Ears
        if (changes < changeLimit && rand(3) == 0 && player.ears.type != Ears.INSECT) {
            outputText("\n\n");
            CoC.instance.transformations.EarsInsect.applyEffect();
            changes++;
        }
		//Face
        if (changes < changeLimit && rand(3) == 0 && player.faceType != Face.HUMAN) {
            outputText("\n\n");
            CoC.instance.transformations.FaceHuman.applyEffect();
            changes++;
        }
        //Eyes
        if (changes < changeLimit && rand(3) == 0 && player.eyes.type != Eyes.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.EyesMoth.applyEffect();
            changes++;
        }
		//Eyes Color
		if (!InCollection(player.eyes.colour, MothRace.MothEyesColors) && rand(3) == 0 && changes < changeLimit) {
            outputText("\n\n");
            CoC.instance.transformations.EyesChangeColor(MothRace.MothEyesColors).applyEffect();
            changes++;
        }
		//Hair
        if (changes < changeLimit && player.hairType != Hair.NORMAL && rand(3) == 0) {
		    outputText("\n\n");
		    CoC.instance.transformations.HairHuman.applyEffect();
            changes++;
        }
		//Hair Color
        if (!InCollection(player.hairColor, MothRace.MothHairColors) && changes < changeLimit && rand(3) == 0) {
            player.hairColor = randomChoice(MothRace.MothHairColors);
            outputText("\n\nYour scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!");
        }
        //LowerBody
        if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.LowerBodyMoth.applyEffect();
            changes++;
        }
        //Antenna
        if (changes < changeLimit && rand(3) == 0 && player.antennae.type != Antennae.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.AntennaeMoth.applyEffect();
            changes++;
        }
		//Tongue
		
		//Plain skin
        if (!player.hasPlainSkinOnly() && rand(3) == 0 && changes < changeLimit) {
            if (player.skinAdj != "") player.skinAdj = "";
            outputText("\n\n");
            CoC.instance.transformations.SkinPlain.applyEffect();
            changes++;
        }
        //Arms
        if (changes < changeLimit && rand(3) == 0 && player.arms.type != Arms.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.ArmsMoth.applyEffect();
            changes++;
        }
        //Wings
        if (changes < changeLimit && rand(3) == 0 && player.wings.type == Wings.MOTH_SMALL) {
            outputText("\n\n");
            CoC.instance.transformations.WingsMothLarge.applyEffect();
            changes++;
        }
		if (changes < changeLimit && rand(3) == 0 && player.wings.type != Wings.MOTH_SMALL && player.wings.type != Wings.MOTH_LARGE) {
            outputText("\n\n");
            CoC.instance.transformations.WingsMothSmall.applyEffect();
            changes++;
        }
        //Rearbody
        if (changes < changeLimit && rand(3) == 0 && player.rearBody.type != RearBody.MOTH_COLLAR) {
            outputText("\n\n");
            CoC.instance.transformations.RearBodyMoth.applyEffect();
            changes++;
        }
        //Horns
        if (changes < changeLimit && rand(3) == 0 && player.horns.type != Horns.NONE) {
            outputText("\n\n");
            CoC.instance.transformations.HornsNone.applyEffect();
            changes++;
        }
		//oviposition
        if (changes < changeLimit && player.hasCoatOfType(Skin.CHITIN) && CoC.instance.transformations.OvipositorMoth.isPossible() && rand(2) == 0) {
            CoC.instance.transformations.OvipositorMoth.applyEffect();
            changes++;
        }
		//If no changes yay
        if (changes == 0) {
            outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
            pc.HPChange(Math.round(20*player.postConsumptionMlt()), true, false);
            dynStats("lus", Math.round(3*player.postConsumptionMlt()), "scale", false);
        }
        return false;
    }
}
}
