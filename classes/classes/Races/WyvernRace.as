package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class WyvernRace extends Race {
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
        
    public function WyvernRace(id:int) {
        super("Wyvern", id, []);//RaceBody);
		disabled = true;
    }
    
    public override function setup():void {
        addScores()
                .skinCoatType(Skin.FEATHER, +1)
				.wingType(Wings.FEATHERED_LARGE, +4)
				.faceType(ANY(Face.DRAGON, Face.DRAGON_FANGS), +1)
				.eyeType(Eyes.DRACONIC, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);

        buildTier(12, "wyvern hatchling")
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