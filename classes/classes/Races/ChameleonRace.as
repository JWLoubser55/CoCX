package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class ChameleonRace extends Race {
	public static const ChameleonEyesColors:/*String*/Array = ["yellow","orange"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];
        
    public function ChameleonRace(id:int) {
        super("Chameleon", id, []);//RaceBody);
    }
    
    public override function setup():void {
        addScores()
                .armType(Arms.LIZARD, +2)
				.legType(LowerBody.LIZARD, +2)
				.tailType(Tail.CHAMELEON, +2)
				.earType(ANY(Ears.ELFIN, Ears.LIZARD), +1)//, Ears.ORCA
				.faceType(ANY(Face.ANIMAL_TOOTHS, Face.LIZARD), +1)
				.tongueType(Tongue.CHAMELEON, +1)
				.eyeType(Eyes.LIZARD, +1)
				.eyeColor(ANY(ChameleonEyesColors), +1)
				.skinCoatType(Skin.SCALES, +1)
				.skinCoverage(ANY(Skin.COVERAGE_HIGH, Skin.COVERAGE_COMPLETE), +1)
				.skinBasePattern(Skin.PATTERN_CHAMELEON, +1)
				.noWings(+1)
				.noHorns(0,-10)
                .hasPerk(PerkLib.GOBXChemical, -1000);

        addMutation(IMutationsLib.LizanMarrowIM);
		
		buildTier(11, "chameleon")
				.namesMaleFemale("chameleon boy", "chameleon girl")
                .buffs({
                        "tou.mult": +0.50,
                        "spe.mult": +0.65,
                        "wis.mult": +0.50
                    })
                .end();
		
		buildTier(19, "elder chameleon")
				.namesMaleFemale("elder chameleon boy", "elder chameleon girl")
                .buffs({
                        "tou.mult": +0.75,
                        "spe.mult": +1.05,
                        "wis.mult": +0.75
                    })
                .end();
    }
}
}