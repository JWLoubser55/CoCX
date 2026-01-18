package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class UshiOniRace extends Race{
	public static const UshiOniSkinColors:/*String*/Array = ["green", "red", "grey", "sandy-tan", "pale", "purple"];
	public static const UshiOniHairColors:/*String*/Array = ["dark green", "dark red", "blue", "brown", "white", "black"];
	public static const UshiOniEyeColors:/*String*/Array = ["black", "red", "gray", "brown", "light blue","yellow"];
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
	
	public function UshiOniRace(id:int) {
		super("Ushi-Onna", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.COW, +1)
				.eyeType(Eyes.SPIDER, +1)
				.faceType(Face.USHI_ONI, +1)
				.hornType(Horns.USHI_ONI, +1)
				.tailType(Tail.USHI_ONI, +2)
				.armType(Arms.USHI_ONI, +2)
				.legType(LowerBody.USHI_ONI, +4)
				.skinBasePattern(Skin.PATTERN_USHI_ONI_TATTOO, +2)
				.hairTypeAndColor1(Hair.NORMAL, ANY(UshiOniHairColors), +1)
				.plainSkinOfColor1(ANY(UshiOniSkinColors), +1)
				.height(AT_LEAST(108), +1)
				.hasPerk(PerkLib.MonstrousRegeneration, +1)
				.hasPerk(PerkLib.SpiderOvipositor, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(10, "ushi-oni")
				.customNamingFunction(function(body:BodyData):String {
					var prefix:String = "";
					switch (body.player.statusEffectv1(StatusEffects.UshiOnnaVariant)) {
						case 1: prefix = "fiery "; break;
						case 2: prefix = "frozen "; break;
						case 3: prefix = "sandy "; break;
						case 4: prefix = "pure "; break;
						case 5: prefix = "wicked "; break;
					}
					return prefix + body.mf("ushi-oni","ushi-onna");
				})
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +0.70,
					"int.mult": -0.50,
					"wis.mult": -0.45,
					"lib.mult": +0.95
				})
				.end();
		
		buildTier(18, "elder ushi-oni")
				.customNamingFunction(function(body:BodyData):String {
					var prefix:String = "";
					switch (body.player.statusEffectv1(StatusEffects.UshiOnnaVariant)) {
						case 1: prefix = "fiery "; break;
						case 2: prefix = "frozen "; break;
						case 3: prefix = "sandy "; break;
						case 4: prefix = "pure "; break;
						case 5: prefix = "wicked "; break;
					}
					return prefix + body.mf("ushi-oni","ushi-onna");
				})
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +1.15,
					"int.mult": -0.75,
					"wis.mult": -0.60,
					"lib.mult": +1.60
				})
				.end();
		
		buildTier(26, "ancient ushi-oni")
				.customNamingFunction(function(body:BodyData):String {
					var prefix:String = "";
					switch (body.player.statusEffectv1(StatusEffects.UshiOnnaVariant)) {
						case 1: prefix = "fiery "; break;
						case 2: prefix = "frozen "; break;
						case 3: prefix = "sandy "; break;
						case 4: prefix = "pure "; break;
						case 5: prefix = "wicked "; break;
					}
					return prefix + body.mf("ushi-oni","ushi-onna");
				})
				.buffs({
					"str.mult": +1.80,
					"tou.mult": +1.50,
					"int.mult": -1.00,
					"wis.mult": -0.75,
					"lib.mult": +2.35
				})
				.end();
	}
}
}
