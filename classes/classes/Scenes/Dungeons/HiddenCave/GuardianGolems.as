/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.AbstractGolem;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GuardianGolems extends AbstractGolem
	{
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				var choice:Number = rand(3);
				if (choice < 2) eAttack();
				if (choice == 2) backhand2();
			}
		}
		
	//	override public function defeated(hpVictory:Boolean):void
	//	{
	//		game.dungeons.hiddencave.cumWitchDefeated();
	//	}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.hiddencave.defeatedByGuardianGolems();
		}
		
		public function GuardianGolems() 
		{
			super(false);
			this.a = "the ";
			this.short = "guardian golems";
			this.imageName = "guardian golems";
			this.long = "You're currently fighting guardian golems. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			this.plural = true;
			this.lustVuln = 0.01;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(40, 50, 40, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 7;
			this.bonusHP = 75;
			this.bonusLust = 27;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 18;
			this.armorName = "cracked stone";
			this.armorDef = 60;
			this.armorMDef = 60;
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}