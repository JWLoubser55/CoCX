/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Matango extends Monster
	{
		override public function playerBoundStruggle():Boolean{
			clearOutput();
			if (rand(5) == 0 || rand(Math.round(player.strStat.core.value * 0.8)) < player.strStat.core.value || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You barely manage to slide out of her embrace as the mushroom girl closes her eyes and attempts to kiss the space where your lips were a few seconds before. She stares at the empty air for a few seconds, confused that you somehow managed to slide out of her iron vice.\n\n");
				player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
				createStatusEffect(StatusEffects.AbilityCooldown1, 2, 0, 0, 0);
			}
			//Fail to break free
			else {
				outputText("You struggle to break out of her embrace, but fail to escape! The mushroom takes this opportunity to force a kiss onto you, leaving you far more aroused than before.\n\n");
				if (HPRatio() < .9) {
					outputText(" Whatever your saliva does, it seems to have a healing effect on her as some of her wounds close.");
					addHP(Math.round(maxHP()*0.05));
				}
				outputText("\n\n");
				return true;
			}
			return false;
		}

		public function moveMantagoSporeCloud():void {
			outputText("The mushroom girl giggles as she unleashes a thick cloud of spores in your general direction, opening her arms wide as if to welcome your embrace.\n\n");
			if (player.isRaceCached(Races.ALRAUNE) || player.isRaceCached(Races.GARGOYLE)/* || player.isRaceCached(Races.automaton)*/) outputText("Well that's very cute of her but you are pretty much immune to this ability. She can spray all the pollen she wants but this won’t affect you.\n\n");
			else {
				outputText("You can’t just hold your breath forever! You feel your desires rise as the insidious aphrodisiac does its dirty work.\n\n");
				outputText("In response to your reaction, she gives you a wide, dopey smile. She knows you giving up is but a matter of time now and that your defeat is an inevitable outcome.\n\n");
			}
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		public function moveMantagoGrab():void {
			outputText("The mushroom girl suddenly rushes toward you and attempts to embrace you!  ");
			if (player.getEvasionRoll()) {
				outputText("You avoid the grapple. While she looks about as weak as she’s meek, something tells you you wouldn’t be able to easily break out of her grip.");
				return;
			}
			else {
				outputText("You try to avoid her, but she successfully grabs you, forcing your head against her breast. You attempt to escape her grip right away, but she proves stronger than her frame would suggest! What is it with her superstrength?!  ");
				player.createStatusEffect(StatusEffects.PlayerBoundPhysical, 0, 0, 0, 0);
			}
		}
		
		public function moveMantagoPunch():void {
			outputText("The mushroom-infested girl lunges forward for a punch!  ");
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid her punch thanks to your reaction!");
				return;
			}
			else {
				outputText("To your surprise, you are launched toward the cave wall at breakneck speed as her unassumingly strong strike collides with your body. ");
				var damage:int = eBaseStrengthDamage() * 2 + eBaseSpeedDamage();
				player.takePhysDamage(damage, true);
				if (!player.hasPerk(PerkLib.Resolute)) {
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
					outputText("You are dazed!");
				}
			}
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.LustAura)) moveMantagoSporeCloud();
			else {
				if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical) || hasStatusEffect(StatusEffects.AbilityCooldown1)) moveMantagoPunch();
				else moveMantagoGrab();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.matangoScene.winningOverMantango();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.matangoScene.losingToMantango();
		}
		
		public function Matango() 
		{
			this.a = "the ";
			this.short = "matango";
			this.imageName = "matango";
			this.long = "You are fighting a human woman… or what perhaps used to be a human woman? She is fully naked and looks to be high on aphrodisiacs or something as she walks toward you in what appears to be a lust-induced trance, something you can properly determine to be the fault of the many mushrooms growing out of her as if she had actually herself became a mushroom. If she is sentient enough to speak, she does not show it, instead communicating through moans of pleasure. Her drooling, perverted smile promises a rather lewd mess, should you lose this battle.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 100, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity, 100, 0, 0, 0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY+3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.bodyColor = "light";
			this.hairColor = "silver white";
			this.hairLength = 9;
			initStrTouSpeInte(662, 426, 342, 201);
			initWisLibSensCor(201, 400, 300, -40);
			this.weaponAttack = 50;
			this.weaponName = "fist";
			this.weaponVerb= "punch";
			this.armorName = "skin";
			this.armorDef = 600;
			this.armorMDef = 600;
			this.bonusHP = 5000;
			this.bonusLust = 748;
			this.lustVuln = .35;
			this.lust = 30;
			this.level = 48;
			this.gems = rand(20) + 40;
			this.drop = new ChainedDrop().
					add(consumables.METHIRC,1/20).
					add(consumables.GINSENG,1/12).
					add(consumables.MOONGRASS,1/12).
					add(consumables.SNAKEBANE,1/12).
					add(consumables.IRONWEED,1/12).
					add(consumables.BLADEFERN,1/12).
					add(consumables.RAUNENECT,1/12).
					add(consumables.HEALHERB,1/7);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			this.createPerk(PerkLib.HiveMind, 0.5, 0, 0, 0);
			checkMonster();
		}
	}
}