package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class MyconidRace extends Race {

	public static const MyconidSkinColors:Array = ["ghostly pale", "light", "ghostly white"];
	public static const MyconidHairColors:Array = ["silver white", "ghostly white"];
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

	public function MyconidRace(id:int) {
		super("Matango", id, RaceBody);
		mutationThreshold = 6;
	}

	public override function setup():void {
		addScores()
				.skinPlainOnly(+1)
				.skinBaseAdj(NOT("slippery"), 0, -1)
				.hairType(Hair.MYCONID, +1)
				.hairColor1(ANY(MyconidHairColors), +1)
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.HUMAN, +1)
				.earType(Ears.HUMAN, +1)
				.tongueType(Tongue.HUMAN, +1)
				.hornType(Horns.SHROOM_HEADCAP, +1, -1000)
				.customRequirement("","shroom headcap size > 1",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 2
						}, +1)
				.customRequirement("","shroom headcap size > 2",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 4
						}, +1)
				.customRequirement("","shroom headcap size > 3",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 6
						}, +1)
				.customRequirement("","shroom headcap size > 4",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 8
						}, +1)
				.customRequirement("","shroom headcap size > 5",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 10
						}, +1)
				.customRequirement("","shroom headcap size > 6",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 12
						}, +1)
				.customRequirement("","shroom headcap size > 7",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 14
						}, +1)
				.armType(Arms.SHROOM_ARMS, +1)
				.legType(LowerBody.SHROOM_SKIRT, +2)
				.rearType(RearBody.BRA_AND_NECK, +1)
				.noWings(+2)
				.noTail(+1)
				.tone(LESS_THAN(10), +1)
				.skinColor1(ANY(MyconidSkinColors), +1)
				.biggestTitSize(GREATER_THAN(3), +1)
				.vaginaType(VaginaClass.SHROOM, +1)
				.hasCockOfType(CockTypesEnum.SHROOM, +1)
				.customRequirement("","clit bigger then 9 inch",
						function (body:BodyData):Boolean {
							return body.player.hasVagina()? body.player.clitLength >= 10 : false;
						}, +1)
				.customRequirement("","glowing nipples",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingNipples);
						}, +1)
				.customRequirement("","glowing asshole",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
						}, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);

		buildTier(16, "Matango")
                .requireHornType(Horns.SHROOM_HEADCAP)
				.buffs({
					"tou.mult": +2.40,
					"int.mult": -1.00,
					"lib.mult": +1.50,
					"sens": +50
				})
				.end();

		buildTier(26, "Myconid")
                .requireHornType(Horns.SHROOM_HEADCAP)
				.buffs({
					"tou.mult": +3.40,
					"int.mult": -0.50,
					"lib.mult": +2.00,
					"sens": +100
				})
				.end();

		buildTier(36, "Fungal Queen")
                .requireHornType(Horns.SHROOM_HEADCAP)
				.buffs({
					"tou.mult": +4.40,
					"lib.mult": +3.00,
					"sens": +200
				})
				.end();
	}
}
}
