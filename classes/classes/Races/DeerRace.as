package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DeerRace extends Race{
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

    public function DeerRace(id:int) {
		super("Deer", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.DEER, +1)
				.tailType(Tail.DEER, +1)
				.faceType(Face.DEER, +1)
				.armType(ANY(Arms.HUMAN, Arms.DEER), +1)
				//.armType(Arms.REINDEER, +2)
				.armType(NOT(Arms.WENDIGO), 0, -5)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				//.legType(LowerBody.CLOVEN_HOOFED_2, +2)
				.legType(NOT(LowerBody.WENDIGO), 0, -5)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(4), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(14), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(24), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(34), +1)
				.skinCoatType(Skin.FUR, +1)
				.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addBloodline(PerkLib.DeersDescendant, PerkLib.BloodlineDeer);
		addMutation(IMutationsLib.TwinHeartIM);
		addMutation(IMutationsLib.MightyLegsIM);
		addMutation(IMutationsLib.FrozenHeartIM);
		addMutation(IMutationsLib.EquineMuscleIM);
		
		buildTier(8, "deer")
				.namesMaleFemaleMorphTaur("deer-morph", "deer-girl", "deer-morph", "deer-taur")
				.buffs({
					"str.mult": +0.75,
					"tou.mult": +0.75,
					"spe.mult": +0.25,
					"lib.mult": +0.20,
					"sens": +75
				})
				.end();
		
		buildTier(16, "froststrider deer")
				.namesMaleFemaleMorphTaur("froststrider deer-morph", "froststrider deer-girl", "froststrider deer-morph", "froststrider deer-taur")
				.buffs({
					"str.mult": +1.50,
					"tou.mult": +1.50,
					"spe.mult": +0.50,
					"lib.mult": +0.40,
					"sens": +150
				})
				.end();
		
		buildTier(24, "cernos")
				.namesTauric("cernos","cernos-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.80,
					"tou.mult": +1.80,
					"spe.mult": +1.00,
					"lib.mult": +1.00,
					"sens": +200
				})
				.end();/*
		
		buildTier(12, "reindeer")
				.namesMaleFemaleMorphTaur("reindeer-morph", "reindeer-girl", "reindeer-morph", "reindeer-taur")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.25,
					"spe.mult": +0.50,
					"int.mult": -0.20,
					"wis.mult": +0.40
					//"sens": +85
				})
				.end();*/
	}
}
}
