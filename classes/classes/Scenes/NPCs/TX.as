/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class TX extends Monster
	{
		
		public function TX() 
		{
			this.a = "a ";
			this.short = "proto golem";
			this.imageName = "proto golem";
			this.long = "You're currently fighting a proto golem. It's six feet tall, without any sexual characteristics. It has a stone body that have many missing pieces, even it core is not yet fully protected. It has no weapons, using its grey stone fists to smash enemies.";
			this.createBreastRow(0, 1);
			initGenderless();
			this.plural = false;
			initStrTouSpeInte(10, 10, 5, 5);
			initWisLibSensCor(5, 5, 5, 0);
			this.tallness = 72;
			this.drop = NO_DROP;
			this.level = 6;
			this.bonusHP = 50;
			this.lustVuln = 0.01;
			this.additionalXP = 50;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 5;
			this.armorName = "cracked stone";
			this.armorDef = 5;
			this.armorMDef = 1;
			this.bonusLust = 16;
			this.createPerk(PerkLib.EnemyForBeginnersType, 0, 0, 0, 0);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
