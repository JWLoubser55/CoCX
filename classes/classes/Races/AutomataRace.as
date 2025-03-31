package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class AutomataRace extends Race {
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

	public function AutomataRace(id:int) {
		super("Automata", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.hairType(Hair.SYNTHETIC, +1)
				.hornType(Horns.HEADSET, +1)
				.armType(Arms.MECHANICAL_DOLL_ARMS, +1)
				.legType(LowerBody.MECHANICAL_DOLL_LEGS, +1)
				.rearType(RearBody.SERIAL_CODE, +1)
				.cockOrVaginaOfType(CockTypesEnum.AUTOMATA, VaginaClass.AUTOMATA, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		buildTier(23, "Automata")
				.buffs({
					"str.mult": +2.50,
					"tou.mult": +2.50,
					"spe.mult": +2.50,
					"int.mult": +2.50,
					"wis.mult": -0.65,
					"lib.mult": +2.50,
					"sens": +150
				})
				.end();
	}
}
}
