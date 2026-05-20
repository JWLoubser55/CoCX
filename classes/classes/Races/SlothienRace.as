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
				.earType(Ears.INSECT, +1)
				.faceType(Face.SLOTHIEN, +1)
				.tongueType(Tongue.SLOTHIEN, +1)
				.hornType(Horns.SLOTHIEN, +1)
				.customRequirement("","horns size > 4",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 4
						}, +1)
				.customRequirement("","horns size > 8",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 8
						}, +1)
				.rearType(RearBody.SLOTHIEN, +2)//+1 for rear and +1 for neck
				.armType(Arms.SLOTHIEN, +2)
				.legType(LowerBody.SLOTHIEN, +4)
				.skinCoatType(Skin.CHITIN, +2)//skin pattern?
				.skinCoverage(Skin.COVERAGE_COMPLETE, +1)
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
						"def": +3,
						"mdef": +3
                    })
                .end();
    }
}
}