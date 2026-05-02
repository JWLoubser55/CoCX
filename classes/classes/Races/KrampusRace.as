package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class KrampusRace extends Race {
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
        
    public function KrampusRace(id:int) {
        super("Krampus", id, []);//RaceBody);
		disabled = true;
    }
    
    public override function setup():void {
        addScores()
				.faceType(ANY(Face.DEVIL_FANGS, Face.DRAGON_FANGS), +1)
				.hornType(Horns.GOAT, +1)
				.hornType(Horns.GOATQUAD, +2)
				.hornType(NONE(Horns.FROSTWYRM, Horns.DRACONIC_X2, Horns.DRACONIC_X4_12_INCH_LONG), 0, -3)
				.earType(Ears.GOAT, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.tongueType(NOT(Tongue.CAT), 0, -1000)
				.tailType(Tail.DRACONIC, +1)
				.tailType(NONE(Tail.FEY_DRACONIC, Tail.CAT), 0, -10)
				.wingType(Wings.DRACONIC_SMALL, +2)
				.wingType(Wings.DRACONIC_LARGE, +4)
				.wingType(Wings.DRACONIC_HUGE, +6)
				.wingType(NOT(Wings.FEY_DRAGON), 0, -10)
				.customRequirement("", "white secondary and black primary hair color",
						function (body:BodyData):Boolean {
							return body.hairColor2 == "white" &&
									body.hairColor1 == "black"
						}, +1)
				.height(LESS_THAN(48), +1)
				.height(GREATER_THAN(120), +1)
                .hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.DrakeLungsIM);

        buildTier(12, "krampus hatchling")
                .buffs({
					"maxhp_mult": +0.05,
					"maxlust_base": +100,
					"str.mult": +0.70,
					"tou.mult": +0.10,
					"spe.mult": +0.10,
					"int.mult": +0.50,
					"wis.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +60
                    })
                .end();
    }
}
}