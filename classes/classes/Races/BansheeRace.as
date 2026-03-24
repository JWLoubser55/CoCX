package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class BansheeRace extends Race {
    public static const BansheeHairColors:/*String*/Array = ["midnight black", "black", "snow white"];
	public static const BansheeSkinColors:/*String*/Array = ["pale blue","pale white"];
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
		mutationThreshold = 6;
        //tfRace = RaceMem.appendEnumVal("Banshee", CoC.instance.transformations.FullBanshee);
	}
	
	public override function setup():void {
		addScores()
				.armType(Arms.GHOST, +1)
				.legType(ANY(LowerBody.GHOST, LowerBody.GHOST_2), +1, -1000)
				.earType(Ears.ELVEN, +1, -1000)
				.hairType(Hair.SILKEN, +1)
				.eyeType(Eyes.ELF, +1)
				.tongueType(Tongue.ELF, +1)
				.eyeColor("pale blue", +1)
				.hairColor1(ANY(BansheeHairColors), +1)
				.skinColor1(ANY(BansheeSkinColors), +1)
				.plainSkinOfAdj("flawless", +1)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.rearType(RearBody.GHOSTLY_AURA, +4)
				.femininity(GREATER_THAN(69), +3)
				.femininity(LESS_THAN(70), -6)
				.tone(AT_MOST(60), +1)
				.thickness(AT_MOST(50), +1)
				.corruption(AT_LEAST(20), +2)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.MelkieLungIM);
		addMutation(IMutationsLib.EctoplasmicEssenceIM);
		addMutation(IMutationsLib.StillHeartIM);
		
		buildTier(9, "lesser banshee")
				.buffs({
					"str.mult": -0.45,
					"int.mult": +0.95,
					"lib.mult": +1.35,
					"sens": +50
				})
				.end();
				
		buildTier(16, "banshee")
				.buffs({
					"str.mult": -0.90,
					"int.mult": +1.80,
					"lib.mult": +2.00,
					"sens": +50
				})
				.end();
				
		buildTier(28, "unhallowed banshee")
				.buffs({
					"str.mult": -0.90,
					"int.mult": +3.00,
					"lib.mult": +2.60,
					"sens": +50
				})
				.end();
	}
}
}
