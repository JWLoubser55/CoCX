package classes.Items.WeaponsRange
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.WeaponRange;
	import classes.Player;
	import classes.Items.IELib;

	public class Failnaught extends WeaponRange {
		
		public function Failnaught() 
		{
			super("Failnau", "Failnaught", "Failnaught", "a Failnaught", "shot", 41, 1000, "A legendary bow said to have been made by Marae for her champion. This weapon radiates divine power, purifying its wielder and protecting them from impurity.", "Bow");
			withTag(I_LEGENDARY)
			withEffect(IELib.Require_CorBelow, -33)
			withEffect(IELib.AttackBonus_Purity, 1 / 3);
		}
		
		override public function get attack():Number {
			var temp:int = 41 - (game.player.playerCorruption() / 12);
			if (temp < 1) temp = 1;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.cor < (-33 + game.player.corruptionTolerance)) return super.canEquip(doOutput, slot);
			if(doOutput) outputText("You grab hold of the handle of the bow only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the bow must be displeased.  ");
			return false;
		}
	}
}
