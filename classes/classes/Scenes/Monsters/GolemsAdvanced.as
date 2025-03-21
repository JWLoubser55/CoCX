/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.Scenes.SceneLib;
	
	public class GolemsAdvanced extends AbstractGolem
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
			else SceneLib.campMakeWinions.postFightGolemOptions3();
		}
		
		public function GolemsAdvanced() 
		{
			super(true);
			this.a = "the ";
			this.short = "advanced golems";
			this.imageName = "advanced golems";
			this.long = "You're currently fighting advanced golems. They're all around eight feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(320, 250, 180, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 96;
			this.drop = NO_DROP;
			this.level = 51;
			this.bonusHP = 900;
			this.additionalXP = 900;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 100;
			this.armorName = "stone";
			this.armorDef = 100;
			this.armorMDef = 20;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}