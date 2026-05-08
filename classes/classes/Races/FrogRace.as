package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class FrogRace extends Race {
    public static const FrogSkinColors:/*String*/Array = ["green","yellow","blue","red","light green"];
	public static const FrogEyesColors:/*String*/Array = ["yellow","orange"];
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
        
    public function FrogRace(id:int) {
        super("Frog", id, []);//RaceBody);
    }
    
    public override function setup():void {
        addScores()
                .eyeColor(ANY(FrogEyesColors), +1)
				.skinColor1(ANY(FrogSkinColors), +1)
				.noTail(+1)
                .noWings( +1)
				.height(GREATER_THAN(120), +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);

        buildTier(10, "frog")
				.namesMaleFemale("frog boy", "frog girl")
                .buffs({
                        "str.mult": +0.50,
                        "tou.mult": -0.20,
                        "spe.mult": +0.50,
                        "wis.mult": +0.70
                    })
                .end();

        buildTier(15, "swamp dragon")
				.namesMaleFemale("swamp dragon boy", "swamp dragon girl")
                .buffs({
                        "str.mult": +1.00,
                        "tou.mult": +0.75,
                        "wis.mult": +0.50
                    })
                .end();
    }
}
}