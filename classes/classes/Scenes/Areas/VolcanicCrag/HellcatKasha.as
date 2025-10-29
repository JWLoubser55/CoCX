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
		public var spellCostArouse:int = 6;
		
		public function castArouse():void {
			outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
			var lustDamage:int = inte + rand(100);
			player.takeLustDamage(lustDamage);
			mana -= spellCostArouse;
		}
		
		public function hellcatKashaFireball():void
		{
			var damage:int = (inte * 6) + rand(250);
			damage = Math.round(damage);
			outputText("Kasha holds out her hand, a fireball forming in her palm. She launches the ball of molten heat towards you.");
			player.takeFireDamage(damage, true);
		}
		
		public function hellcatKashaFlameWhip():void
		{
			outputText("The kasha swing her whip and burn you with its unholy fire both pleasurable and painful before suddenly wrapping around your leg causing you to fall over as the chariot pulls you around the volcanic landscape. ");
			player.createStatusEffect(StatusEffects.PlayerBoundPhysical, 0, 1, 0, 0);
			player.createStatusEffect(StatusEffects.KashaCapture, 0, 0, 0, 0);
			flameWhipDmgrepeat();
		}
		public function hellcatKashaFlameWhipStruggle():void
		{
			clearOutput();
			outputText("You try and unwrap the whip from your legs ");
			if (SceneLib.combat.struggleCentralizedCheck()) {
				outputText("and manage to break free");
				player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
				player.removeStatusEffect(StatusEffects.KashaCapture);
				createStatusEffect(StatusEffects.AbilityCooldownGrapple, 3, 0, 0, 0);
			}
			else {
				outputText("but your efforts are too far too few");
				player.addStatusValue(StatusEffects.PlayerBoundPhysical,1,1);
				flameWhipDmgrepeat();
			}
			outputText(".");
		}
		public function hellcatKashaFlameWhipWait():void
		{
			clearOutput();
			outputText("The kasha whip burns you as you are being carted all over the place. Furthermore its progressing up your body like a coiling snake your bind improving each seconds. ");
			player.addStatusValue(StatusEffects.PlayerBoundPhysical,1,1);
			flameWhipDmgrepeat();
		}
		private function flameWhipDmgrepeat():void {
			var physdamage:Number = 0;
			physdamage += eBaseDamage();
			player.takePhysDamage(physdamage, true);
			var firedamage:int = (inte * 1.5) + rand(50);
			firedamage = Math.round(firedamage);
			player.takeFireDamage(firedamage, true);
			if (!player.immuneToBurn()) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(3),0.05,0,0);
			}
			var lustDamage:int = inte + rand(100);
			player.takeLustDamage(lustDamage);
		}
		
		public function hellcatkashaFelineCurse():void
		{
			outputText("Kasha incants a curse. Your head reels as the world around you appears to expand. You fall, unable to balance as your [legs] give way. After a few seconds, you open your eyes, trying to rub them...but your arm isn't moving properly. You look down and see...fuzzy paws. Cat paws. To your growing horror, you realize what she did. You're now a housecat!");
			player.createStatusEffect(StatusEffects.Polymorphed, 3, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(4);
			switch (choice) {
				case 0:
					if ((mana - spellCostArouse) >= 0) castArouse();
					else eAttack();
					break;
				case 1:
					hellcatKashaFireball();
					break;
				case 2:
					if (hasStatusEffect(StatusEffects.AbilityCooldownGrapple)) hellcatKashaFireball();
					else hellcatKashaFlameWhip();
					break;
				case 3:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hellcatkashaFelineCurse();
					else eAttack();
					break;
				default:
					eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedHellCatKasha();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedByHellCatKasha();
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
			this.tallness = 7*12+8;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.tailType = Tail.BURNING;
			this.bodyColor = "ashen";
			this.hairColor = "midnight black";
			this.hairLength = 13;
			initStrTouSpeInte(170, 211, 376, 720);
			initWisLibSensCor(300, 390, 120, 70);
			this.weaponName = "claws";
			this.weaponVerb="slash";
			this.weaponAttack = 15;
			this.armorName = "hooded cape";
			this.armorDef = 200;
			this.armorMDef = 700;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 888;
			this.bonusLust = 597;
			this.lust = 20;
			this.lustVuln = .1;
			this.level = 87;
			this.gems = rand(50) + 150;
			this.drop = new WeightedDrop().addMany(5,
					consumables.W_FRUIT,
					consumables.G_FRUIT,
					weapons.H_WAND)
					.add(shields.NEKONOM, 1);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyChampionType, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.Flying,50,0,0,0);
			checkMonster();
		}
	}
}
