/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.Scenes.SceneLib;
	
	public class GolemsBasic extends AbstractGolem
	{
		override protected function performCombatAction():void
		{
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
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
			else SceneLib.campMakeWinions.postFightGolemOptions3();
		}
		
		public function GolemsBasic() 
		{
			super(true);
			this.a = "the ";
			this.short = "basic golems";
			this.imageName = "basic golems";
			this.long = "You're currently fighting basic golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(240, 180, 120, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 84;
			this.drop = NO_DROP;
			this.level = 33;
			this.bonusHP = 500;
			this.additionalXP = 500;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 50;
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