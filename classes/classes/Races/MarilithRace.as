package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Races;
import classes.VaginaClass;

public class MarilithRace extends Race {
    public static const MarilithScaleColors:/*String*/Array = ["fiendish dark pink", "midnight purple", "green"];
	public static const MarilithHairColors:/*String*/Array = ["fiendish pink"];
    public static const MarilithSkinColors:/*String*/Array = ["fiendish blue"];
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
	
	public function MarilithRace(id:int) {
		super("Marilith", id, []);//RaceBody);
	}
	
	public override function setup():void {
        addScores()
				.hornType(Horns.DEMON, +1)
				.eyeType(Eyes.MARILITH, +2)
				.eyeColor("yellow", +1)
				.hairType(Hair.NORMAL, +1)
				.hairColor1(ANY(MarilithHairColors), +1)
				.skinColor1("fiendish blue", +1)
				.scaleColor1(ANY(MarilithScaleColors), +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.earType(Ears.SNAKE, +1)
				.tongueType(Tongue.SNAKE, +1)
                .armType(Arms.MARILITH, +2, -1000)
				.isNaga(+3, -1000)
				.noWings(+4)
				.skinBasePattern(Skin.PATTERN_DEMONIC_PLEASURE_RUNE, +1)
				.femininity(GREATER_THAN(70), +1)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(70), +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.player.racialScore(Races.NAGA) > 10
									|| GorgonRace.isGorgonLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| HydraRace.isHydraLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| ApophisRace.isApophisLike(body));
						}, 0, -1000)
				.hasPerk(PerkLib.DemonicLethicite, +1)
				.hasPerk(PerkLib.Soulless, +4)
				.hasPerk(PerkLib.GOBXChemical, -1000);
				
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.BlackHeartIM);
		addMutation(IMutationsLib.FiendishMetabolismIM);

		buildTier(18, "marilith")
				.buffs({
					"str.mult": +1.00,
					"spe.mult": +1.20,
					"int.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +50
				})
				.end();
		
		buildTier(24, "marilith blademaster")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"str.mult": +1.30,
					"spe.mult": +1.50,
					"int.mult": +0.80,
					"lib.mult": +0.80,
					"sens": +80
				})
				.end();
		
		buildTier(40, "marilith sword princess")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"str.mult": +2.00,
					"spe.mult": +2.50,
					"int.mult": +1.00,
					"lib.mult": +1.50,
					"sens": +100
				})
				.end();
    }
	
	public static function isMarilithLike(body:BodyData):Boolean {
		return body.eyeType == Eyes.MARILITH
				|| body.armType == Arms.MARILITH;
	}
}
}
