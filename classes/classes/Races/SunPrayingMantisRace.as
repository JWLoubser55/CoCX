package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class SunPrayingMantisRace extends Race {
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

	public function SunPrayingMantisRace(id:int) {
		super("Sun Praying Mantis", id, []);//RaceBody);
		disabled = true;
	}
	
	public override function setup():void {
        addScores()
				.wingType(Wings.MANTIS_LARGE_2, +4)
                .hasPerk(PerkLib.MantisOvipositor, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears

        buildTier(1000, "tierName")
                .buffs({
                        "str.mult": +0.00,
                        "tou.mult": +0.00,
                        "spe.mult": +0.00,
                        "int.mult": +0.00,
                        "wis.mult": +0.00,
                        "lib.mult": +0.00,
                        "sens": +0
                    })
                .end();
    }
}
}