package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

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
	}
	
	public override function setup():void {
		addScores()
				.hornType(ANY(Horns.RAM, Horns.DRACONIC_X2, Horns.DRACONIC_X4_12_INCH_LONG, Horns.DEMON, Horns.ANTLERS), +1)
				.hornType(Horns.HOLLOW, +2)
				.eyeType(Eyes.HOLLOW, +2)
				.faceType(Face.HOLLOW_MASK, +2)
				.armType(ANY(Arms.HUMAN, Arms.DEVIL, Arms.SATYR, Arms.ONI, Arms.RAIJU, Arms.WENDIGO), +1)
				.armType(Arms.HOLLOW, +2)
				.legType(ANY(LowerBody.HUMAN, LowerBody.HOOFED, LowerBody.KIRIN, LowerBody.ONI, LowerBody.RAIJU, LowerBody.CLOVEN_HOOFED, LowerBody.SCYLLA), +1)
				.legType(LowerBody.HOLLOW, +3)
				.isTaur(+1)
				.tailType(ANY(Tail.SALAMANDER, Tail.DRACONIC), +1)
				.tailType(Tail.HOLLOW, +2)
				.customRequirement("",'Chain of Fate',
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.ChainOfFate) && body.player.statusEffectv1(StatusEffects.ChainOfFate) > 0
						}, +1)
				.customRequirement("",'Dark Sign',
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.DarkSign)
						}, +2)
				.skinBasePattern(Skin.PATTERN_WHITE_BLACK_VEINS, +1)
				.hasPerk(PerkLib.ExanimationI, +6)
				.hasPerk(PerkLib.ExanimationII, +8)
				//.hasPerk(PerkLib.ExanimationII, +10)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.LivingWeaponIM);
		
		buildTier(14, "Demi-Hollow")
				.requirePerk(PerkLib.ExanimationI)
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.75,
					"int.mult": +0.50,
					"wis.mult": +0.75,
					"sens": +40
				})
				.end();
		
		buildTier(24, "Hollow")
				.requirePerk(PerkLib.ExanimationII)
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +1.40,
					"int.mult": +0.80,
					"wis.mult": +1.40,
					"sens": +80
				})
				.end();
		
		buildTier(30, "Vacant")
				.requirePerk(PerkLib.ExanimationIII)
				.buffs({
					"str.mult": +3.00,
					"tou.mult": +5.40,
					"int.mult": +3.00,
					"wis.mult": +5.40,
					"sens": +330
				})
				.end();
	}
}
}
