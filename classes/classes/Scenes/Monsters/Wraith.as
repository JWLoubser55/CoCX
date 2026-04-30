/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.Face;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	public class Wraith extends Monster
	{
		public function WraithClaw():void {
			outputText("The wraith lashes at you with its claws tearing off at your soul force. ");
			WraithClaw2();
			WraithClaw2();
		}
		public function WraithClaw2():void {
			var dodged:String = player.getEvasionReason();
			if(dodged != null) {
				switch(dodged) {
					case EVASION_SPEED:
						outputText("Using your superior combat skills you manage to avoid attack completely. ");
						break;
					case EVASION_EVADE:
						outputText("Using your skills at evading attacks, you anticipate and sidestep wendigo attack. ");
						break;
					case EVASION_MISDIRECTION:
						outputText("Using Raphael's teachings, you anticipate and sidestep wendigo attacks. ");
						break;
					case EVASION_FLEXIBILITY:
						outputText("With your incredible flexibility, you squeeze out of the way of wendigo's attack. ");
						break;
					case EVASION_UNHINDERED:
						outputText("Using your superior combat skills you manage to avoid attack completely. ");
						break;
					default:
						outputText("Using your superior combat skills you manage to avoid attack completely. ");
						break;
				}
			}
			else {
				var damage:Number = eBaseDamage() * 2;
				player.takePhysDamage(damage, true);
				pc.SoulforceChange(-(damage*3));
				if (player.soulforce <= 0) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
			}
		}
		
		override protected function performCombatAction():void
		{
			WraithClaw();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.wraithScene.wonWithWraith();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.wraithScene.loseToWraith();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "You are fighting a wraith. The fiendish humanoid floats and circles the air above you, looking for an opening to lash out at you. It has the face of a ";
			if (player.statusEffectv1(StatusEffects.WraithFace) == 2) str += "Snake";
			else if (player.statusEffectv1(StatusEffects.WraithFace) == 1) str += "Human";
			else str += "Wolf";
			str += " and a humanoid torso, however everything below its waist fades to nothingness as it simply lacks legs entirely and its arms end in exaggerated oversized clawed hands which it uses to drain the soulforce out of the living.";
			str += " The wraith wears a hooded shroud which conceals very little of its form, a massive 16 inch throbbing penis dripping inky black corruption and a pair of dangling balls which pulse with need on full view for its victim to see.";
			return str;
		}
		
		public function Wraith() 
		{
			if (player.statusEffectv2(StatusEffects.WraithFace) == 1) {
				initStrTouSpeInte(205, 220, 185, 92);
				initWisLibSensCor(135, 275, 125, 100);
				this.level = 22;
				this.weaponAttack = 75;
				this.armorDef = 10;
				this.armorMDef = 132;
				this.bonusLust = 423;
				this.gems = rand(5) + 5;
			}
			else {
				initStrTouSpeInte(410, 440, 370, 184);
				initWisLibSensCor(270, 550, 250, 100);
				this.level = 43;
				this.weaponAttack = 175;
				this.armorDef = 23;
				this.armorMDef = 302;
				this.bonusLust = 843;
				this.gems = rand(10) + 10;
			}
			this.a = "the ";
			this.short = "wraith";
			this.imageName = "wraith";
			this.long = "";
			this.flyer = true;
			this.magicuser = true;
			this.createCock(16,3);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "dark";
			this.hairColor = "black";
			this.hairLength = 4;
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.armorName = "hooded shroud";
			this.lust = 50;
			if (player.statusEffectv1(StatusEffects.WraithFace) == 2) this.faceType = Face.SNAKE_FANGS;
			else if (player.statusEffectv1(StatusEffects.WraithFace) == 1) this.faceType = Face.HUMAN;
			else this.faceType = Face.WOLF;
			this.drop = new WeightedDrop().add(consumables.ECTOPLS, 6)
				.add(armors.FUNERSH, 1);
			this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DarknessAffinity, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}