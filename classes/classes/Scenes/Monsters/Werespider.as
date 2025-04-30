/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Swamp.AbstractSpiderMorph;
import classes.Stats.Buff;
import classes.Scenes.SceneLib;
import classes.internals.*;

import coc.view.CoCButton;

	public class Werespider extends AbstractSpiderMorph
	{
		private var _biteCounter:int = 0;
		private var _sonicScreamCooldown:int = 0;

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.MonsterInvisible)) {
				if (player.hasStatusEffect(StatusEffects.KnowsBlind) && ((!player.hasPerk(PerkLib.BloodMage) && player.mana >= 30) || (player.hasStatusEffect(StatusEffects.BloodMage) && ((player.HP + 30) > (player.minHP() + 30))))) {
					btnSpecial1.show("Blind", dispellDarkness1);
				}
				if (player.hasStatusEffect(StatusEffects.KnowsSunrise) && ((!player.hasStatusEffect(StatusEffects.BloodCultivator) && player.soulforce >= 400) || (player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP + 400) > (player.minHP() + 400))))) {
					btnSpecial2.show("Sunrise", dispellDarkness2);
				}
			}
		}
		
		public function dispellDarkness1():void {
			clearOutput();
			outputText("You glare at point near you.  A bright flash erupts there!\n");
			dispellDarkness(1);
		}
		public function dispellDarkness2():void {
			clearOutput();
			outputText("You point finger at spot near you.  A miniature sun appears there!\n");
			dispellDarkness(2);
		}
		public function dispellDarkness(choice:Number):void {
			outputText("The light counters the smothering darkness, breaking the spell and bringing light back the area. [Themonster], who was about to viciously attack you from behind, swiftly backs out of range and flies off.\n\n");
			outputText("\"<i>Umph you broke free… No matter, your defeat is but a matter of time.</i>\"\n");
			createStatusEffect(StatusEffects.Blind, Math.min(2 + player.inte / 20, 10), 0, 0, 0);
			player.removeStatusEffect(StatusEffects.MonsterInvisible);
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1) || statusEffectv1(StatusEffects.AbilityCooldown1) < 3) {
				removeStatusEffect(StatusEffects.AbilityCooldown1);
				createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			}
			EngineCore.doNext(SceneLib.combat.combatMenu);
			if (choice == 1) {
				if (game.player.hasStatusEffect(StatusEffects.BloodMage)) game.player.HP -= 30;
				else game.player.mana -= 30;
				flags[kFLAGS.SPELLS_CAST]++;
				SceneLib.combat.spellPerkUnlock();
			}
			if (choice == 2) {
				if (game.player.hasStatusEffect(StatusEffects.BloodCultivator)) game.player.HP -= 400;
				else game.player.soulforce -= 400;
			}
			EngineCore.statScreenRefresh();
            SceneLib.combat.enemyAIImpl();
		}
		
		public function werespiderBite():void {
			if (player.isGargoyle()) {
				outputText("[Themonster] tries to bite you, but quickly steps back, holding a hand to her mouth with a surprised yelp of clear pain. You smirk, amused by her stupidity, did she seriously try to bite your stone skin?");
				takePhysDamage(maxHP() * .1);
			} else if (player.isAlraune()) {
				outputText("[Themonster] tries to bite you but, just as her fang pierce your skin, she shoves you off and starts spitting."
					+ "\n\n"
					+ "\"<i>Your blood tastes like sap and flower nectar. How disgusting! How dare you bear such vile ichors.</i>\""
					+ "\n\n"
					+ "Should you be offended by her reaction? You should be grateful that plant sap is not her favorite.");
				takePhysDamage(10);
			} else {
				addHP(maxHP() * .05);
				var dam:int = this.str * 5;
				for (var i:int = 0; i < _biteCounter; i++) {
					dam += dam * .10;
				}
				_biteCounter++;
				outputText("The werespider bites into your neck and begins drinking her fill. The loud slurping noises she’s exuding is hardly a pleasant noise for such an intimate act. Weirdly enough you feel aroused from this despite the pain.");
				if (silly()) outputText(" You masochist, you.");
				dam = Math.round(dam);
				player.takePhysDamage(dam);
				player.takeLustDamage(10 + rand(9), true);
				if (!player.hasStatusEffect(StatusEffects.AlterBindScroll3)) {
					var drain:Number = Math.round(player.touStat.max * 0.05);
					player.saveHPRatio();
					player.buff("Bat bites").addStats({"tou":-drain}).withText("Bat bites!").combatPermanent();
					player.restoreHPRatio();
					showStatDown( 'tou' );
					if (player.tou <= 1) {
						doNext(SceneLib.combat.endHpLoss);
						return;
					}
				}
			}
		}
		
		private function werespiderSonicScream():void {
			var damage:Number = 0;
			damage += inteligencescalingbonus()+eBaseToughnessDamage()+this.lib;
			damage = Math.round(damage);
			outputText("She suddenly lets out an agonising screech which echoes through the entire corridor, forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts. ");
			player.takePhysDamage(damage);
			if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			outputText("\n\n");
			_sonicScreamCooldown = 10;
		}
		
		private function werespiderPerfectDark():void {
			outputText("\"<i>Let us see how thou fight without this precious light of yours!</i>\"\n\n");
            outputText("[Themonster] lands, opening her all arms wide as all light is suddenly sucked in within, leaving you in complete darkness. You can’t see your own weapon, let alone your batty adversary. There is no way you can fight a foe this agile in magical darkness. You’ll need to light the place up to fight properly!");
			player.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 15, 0, 0, 0);
			removeStatusEffect(StatusEffects.Blind);
		}
		
		override protected function performCombatAction():void
		{
			if (_sonicScreamCooldown > 0) {
				_sonicScreamCooldown--;
			}
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				player.removeStatusEffect(StatusEffects.MonsterInvisible);
				werespiderPerfectDark();
			}
			if (player.statStore.hasBuff("FoxflamePelt")) {
				player.removeStatusEffect(StatusEffects.MonsterInvisible);
			}
			var choice:Number = rand(3);
			if (choice == 0) {
				if (player.buff("Web").isPresent()) werespiderBite();
				else spiderMorphWebAttack();
			}
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.MonsterInvisible) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) werespiderPerfectDark();
				else {
					if (player.hasStatusEffect(StatusEffects.WebSilence)) {
						createStatusEffect(StatusEffects.Attacks, 4, 0, 0, 0);
						eAttack();
					}
					else spiderSilence();
				}
			}
			if (choice == 2) {
				if (_sonicScreamCooldown == 0) werespiderSonicScream();
				else {
					if (!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon() && rand(3) == 0) spiderDisarm();
					else werespiderBite();
				}
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.werespiderScene.wonWithWerespider();
		}
		  
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.werespiderScene.lostToWerespider();
		}
		
		public function Werespider() 
		{
			this.a = "the ";
			this.short = "werespider";
			this.imageName = "femalespidermorph";
			this.long = "You are fighting a werespider. She's completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.WERESPIDER;
			this.faceType = Face.SNAKE_FANGS;
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(451, 380, 621, 621);
			initWisLibSensCor(621, 270, 145, 0);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 169;
			this.armorName = "exoskeleton";
			this.armorDef = 600;
			this.armorMDef = 55;
			this.armorValue = 50;
			this.bonusHP = 6000;
			this.bonusLust = 498;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 83;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,2).
					add(consumables.GORGOIL,5);
			checkMonster();
		}
		
	}

}