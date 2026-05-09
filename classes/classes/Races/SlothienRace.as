package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class SlothienRace extends Race {
    public static const SlothienEyesColors:/*String*/Array = ["red","orange"];
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
        
    public function SlothienRace(id:int) {
        super("Slothien", id, []);//RaceBody);
		disabled = true;
    }
    
    public override function setup():void {
        addScores()
                .eyeType(Eyes.SLOTHIEN, +1)
				.eyeColor(ANY(SlothienEyesColors), +1)
				.legType(LowerBody.SLOTHIEN, +3)
				.skinCoatType(Skin.CHITIN, +1)
				.skinCoverage(ANY(Skin.COVERAGE_HIGH, Skin.COVERAGE_COMPLETE), +1)
                .hasPerk(PerkLib.GOBXChemical, -1000);

        addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(10, "juvenile slothien")
                .buffs({
                        "str.mult": +0.20,
                        "tou.mult": +0.30,
                        "spe.mult": +1.00,
                        "int.mult": -0.20,
                        "wis.mult": +0.20
                    })
                .end();
		
		buildTier(16, "slothien")
                .buffs({
                        "str.mult": +0.40,
                        "tou.mult": +0.50,
                        "spe.mult": +1.50,
                        "int.mult": -0.40,
                        "wis.mult": +0.40,
						"def": +1,
						"mdef": +1
                    })
                .end();
    }
}
}