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
				//.
				//.
				.faceType(Face.HUMAN, +1)
				//.
				//.
				//.
				.hairType(ANY(Hair.LEAF,Hair.GRASS), +1)
				//.
				//.
				//.
				.wingType(Wings.PLANT, +1)
				//.
				//.
				.isTaur(+2, -1000)
				//.
				//.
				//.
				//.
				//.
				.vaginaType(VaginaClass.EQUINE, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.PlantChlorophyllIM);
		addMutation(IMutationsLib.EquineMuscleIM);
		
		buildTier(20, "barometz")
				.buffs({
					"tou.mult": +1.30,
					"spe.mult": +1.30,
					"int.mult": -0.50,
					"lib.mult": +1.30,
					"sens": +50
				})
				.end();
		
		buildTier(34, "blooming barometz")
				.buffs({
					"tou.mult": +2.00,
					"spe.mult": +2.00,
					"int.mult": -0.50,
					"lib.mult": +2.00,
					"sens": +50
				})
				.end();
	}
}
}
