/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.LightlessReach 
{
	import classes.*;
	import classes.Scenes.Monsters.AbstractGolem;
	import classes.Scenes.SceneLib;

public class GolemTrueDarkness extends AbstractGolem
	{
		public function darkShards():void {
			var damage:Number = (eBaseIntelligenceDamage() + eBaseWisdomDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("At the palm of golem hand form dark shard that then shots toward you! ");
			player.takeDarknessDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand1(3);
					if (choiceP == 2) overhandSmash1(3);
					if (choiceP == 3) darkShards();
				}
				else {
					if (this.HPRatio() < 0.6) {
						var choice2:Number = rand(6);
						if (choice2 < 3) eAttack();
						if (choice2 == 3) backhand1(3);
						if (choice2 == 4) overhandSmash1(3);
						if (choice2 == 5) darkShards();
					}
					else if (this.HPRatio() < 0.8) {
						var choice1:Number = rand(5);
						if (choice1 < 3) eAttack();
						if (choice1 == 3) backhand1(3);
						if (choice1 == 4) darkShards();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.campMakeWinions.postFightGolemOptions1();
		}
		
		public function GolemTrueDarkness() 
		{
			super(false);
			this.a = "the ";
			this.short = "true darkness golem";
			this.imageName = "true darkness golem";
			this.long = "You're currently fighting true darkness golem. It's over twenty four feet tall without any sexual characteristics, it body shaped like gigantic anubis, with bat-like wings, covered with thick layer of darkness and using huge fists to smash enemies.";
			//this.plural = true;
			initStrTouSpeInte(505, 485, 365, 20);
			initWisLibSensCor(20, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 290;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 76;
			this.bonusHP = 6000;
			this.bonusLust = 96;
			this.additionalXP = 900;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 175;
			this.armorName = "darkness armor";
			this.armorDef = 210;
			this.armorMDef = 210;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}