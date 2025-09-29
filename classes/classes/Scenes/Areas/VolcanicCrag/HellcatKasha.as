/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.VolcanicCrag 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class HellcatKasha extends Monster
	{
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedHellCat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedByHellCat();
		}
		
		public function HellcatKasha() 
		{
			this.a = "the ";
			this.short = "kasha";
			this.imageName = "kasha";
			this.long = "You are fighting a kasha, a more powerful breed of hellcat. Just like a hellcat she would look like a standard catgirl if not for her ashen skin, fiery hair. What sets her appart from her weaker sisters is that pair of blazing tail up her back, a symbol of her mystical powers. Fire seeps up from the side corner of her ember-like black sclera eyes which glow with the dark promise of hellish passion. You though hellcats heat was a thing already but that girl is one step worse, her heat is so bad you can see her pussy drench the ground beneath her in her passage. Aside from her black hooded cape which flies about as she rides her chariot at high speed, she wears nothing to hide her modesty, displaying her DD cup breast, slick pussy and hardening cat cock for you to enjoy.";
			// this.plural = false;
			this.createCock(12,3,CockTypesEnum.CAT);
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.tailType = Tail.BURNING;
			this.bodyColor = "ashen";
			this.hairColor = "midnight black";
			this.hairLength = 13;
			initStrTouSpeInte(140, 140, 300, 630);
			initWisLibSensCor(210, 290, 100, 70);
			this.weaponName = "claws";
			this.weaponVerb="slash";
			this.weaponAttack = 10;
			this.armorName = "hooded cape";
			this.armorDef = 30;
			this.armorMDef = 500;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 777;
			this.bonusLust = 460;
			this.lust = 20;
			this.lustVuln = .1;
			this.level = 70;
			this.gems = rand(55) + 140;
			this.drop = new WeightedDrop().addMany(5,
					consumables.W_FRUIT,
					weapons.H_WAND,
					null)
					.add(shields.NEKONOM, 1);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
