package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Races;

public class MarilithRace extends Race {
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
	
	public function MarilithRace(id:int) {
		super("Marilith", id, []);//RaceBody);
	}
	
	public override function setup():void {
        addScores()
				.hornType(Horns.DEMON, +1)
				//.eyeType(Eyes., +2)
				.hairType(Hair.NORMAL, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.earType(Ears.SNAKE, +1)
				.tongueType(Tongue.SNAKE, +1)
				.armType(Arms.HYDRA, +1)
                .armType(Arms.MARILITH, +2, -1000)
				.isNaga(+3, -1000)
				.noWings(+4)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(70), +1)
				.hasPerk(PerkLib.DemonicLethicite, +1)
				.hasPerk(PerkLib.Soulless, +4)
				.hasPerk(PerkLib.GOBXChemical, -1000);
				
		addMutation(IMutationsLib.BlackHeartIM);
		addMutation(IMutationsLib.FiendishMetabolismIM);

		buildTier(18, "Marilith")
				.buffs({
						"str.mult": +1.00,
						"spe.mult": +1.20,
						"int.mult": +0.50,
						"lib.mult": +0.50,
						"sens": +50
					})
				.end();
    }
}
}