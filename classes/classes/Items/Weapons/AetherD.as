/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.CoC;
import classes.ItemType;
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.IELib;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.Scenes.NPCs.AetherTwinsFollowers;
	
	public class AetherD extends Weapon {
		
		public function AetherD()
		{
			super("AetherD", "AetherD", "Aether (Dex)", "an Aether (Dex)", "punch", 0, 0, "Aether - dexter part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.", WT_GAUNTLET, WSZ_MEDIUM);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (";
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") desc += "Dagger";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Swords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Sword and Shield") desc += "Sword";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Axes" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Axe and Shield") desc += "Axe";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Rapiers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Rapier and Shield") desc += "Rapier";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Maces" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Mace and Shield") desc += "Mace";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Whips" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Whip and Shield") desc += "Whip";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Greatsword and Large Shield") desc += "Greatsword";
			else desc += "Gauntlet";
			desc += ")";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: 0";
			return desc;
		}
		
		override public function get verb():String {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return "stab";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Swords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Sword and Shield" ||
					 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Rapiers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Rapier and Shield" ||
					 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Greatsword and Large Shield") return "slash";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Axes" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Axe and Shield") return "cleave";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Maces" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Mace and Shield") return "smash";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Whips" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Whip and Shield") return "whip-crack";
			else return "punch";
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			boost += game.player.statusEffectv1(StatusEffects.AetherTwins1);
			return (0 + boost);
		}
		
		override public function get type():String {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return WT_DAGGER;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Swords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Sword and Shield" ||
					 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Greatsword and Large Shield") return WT_SWORD;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Axes" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Axe and Shield") return WT_AXE;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Rapiers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Rapier and Shield") return WT_DUELING;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Maces" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Mace and Shield") return WT_MACE_HAMMER;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Whips" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Whip and Shield") return WT_WHIP;
			else return WT_GAUNTLET;
		}
		
		override public function get size():int {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return WSZ_SMALL;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Greatsword and Large Shield" ||
					 AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gauntlets") return WSZ_LARGE;
			else return WSZ_MEDIUM;
		}
		
		override public function useText():void {
			outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Dex) says excitedly, \"<i>Let's go!</i>\"\n\n");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
			super.afterEquip(doOutput, slot);
		}
		
		override public function unequipText(slot:int):void {
			outputText("Aether (Dex) lies on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Dex) is now available in the followers tab!</b>)");
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
			super.afterUnequip(doOutput, slot);
		}
		
		override public function beforeUnequip(doOutput:Boolean, slot:int):ItemType {
			super.beforeUnequip(doOutput, slot);
			return WeaponLib.FISTS;
		}
		
		private const lustDmg1:ItemEffect = new ItemEffect(IELib.LustDamage, 10, 1/8);
		private const lustDmg2:ItemEffect = new ItemEffect(IELib.LustDamage, 5, 1/10);
		private const lustDmg3:ItemEffect = new ItemEffect(IELib.LustDamage, 15, 1/8);
		private const penetration1:ItemEffect = new ItemEffect(IELib.ArmorPenetration, 40);
		private const teasedmg1:ItemEffect = new ItemEffect(IELib.Buff, 35, 'teasedmg');
		override public function findEffect(type:ItemEffectType):ItemEffect {
			if (type == IELib.LustDamage) {
				if (AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gauntlets" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Whips" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Whip and Shield") return lustDmg1;
				else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield" ||
						 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Swords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Sword and Shield" ||
						 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Axes" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Axe and Shield" ||
						 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Spears" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Spear and Shield" ||
						 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Maces" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Mace and Shield" ||
						 AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Greatswords" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Greatsword and Large Shield") return lustDmg2;
				else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Rapiers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Rapier and Shield") return lustDmg3;
			}
			if (type == IELib.ArmorPenetration) {
				if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Spears" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Spear and Shield") return penetration1;
			}
			if (type == IELib.Buff) {
				if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Whips" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Whip and Shield") return teasedmg1;
			}
			return super.findEffect(type);
		}
	}
}
