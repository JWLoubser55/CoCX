package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class DarkSlimeRace extends Race {
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

    public static const DarkSlimeSkinColors:/*String*/Array = ["indigo", "light purple", "purple", "purplish black", "dark purple"];
	
	public function DarkSlimeRace(id:int) {
		super("Dark slime", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(DarkSlimeSkinColors), +1, -1000)
				.hairType(Hair.GOO, +1)
				.armType(Arms.GOO, +1)
				.legType(LowerBody.GOO, +3)
				.rearType(RearBody.METAMORPHIC_GOO, +2)
				.customRequirement("skin", "slimy goo skin", function (body:BodyData):Boolean {
					return body.player.isGooSkin() && body.skinBaseAdj == "slimy"
				}, +1)
				.hasStatusEffect(StatusEffects.SlimeCraving, "Slime Craving", +1)
				.hasPerk(PerkLib.DarkSlimeCore, +1)
				.hasPerk(PerkLib.DarkSlimeEmpressCore, +5)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addConditionedScores(function (body:BodyData):Boolean {
			return body.player.isGooSkin() && body.skinBaseAdj == "slimy"
		}, "slimy goo skin;")
				.faceType(Face.HUMAN, +1)
				.eyeType(ANY(Eyes.HUMAN, Eyes.FIENDISH), +1)
				.earType(ANY(Ears.HUMAN, Ears.ELFIN), +1)
				.height(GREATER_THAN(107), +1)
				.hasVagina(+1)
				.noAntennae(+1)
				.noWings(+1)
				.noGills(+1);
		
		addMutation(IMutationsLib.SlimeMetabolismIM);
		addMutation(IMutationsLib.SlimeFluidIM);
		
		buildTier(12, "Dark Slime")
				.namesMaleFemale("Dark Slime boi", "Dark Slime Girl")
				.buffs({
					"tou.mult": +0.65,
					"spe.mult": -0.40,
					"int.mult": +0.45,
					"lib.mult": +1.00
				})
				.end();
		
		buildTier(16, "Dark Slime Princess")
				.namesMaleFemale("Dark Slime Prince", "Dark Slime Princess")
				.buffs({
					"tou.mult": +1.15,
					"spe.mult": -0.50,
					"int.mult": +0.90,
					"lib.mult": +1.45
				})
				.end();
				
		buildTier(24, "Dark Slime Queen")
				.namesMaleFemale("Dark Slime King", "Dark Slime Queen")
				.require("Slimy Crown or Sovereign's Dark Slime Core perk", function(body:BodyData):Boolean {
				return body.player.hasKeyItem("Slimy Crown")!=-1 || body.player.hasPerk(PerkLib.DarkSlimeEmpressCore)})
				.buffs({
					"tou.mult": +1.95,
					"spe.mult": -0.75,
					"int.mult": +1.85,
					"lib.mult": +1.5
				})
				.end();
		
		buildTier(32, "Dark Slime Empress")
				.namesMaleFemale("Dark Slime Emperor", "Dark Slime Empress")
				.requirePerk(PerkLib.DarkSlimeEmpressCore)
				.requirePerk(PerkLib.TransformationImmunity2)
				.buffs({
					"tou.mult": +2.75,
					"spe.mult": -0.95,
					"int.mult": +3.4,
					"lib.mult": +1.85
				})
				.end();
	}
}
}
