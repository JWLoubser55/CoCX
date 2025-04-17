/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Cliffs 
{
	import classes.*;
	import classes.Scenes.Monsters.AbstractGolem;
	import classes.Scenes.SceneLib;
	
	public class GolemTrueLightning extends AbstractGolem
	{
		public function thunderBolts():void {
			var damage:Number = (eBaseIntelligenceDamage() + eBaseWisdomDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("At the palm of it hand golem form thunderbolt and then throws towards you! ");
			damage = player.takeLightningDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand1(4);
					if (choiceP == 2) overhandSmash1(4);
					if (choiceP == 3) thunderBolts();
				}
				else {
					if (this.HPRatio() < 0.6) {
						var choice2:Number = rand(6);
						if (choice2 < 3) eAttack();
						if (choice2 == 3) backhand1(4);
						if (choice2 == 4) overhandSmash1(4);
						if (choice2 == 5) thunderBolts();
					}
					else if (this.HPRatio() < 0.8) {
						var choice1:Number = rand(5);
						if (choice1 < 3) eAttack();
						if (choice1 == 3) backhand1(4);
						if (choice1 == 4) thunderBolts();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.campMakeWinions.postFightGolemOptions1();
		}
		
		public function GolemTrueLightning() 
		{
			super(false);
			this.a = "the ";
			this.short = "true lightning golem";
			this.imageName = "true lightning golem";
			this.long = "You're currently fighting a true lightning golem. It’s over twenty-four feet tall, without any sexual characteristics. Its body is shaped like a gigantic sphere with pair of arms and two pairs of bird-like wings, covered by dense layer of electricity and it uses its bare fists to smash enemies.";
			//this.plural = true;
			initStrTouSpeInte(525, 500, 375, 20);
			initWisLibSensCor(20, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 290;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 81;
			this.bonusHP = 6000;
			this.bonusLust = 101;
			this.additionalXP = 900;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 175;
			this.armorName = "electric armor";
			this.armorDef = 210;
			this.armorMDef = 210;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DarknessVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}