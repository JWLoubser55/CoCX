/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class GolemTrue extends AbstractGolem
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
		
		public function overhandSmash():void {
			outputText("Raising its fist high overhead, the golem swiftly brings it down in a punishing strike!");
			
			var damage:Number = 100 + int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The concussive strike impacts you with bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(3);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand();
					if (choiceP == 2) overhandSmash();
				}
				else {
					if (this.HPRatio() < 0.6) {
						var choice2:Number = rand(5);
						if (choice2 < 3) eAttack();
						if (choice2 == 3) backhand();
						if (choice2 == 4) overhandSmash();
					}
					else if (this.HPRatio() < 0.8) {
						var choice1:Number = rand(4);
						if (choice1 < 3) eAttack();
						if (choice1 == 3) backhand();
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
		
		public function GolemTrue() 
		{
			super(false);
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 8) {
				this.short = "basic true golem";
				this.imageName = "basic true golem";
				this.long = "You're currently fighting basic true golem. It's seven feet tall without any sexual characteristics, it stone body lacking any cracks dummy ones possesed and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(410, 400, 220, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 84;
				this.level = 51;
				this.bonusHP = 400;
				this.bonusLust = 71;
				this.additionalXP = 510;
				this.weaponAttack = 70;
				this.armorDef = 175;
				this.armorMDef = 70;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 10) {
				this.short = "improved true golem";
				this.imageName = "improved true golem";
				this.long = "You're currently fighting improved true golem. It's seven and half feet tall without any sexual characteristics, it stone body lacking any cracks dummy ones possesed and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(490, 480, 260, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 90;
				this.level = 60;
				this.bonusHP = 600;
				this.bonusLust = 80;
				this.additionalXP = 600;
				this.weaponAttack = 90;
				this.armorDef = 225;
				this.armorMDef = 90;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 12) {
				this.short = "advanced true golem";
				this.imageName = "advanced true golem";
				this.long = "You're currently fighting advanced true golem. It's eight feet tall without any sexual characteristics, it stone body lacking any cracks dummy ones possesed and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(570, 560, 300, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 96;
				this.level = 69;
				this.bonusHP = 800;
				this.bonusLust = 89;
				this.additionalXP = 690;
				this.weaponAttack = 110;
				this.armorDef = 275;
				this.armorMDef = 110;
			}
			this.a = "the ";
			this.drop = NO_DROP;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.armorName = "stone";
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}