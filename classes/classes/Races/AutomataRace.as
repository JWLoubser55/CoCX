package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class AutomataRace extends Race {
    public static const AutomataHairColors:/*String*/Array = ["neon pink","neon blue","neon green","neon purple"];
	public static const AutomataSkinColors:/*String*/Array = ["steel gray","synthetic white","pale white"];
	public static const AutomataEyesColors:/*String*/Array = ["neon red","neon blue","neon green","neon purple"];
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

	public function AutomataRace(id:int) {
		super("Automata", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.hairType(Hair.SYNTHETIC, +1)
				.hornType(Horns.HEADSET, +1)
				.antennaeType(Antennae.AUTOMATA, +1)
				.faceType(Face.AUTOMATA, +1)
				.eyeType(Eyes.AUTOMATA, +1)
				.eyeColor(ANY(AutomataEyesColors), +1)
				.earType(ANY(Ears.AUTOMATA_FOX, Ears.AUTOMATA_CAT, Ears.AUTOMATA_BUNNY), +1)
				.tongueType(Tongue.AUTOMATA, +1)
				.hairColor1(ANY(AutomataHairColors), +1)
				.skinBaseType(Skin.STEEL, +1)
				.skinBasePattern(Skin.PATTERN_CIRCUIT_TATTOO, +1)
				.skinColor1(ANY(AutomataSkinColors), +1)
				.armType(Arms.MECHANICAL_DOLL_ARMS, +1)
				.legType(LowerBody.MECHANICAL_DOLL_LEGS, +1)
				.tailType(Tail.AUTOMATA_TAIL_CABLE, +1)
				.wingType(Wings.JET_THRUSTERS, +4)
				.rearType(RearBody.SERIAL_CODE, +1)
				.customRequirement("","glowing nipples or asshole",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingNipples) || body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
						}, +1)
				.cockOrVaginaOfType(CockTypesEnum.AUTOMATA, VaginaClass.AUTOMATA, +1)
				//.hasPerk(PerkLib., +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.SoulCoreIM, +3);
		addMutation(IMutationsLib.LivingWeaponIM, +3);
		
		buildTier(23, "Automata")
				.buffs({
					"str.mult": +2.50,
					"tou.mult": +2.50,
					"spe.mult": +2.50,
					"int.mult": +2.50,
					"wis.mult": -0.65,
					"lib.mult": +2.50,
					"sens": +150
				})
				.end();
		
		buildTier(32, "Automata Ace Unit")
				.buffs({
					"str.mult": +3.25,
					"tou.mult": +3.25,
					"spe.mult": +3.25,
					"int.mult": +3.25,
					"wis.mult": -0.80,
					"lib.mult": +3.25,
					"sens": +150
				})
				.end();
	}
}
}
