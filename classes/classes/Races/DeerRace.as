package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DeerRace extends Race{
    public static const DeerFurColors:/*String*/Array = ["brown", "white", "silver white"];
    public static const DeerHairColors:/*String*/Array = ["snow white", "silver white", "platinum blonde", "quartz white"];
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
				.eyeTypeAndColor(Eyes.DEER, "golden", +2)
				.faceType(ANY(Face.DEER, Face.DEER_BLUSH), +1)
				.tongueType(Tongue.HUMAN, +1)
				.armType(Arms.DEER, +1)
				.armType(NOT(Arms.WENDIGO), 0, -5)
				.armType(NOT(Arms.REINDEER), 0, -5)
				.customRequirement("legs","shaggy centaur lower body",
						function (body:BodyData): Boolean {
							return body.legType == LowerBody.CLOVEN_HOOFED && body.player.isTaur();
						}, +3)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.legType(NOT(LowerBody.WENDIGO), 0, -5)
				.legType(NOT(LowerBody.CLOVEN_HOOFED_2), 0, -5)
				.tailType(Tail.DEER, +1)
				.hornType(Horns.ANTLERS, +1)
				.skinCoatType(Skin.FUR, +1)
				.furColor1(ANY(DeerFurColors), +1)
				.hairColor1(ANY(DeerHairColors), +1)
				.skinBasePattern(Skin.PATTERN_ICEHEART_TATOO, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		addScoresAfter(6)
				.armType(Arms.HUMAN, +1)
				.biggestTitSize(GREATER_THAN(4), +1);
		
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
				.end();
		
		buildTier(32, "grand cernos")
				.namesTauric("grand cernos","grand cernos-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": +2.00,
					"tou.mult": +2.00,
					"spe.mult": +1.65,
					"lib.mult": +1.65,
					"sens": +250
				})
				.end();
	}
}
}
