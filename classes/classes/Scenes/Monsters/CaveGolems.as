/**
 * ...
 * @author Liadri (mostly)
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.internals.WeightedDrop;
	
	public class CaveGolems extends AbstractGolem
	{
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP < 2) eAttack();
					if (choiceP > 1) backhand1();
				}
				else {
					if (this.HPRatio() < 0.75) {
						var choice:Number = rand(4);
						if (choice < 3) eAttack();
						if (choice == 3) backhand1();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.campMakeWinions.postFightGolemOptions5();
		}
		
		public function CaveGolems() 
		{
			super(false);
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 20) {
				this.short = "gem golem";
				this.imageName = "gem golem";
				this.long = "You're currently fighting the gem golem. It's six feet tall, without any sexual characteristics. It has a gembody covered in cracks and has no weapons, using its grey gem fists to smash enemies.";
				initStrTouSpeInte(500, 500, 250, 20);
				initWisLibSensCor(20, 10, 10, 0);
				this.tallness = 72;
				this.level = 66;
				this.bonusHP = 1000;
				this.bonusLust = 86;
				this.additionalXP = 250;
				this.weaponName = "gem fists";
				this.weaponAttack = 100;
				this.armorName = "gem";
				this.armorDef = 250;
				this.armorMDef = 100;
				this.gems = rand(50) + 500;
				this.drop = new WeightedDrop()
					.add(useables.AMEGEM, 1)
					.add(useables.EMDGEM, 1)
					.add(useables.RBYGEM, 1)
					.add(useables.SAPPGEM, 1)
					.add(useables.TPAZGEM, 1)
					.add(null, 5);
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 21) {
				this.short = "adamantine golem";
				this.imageName = "adamantine golem";
				this.long = "You're currently fighting the adamantine golem. It's six feet tall, without any sexual characteristics. It has a adamantine body and has no weapons, using its grey metalic fists to smash enemies.";
				initStrTouSpeInte(700, 700, 350, 20);
				initWisLibSensCor(20, 10, 10, 0);
				this.tallness = 72;
				this.level = 89;
				this.bonusHP = 1200;
				this.bonusLust = 109;
				this.additionalXP = 350;
				this.weaponName = "adamantine fists";
				this.weaponAttack = 130;
				this.armorName = "adamantine";
				this.armorDef = 100;
				this.armorMDef = 100;
				this.gems = rand(50) + 100;
				this.drop = new WeightedDrop()
					.add(useables.TIN_ORE, 1)
					.add(useables.COP_ORE, 1)
					.add(useables.IRONORE, 1)
					.add(useables.MOONSTO, 1)
					.add(useables.SKYMETA, 1)
					.add(null, 5);
				this.createPerk(PerkLib.PhysicalDamageResistance, 0, 0, 0, 0);
			}
			this.a = "the ";
			this.weaponVerb = "smash";
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}