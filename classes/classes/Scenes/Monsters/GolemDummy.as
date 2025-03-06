/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class GolemDummy extends AbstractGolem
	{
		public function backhand():void {
			outputText("The golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			var damage:Number = int ((str + weaponAttack) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP < 2) eAttack();
					if (choiceP > 1) backhand();
				}
				else {
					if (this.HPRatio() < 0.75) {
						var choice:Number = rand(4);
						if (choice < 3) eAttack();
						if (choice == 3) backhand();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA) && flags[kFLAGS.GOLEM_ENEMY_TYPE] == 2) {
				if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] == 1) flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] = 2;
				else flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] = 1;
				if (flags[kFLAGS.AETHER_SINISTER_EVO] == 0.5) SceneLib.dungeons.riverdungeon.takeAetherSister2();
				else SceneLib.dungeons.riverdungeon.takeAetherSister1();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
				else SceneLib.campMakeWinions.postFightGolemOptions1();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA) && flags[kFLAGS.GOLEM_ENEMY_TYPE] == 2) SceneLib.dungeons.riverdungeon.defeatedByAetherGolem();
			else SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		public function GolemDummy() 
		{
			super(false);
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 0) {
				this.a = "the ";
				this.short = "dummy golem";
				this.imageName = "dummy golem";
				this.long = "You're currently fighting the dummy golem. It's six feet tall, without any sexual characteristics. It has a stone body covered in cracks. It has no weapons, using its grey stone fists to smash enemies.";
				initStrTouSpeInte(100, 100, 50, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 72;
				this.level = 15;
				this.bonusHP = 50;
				this.bonusLust = 35;
				this.additionalXP = 150;
				this.weaponAttack = 20;
				this.armorDef = 50;
				this.armorMDef = 20;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 2) {
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
					this.a = "";
					this.short = "Aether Golem";
					if (flags[kFLAGS.AETHER_SINISTER_EVO] == 0.5) this.long = "You're currently fighting guardian of the first floor - Aether Golem. It's around six feet tall without any sexual characteristics, it stone body covered in cracks, some of them are filled with goo-like substance and wearing gauntlet on it left arm that it use to smash enemies.";
					else this.long = "You're currently fighting guardian of the first floor - Aether Golem. It's around six feet tall without any sexual characteristics, it stone body covered in cracks, some of them are filled with goo-like substance and wearing gauntlet on it right arm that it use to smash enemies.";
					initStrTouSpeInte(75, 75, 75, 30);
					initWisLibSensCor(30, 10, 10, 0);
					this.level = 9;
					this.bonusLust = 29;
					this.weaponAttack = 20;
					this.armorDef = 50;
					this.armorMDef = 15;
					this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
				}
				else {
					this.a = "the ";
					this.short = "improved dummy golem";
					this.long = "You're currently fighting improved dummy golem. It's six and half feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
					initStrTouSpeInte(180, 180, 90, 10);
					initWisLibSensCor(10, 10, 10, 0);
					this.level = 24;
					this.bonusLust = 44;
					this.additionalXP = 240;
					this.weaponAttack = 30;
					this.armorDef = 75;
					this.armorMDef = 30;
				}
				this.bonusHP = 100;
				this.tallness = 78;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 4) {
				this.a = "the ";
				this.short = "advanced dummy golem";
				this.imageName = "advanced dummy golem";
				this.long = "You're currently fighting an advanced dummy golem. It's seven feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(260, 260, 130, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 84;
				this.level = 33;
				this.bonusHP = 150;
				this.bonusLust = 53;
				this.additionalXP = 330;
				this.weaponAttack = 40;
				this.armorDef = 100;
				this.armorMDef = 40;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 6) {
				this.a = "the ";
				this.short = "superior dummy golem";
				this.imageName = "superior dummy golem";
				this.long = "You're currently fighting superior dummy golem. It's seven and half feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(340, 340, 170, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 90;
				this.level = 42;
				this.bonusHP = 200;
				this.bonusLust = 62;
				this.additionalXP = 420;
				this.weaponAttack = 50;
				this.armorDef = 125;
				this.armorMDef = 50;
			}
			this.tallness = 72;
			this.drop = NO_DROP;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.armorName = "cracked stone";
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
