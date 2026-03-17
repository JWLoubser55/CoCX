package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class BansheeRace extends Race {
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

	public function BansheeRace(id:int) {
		super("Banshee", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
        //tfRace = RaceMem.appendEnumVal("Banshee", CoC.instance.transformations.FullBanshee);
	}
	
	public override function setup():void {
		addScores()
				.armType(Arms.GHOST, +1)
				.legType(LowerBody.GHOST, +1)
				.earType(Ears.ELVEN, +1, -1000)
				.hairType(Hair.SILKEN, +1)
				.eyeType(Eyes.ELF, +1)
				.tongueType(Tongue.ELF, +1, -1000)
				//
				//
				//
				//
				.rearType(RearBody.GHOSTLY_AURA, +4)
				.femininity(GREATER_THAN(69), +3)
				.femininity(LESS_THAN(70), -6)
				//Slim (as by elf) +1
				.corruption(AT_LEAST(20), +2)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.MelkieLungIM);
		//
		addMutation(IMutationsLib.StillHeartIM);
		
		buildTier(9, "banshee")
				.buffs({
					"str.mult": -0.45,
					"int.mult": +0.95,
					"lib.mult": +1.35,
					"sens": +50
				})
				.end();
				
		buildTier(16, "unhallowed banshee")
				.buffs({
					"str.mult": -0.90,
					"int.mult": +1.80,
					"lib.mult": +2.00,
					"sens": +50
				})
				.end();
	}
}
}
