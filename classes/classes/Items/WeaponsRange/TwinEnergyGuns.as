/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.IELib;
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinEnergyGuns extends WeaponRange
	{
		
		public function TwinEnergyGuns() 
		{
			super("TEnergyG", "TEnergyGuns", "Twin Energy Guns", "a Twin Energy Gun", "shot", 25, 2560, "A pair of guns made by the ancient civilisation. Perhaps the original design from wich the goblins created their firearms. Instead of physical projectile they fires tiny blast of energy and does not seem to run off ammunition like other firearms.\n\nGoblin Mech Compatible", "Dual Firearms");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
			return false;
		}
	}
}
