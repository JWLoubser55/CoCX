/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DefiledRavine
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class CowSuccubus extends AbstractSuccubus
	{
		
		public function cowsuccubusMilkSpray():void {
			outputText("\"<i>How about a taste?</i>\"  The succubus asks, pressing her tits together.  Before you can reply, a veritable jet of milk sprays in your direction!\n");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) {
				outputText("With your trained reflexes, you manage to duck and roll, narrowly avoiding getting sprayed with milk.");
				outputText("\n\n\"<i>Such a waste.</i>\"  The succubus pouts.");
				player.takeLustDamage(30 + rand(30), true);
			}
			//Hit:
			else {
				outputText("All you manage to do is cover your face; the rest of you, however, gets completely soaked in the demon's corrupted milk.  Looking down at yourself, you realize that you are panting, and the places where the milk splashed your [skin] begin to heat up.");
				player.takeLustDamage(75 + rand(75), true);
			}
		}

		public function cowsuccubusTease():void {
			if (rand(4) == 0) outputText("Turning around, the succubus begins to bounce her rather round derriere in your direction, the cheeks lewdly clapping together with each change in direction, exposing her dark anal star and juicy snatch, literally gushing forth a stream of lubricants.  Her eyes glow with faint, purple light as she whispers, \"<i>Don't you just want to... slide on in?</i>\"");
			else if (rand(3) == 0) outputText("The succubus squeezes her spotted, sweat-oiled breasts together, squirting out trickles of fresh, creamy, succubi milk.  Bending down, she laps at her own bounty, taking to meet your eyes, her own glowing violet.  You can feel her next words as much as hear them, reaching into your brain and stirring a familiar heat in your loins.  \"<i>Giving in would mean pleasure unending, my dear champion.</i>\"");
			else if (rand(2) == 0) outputText("The succubus turns slightly and slowly bends over, sliding her hands down the sides of her milk laden jugs. \"<i>Mmm, would you help a poor girl relax? These things need some attention,</i>\" she says with a lust filled moan as her hands reach her multitude of nipples.");
			else outputText("The succubus leans forwards holding her tits, while wrapping her fingers around her nipples.  \"<i>My boobs are soo full.  Would you like to help me drain them?</i>\" she says with a husky voice.");
			player.takeLustDamage(20 + rand(20), true);
		}
		
		override protected function performCombatAction():void {
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) {
				if (rand(2) == 0) whipAttack();
				else eAttack();
			}
			else {
				var choice:Number = rand(3);
				if (choice == 0) {
					if (rand(2) == 0) whipAttack();
					else eAttack();
				}
				if (choice == 1) {
					if (rand(2) == 0) cowsuccubusTease();
					else seduceAttack();
				}
				if (choice == 2) cowsuccubusMilkSpray();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) SceneLib.defiledravine.demonScene.defeatFeralCowSuccubus();
			else SceneLib.defiledravine.demonScene.defeatCowSuccubus();
		}
		
		public function CowSuccubus()
		{
			if (player.hasStatusEffect(StatusEffects.FeralDemon)) {
				this.short = "feral cow succubus";
				this.long = "You are fighting a cow-like succubus.  She stands about seven feet tall and is voluptuous, with breasts size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into a hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her left eye.  She's using a succubi whip as a weapon.";
				createBreastRow(Appearance.breastCupInverse("K"));
				this.hips.type = Hips.RATING_AMPLE;
				this.butt.type = Butt.RATING_AVERAGE + 1;
				initStrTouSpeInte(585, 150, 540, 240);
				initWisLibSensCor(120, 150, 60, 100);
				this.weaponAttack = 312;
				this.armorDef = 250;
				this.armorMDef = 125;
				this.bonusHP = 1000;
				this.bonusLust = 275;
				this.level = 65;
				this.gems = rand(40)+55;
				this.additionalXP = 125;
				this.createPerk(PerkLib.OverMaxHP, 65, 0, 0, 0);
			}
			else {
				this.short = "cow succubus";
				this.long = "You are fighting a cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts two times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her left eye.  She's using a succubi whip as a weapon.";
				this.magicuser = true;
				createBreastRow(Appearance.breastCupInverse("RR"));
				this.hips.type = Hips.RATING_CURVY;
				this.butt.type = Butt.RATING_LARGE + 1;
				initStrTouSpeInte(390, 300, 540, 240);
				initWisLibSensCor(240, 300, 120, 100);
				this.weaponAttack = 156;
				this.armorDef = 500;
				this.armorMDef = 250;
				this.bonusHP = 2000;
				this.bonusLust = 481;
				this.level = 61;
				this.gems = rand(40)+50;
				this.additionalXP = 100;
				this.createPerk(PerkLib.OverMaxHP, 61, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "milkysuccubus";
			// this.plural = false;
			this.flyer = true;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 100, 0, 0, 0);
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_SLIMY;
			this.tallness = 84;
			this.bodyColor = "blue";
			this.hairColor = "black";
			this.hairLength = 13;
			this.weaponName = "succubi whip";
			this.weaponVerb="sexy whipping";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.lust = 40;
			this.lustVuln = .3;
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 2;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.tailType = Tail.DEMONIC;
			//this.special1 = kissAttack;	- potem sprawdzić czy bdą przydatne i zatrzymane czy combat ai dla moba je zastąpi
			//this.special2 = seduceAttack;
			//this.special3 = whipAttack;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(weapons.SUCWHIP, 2).
					//add(consumables., 6).	- for lacta bovina milk (like mino cum)
					add(consumables.LABOVA_, 8).
					add(consumables.SUCMILK, 10);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
