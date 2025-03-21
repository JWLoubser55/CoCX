/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.Scenes.SceneLib;
	
	public class GolemsImproved extends AbstractGolem
	{
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(3);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand2();
					if (choiceP == 2) overhandSmash2();
				}
				else {
					if (this.HPRatio() < 0.6) {
						var choice2:Number = rand(5);
						if (choice2 < 3) eAttack();
						if (choice2 == 3) backhand2();
						if (choice2 == 4) overhandSmash2();
					}
					else if (this.HPRatio() < 0.8) {
						var choice1:Number = rand(4);
						if (choice1 < 3) eAttack();
						if (choice1 == 3) backhand2();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
			else SceneLib.campMakeWinions.postFightGolemOptions4();
		}
		
		public function GolemsImproved() 
		{
			super(true);
			this.a = "the ";
			this.short = "improved golems";
			this.imageName = "improved golems";
			this.long = "You're currently improved fighting golems. They're all around seven and half feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(260, 200, 140, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 90;
			this.drop = NO_DROP;
			this.level = 42;
			this.bonusHP = 700;
			this.additionalXP = 700;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 75;
			this.armorName = "stone";
			this.armorDef = 75;
			this.armorMDef = 15;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}