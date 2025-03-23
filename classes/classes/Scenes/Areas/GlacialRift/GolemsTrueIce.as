/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.Scenes.Monsters.AbstractGolem;
	import classes.Scenes.SceneLib;

public class GolemsTrueIce extends AbstractGolem
	{
		public function iceSpikes():void {
			var damage:Number = (eBaseIntelligenceDamage() + eBaseWisdomDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("At the palm of their hands form ice spikes that they then shoot towards you! ");
			player.takeIceDamage(damage, true);
			player.takeIceDamage(damage, true);
			player.takeIceDamage(damage, true);
			player.takeIceDamage(damage, true);
			player.takeIceDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand2(1);
					if (choiceP == 2) overhandSmash2(1);
					if (choiceP == 3) iceSpikes();
				}
				else {
					if (this.HPRatio() < 0.6) {
						var choice2:Number = rand(6);
						if (choice2 < 3) eAttack();
						if (choice2 == 3) backhand2(1);
						if (choice2 == 4) overhandSmash2(1);
						if (choice2 == 5) iceSpikes();
					}
					else if (this.HPRatio() < 0.8) {
						var choice1:Number = rand(5);
						if (choice1 < 3) eAttack();
						if (choice1 == 3) backhand2(1);
						if (choice1 == 4) iceSpikes();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.campMakeWinions.postFightGolemOptions2();
		}
		
		public function GolemsTrueIce() 
		{
			super(false);
			this.a = "the ";
			this.short = "true ice golems";
			this.imageName = "true ice golems";
			this.long = "You're currently fighting true ice golems. They're all around ten feet tall without any sexual characteristics, their body shaped like gorilla, with bird-like wings, covered with thick ice and using bare fists to smash enemies.";
			this.plural = true;
			initStrTouSpeInte(525, 505, 460, 20);
			initWisLibSensCor(20, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 120;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 78;
			this.bonusHP = 7500;
			this.bonusLust = 98;
			this.additionalXP = 1000;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 175;
			this.armorName = "ice armor";
			this.armorDef = 360;
			this.armorMDef = 360;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}