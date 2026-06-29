package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

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
				.legType(LowerBody.FROG, +1, -5)
				.armType(Arms.FROG, +1)
				.faceType(Face.FROG, +1)
				.tongueType(Tongue.CHAMELEON, +1, -5)
                .hornType(Horns.DRACONIC_X2, +1)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
                .eyeType(Eyes.FROG, +1)
				.eyeColor(ANY(FrogEyesColors), +1)
				.antennaeType(Antennae.THIRD_EYE, +1)
				.skinColor1(ANY(FrogSkinColors), +1).customRequirement("","mucus dripping skin",
						function (body:BodyData):Boolean {
							return body.player.hasMucusSkin();
						}, +3)
				.noTail(+1)
                .noWings(+1)
				.wingType(ANY(Wings.DRACONIC_SMALL, Wings.DRACONIC_LARGE, Wings.DRACONIC_HUGE), +4)
				.height(GREATER_THAN(120), +1)
				.cockOrVaginaOfType(CockTypesEnum.DRAGON, VaginaClass.DRAGON, +2)
				.hasPerk(PerkLib.EggCarrier, +2)
				.hasPerk(PerkLib.DragonAcidBreath, +1)
				.hasPerk(PerkLib.Dracoforce, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);;

        addMutation(IMutationsLib.FrogJumpingLegsIM);
		addMutation(IMutationsLib.AmphibiousEgglayerIM);
		addMutation(IMutationsLib.DrakeBloodIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
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
				.requireWingType(ANY(Wings.DRACONIC_SMALL, Wings.DRACONIC_LARGE, Wings.DRACONIC_HUGE))
                .buffs({
                        "str.mult": +1.00,
                        "tou.mult": +0.75,
                        "wis.mult": +0.50
                    })
                .end();

        buildTier(33, "mobogo")
				.namesMaleFemale("mobogo boy", "mobogo girl")
				.requirePreviousTier()
                .buffs({
                        "str.mult": +2.00,
                        "tou.mult": +1.50,
                        "spe.mult": +0.75,
                        "wis.mult": +0.70
                    })
                .end();
    }
}
}