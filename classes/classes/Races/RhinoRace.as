package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class RhinoRace extends Race {
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

	public function RhinoRace(id:int) {
		super("Rhino", id, []);//RaceBody);
		mutationThreshold = 4;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.RHINO, +1)
				.faceType(Face.RHINO, +1)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(1), +1)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(2), +1)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(3), +1)
				.tailType(Tail.RHINO, +1)
				.armType(Arms.RHINO, +1)//(evo) arms (+2)
				.legType(LowerBody.HOOFED_NO_FUR, +1)//(evo) legs (+2)
				.skinColor1("gray", +1)
				.hasCockOfType(CockTypesEnum.RHINO, +1)
				.hasPerk(PerkLib.ThickSkin, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.EquineMuscleIM);
		
		buildTier(8, "rhino")
				.namesMaleFemaleMorphTaur("rhino-man","rhino-girl","rhino-morph","rhino-morph")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.90,
					"int.mult": -0.20,
					"sens": -40,
					"maxhp_base": +100,
					"def": +5,
					"mdef": +2
				})
				.end();/*
		
		buildTier(14, "stone rhino")
				.namesMaleFemaleMorphTaur("stone rhino-man","stone rhino-girl","stone rhino-morph","stone rhino-morph")
				.requireArmType(Arms.HINEZUMI)
				.requireLegType(LowerBody.HINEZUMI)
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.90,
					"int.mult": -0.20,
					"sens": -40,
					"maxhp_base": +200,
					"def": +10,
					"mdef": +4
				})
				.end();
		
		buildTier(20, "rhino")
				.namesMaleFemaleMorphTaur("rhino-man","rhino-girl","rhino-morph","rhino-morph")
				.requirePreviousTier()
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.90,
					"int.mult": -0.20,
					"sens": -40,
					"maxhp_base": +300,
					"def": +15,
					"mdef": +6
				})
				.end();*/
	}
}
}
