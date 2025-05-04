package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class BarometzRace extends Race {
    public static const BarometzFurHairColor:/*String*/Array = ["green", "leaf green", "light green"];
    public static const BarometzEyeColor:/*String*/Array = ["light green", "lime"];
    public static const BarometzSkinColor:/*String*/Array = ["tan", "brown", "caramel", "white"];
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

	public function BarometzRace(id:int) {
		super("Barometz", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.hornType(Horns.RAM, +1)
				.hornType(Horns.VERDANT_RAM, +2)
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.GOAT, +1)
				.eyeColor(ANY(BarometzEyeColor), +1)
				.earType(Ears.BAROMETZ, +1)
				.hairType(ANY(Hair.LEAF,Hair.GRASS), +1)
				.hairColor1(ANY(BarometzFurHairColor), +1)
				.furColor01(ANY(BarometzFurHairColor), +1)
				.wingType(Wings.PLANT, +1)
				.armType(ANY(Arms.PLANT,Arms.PLANT2), +1)
				.legType(LowerBody.BAROMETZ, +1, -1000)
				.isTaur(+2)
				.skinBasePattern(Skin.PATTERN_RUNIC, +1)
				.customRequirement("skin", "bark skin", function (body:BodyData):Boolean {
					return body.player.isBarkSkin()
				}, +2)
				.skinColor1(ANY(BarometzSkinColor), +1)
				.tailType(Tail.BAROMETZ, +1)
				.hasCockOfType(CockTypesEnum.BAROMETZ, +1)
				.customScoreRequirement("cock", "multiple tentacle cocks, +1 per cock",
						function (body:BodyData):Boolean {
							return body.player.tentacleOnlyCocks() > 0;
						},
						function (body:BodyData):int { 
							return body.player.tentacleOnlyCocks();
						})
				.vaginaType(VaginaClass.EQUINE, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.PlantChlorophyllIM);
		addMutation(IMutationsLib.EquineMuscleIM);
		
		buildTier(20, "barometz")
				.buffs({
					"tou.mult": +1.30,
					"spe.mult": +1.30,
					"int.mult": -0.40,
					"wis.mult": +0.80,
					"lib.mult": +1.00,
					"sens": +100
				})
				.end();
		
		buildTier(34, "blooming barometz")
				.buffs({
					"tou.mult": +2.00,
					"spe.mult": +2.00,
					"int.mult": -0.40,
					"wis.mult": +2.00,
					"lib.mult": +1.50,
					"sens": +200
				})
				.end();
	}
}
}
