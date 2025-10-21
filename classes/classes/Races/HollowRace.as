package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class HollowRace extends Race {
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

	public function HollowRace(id:int) {
		super("Hollow", id, []);//RaceBody);
		disabled = true;
	}
	
	public override function setup():void {
		addScores()
				.hornType(ANY(Horns.RAM, Horns.DRACONIC_X2, Horns.DRACONIC_X4_12_INCH_LONG, Horns.DEMON, Horns.ANTLERS), +1)
				.armType(ANY(Arms.HUMAN, Arms.DEVIL, Arms.SATYR, Arms.ONI, Arms.RAIJU, Arms.WENDIGO), +1)
				.legType(ANY(LowerBody.HUMAN, LowerBody.HOOFED, LowerBody.KIRIN, LowerBody.ONI, LowerBody.RAIJU, LowerBody.CLOVEN_HOOFED, LowerBody.SCYLLA), +1)
				.isTaur(+1)
				.tailType(ANY(Tail.SALAMANDER, Tail.DRACONIC), +1)
				.skinCoatPattern(Skin.PATTERN_WHITE_BLACK_VEINS, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.LivingWeaponIM);
		
		buildTier(14, "Demi-Hollow")
				//requirePerk(PerkLib.)
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.75,
					"int.mult": +0.50,
					"wis.mult": +0.75,
					"sens": +40
				})
				.end();/*
		
		buildTier(24, "Hollow")//360+50
				requirePerk(PerkLib.)
				.buffs({
					"str.mult": +0.20,
					"tou.mult": +0.35,
					"int.mult": +0.20,
					"wis.mult": +0.35,
					"sens": +50
				})
				.end();*/
	}
}
}
