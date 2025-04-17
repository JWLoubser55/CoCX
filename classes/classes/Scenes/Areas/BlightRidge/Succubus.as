/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Succubus extends AbstractSuccubus
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) SceneLib.defiledravine.demonScene.defeatFeralSuccubus();
			else SceneLib.defiledravine.demonScene.defeatSuccubus();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (inDungeon) SceneLib.dungeons.ebonlabyrinth.defeatedByStrayDemon();
			else SceneLib.dungeons.factory.doLossSuccubus(false);
		}
		
		public function Succubus()
		{
			if (inDungeon) {
				this.short = "stray succubus";
                var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
                initStrTouSpeInte(240 + 5*mod, 170 + 10*mod, 195 + 10*mod, 180 + 10*mod);
                initWisLibSensCor(180 + 10*mod, 180 + 10*mod, 90 + 8*mod, 100);
                this.weaponAttack = 32 + 3*mod;
                this.armorDef = 36 + 6*mod;
                this.armorMDef = 6 + mod;
                this.bonusHP = 960 + 960*mod;
                this.bonusLust = 332 + 22*mod;
                this.level = 62 + 5*mod;
				this.gems = mod > 20 ? 0 : Math.floor((60 + rand(30)) * Math.exp(0.3*mod));
				this.additionalXP = mod > 20 ? 0 : Math.floor(500 * Math.exp(0.3*mod));
				this.createPerk(PerkLib.OverMaxHP, (62 + 5*mod), 0, 0, 0);
            }
			else if (player.hasStatusEffect(StatusEffects.FeralDemon)) {
				this.short = "feral succubus";
				initStrTouSpeInte(450, 100, 240, 130);
				initWisLibSensCor(130, 130, 60, 100);
				this.weaponAttack = 128;
				this.armorDef = 90;
				this.armorMDef = 15;
				this.bonusHP = 480;
				this.bonusWrath = 480;
				this.bonusLust = 231;
				this.level = 41;
				this.additionalXP = 100;
			    this.gems = rand(30) + 20;
				this.createPerk(PerkLib.OverMaxHP, 41, 0, 0, 0);
			}
			else {
				this.short = "succubus";
				initStrTouSpeInte(300, 200, 240, 260);
				initWisLibSensCor(260, 260, 120, 100);
				this.weaponAttack = 64;
				this.armorDef = 180;
				this.armorMDef = 30;
				this.bonusHP = 960;
				this.bonusLust = 418;
				this.level = 38;
				this.additionalXP = 80;
			    this.gems = rand(30) + 15;
				this.createPerk(PerkLib.OverMaxHP, 38, 0, 0, 0);
			}
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) {
				this.long = "She stands about six feet tall and is moderate voluptuous, her large breasts wobble as she moves.  Her hips flare out into a hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her butt.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.  She's using a leather whip as a weapon.";
				createBreastRow(Appearance.breastCupInverse("C"));
				this.hips.type = Hips.RATING_AMPLE;
				this.butt.type = Butt.RATING_AVERAGE + 1;
				this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			}
			else {
				this.long = "She stands about six feet tall and is hugely voluptuous, her impressive breasts wobble delightfully as she moves.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.  She's using a leather whip as a weapon.";
				this.magicuser = true;
				createBreastRow(Appearance.breastCupInverse("DD"));
				this.hips.type = Hips.RATING_CURVY;
				this.butt.type = Butt.RATING_LARGE + 1;
				this.special1 = kissAttack;
				this.special2 = seduceAttack;
				this.special3 = whipAttack;
			}
			this.a = "the ";
			this.imageName = "succubus";
			// this.plural = false;
			this.flyer = true;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			this.tallness = 72;
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.bodyColor = "blue";
			this.hairColor = "black";
			this.hairLength = 13;
			this.weaponName = "whip";
			this.weaponVerb="whipping";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.lust = 30;
			this.lustVuln = .5;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(weapons.WHIP, 2).
					add(consumables.SUCMILK,12);
			this.wings.type = Wings.BAT_LIKE_LARGE;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
