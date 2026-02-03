/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	import classes.GlobalFlags.kFLAGS;
	
	public class TwoGoodSamaritans extends WeaponRange {
		
		public function TwoGoodSamaritans() 
		{
			super("TGoodSam", "TwoGoodSamaritans", "Two Good Samaritans", "a Two Good Samaritans", "shot", 150, 15000, "A pair of 22mm, four-round revolvers, the Two Good Samaritans has even largest bullets than desert eagle. Their shots are deadly and precise through the guns has one hell of a recoil. Requires 200 strength to fully unleash their power.", "Dual Firearms")
			withTag(I_LEGENDARY);
		}
		
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 200) {
				boost += 40;
				scal -= 3;
			}
			if (game.player.str >= 100) {
				boost += 40;
				scal -= 3;
			}
			if (game.player.str >= 50) {
				boost += 10;
				scal -= 2;
			}
			boost += Math.round((100-game.player.cor) / scal);
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
			return false;
		}
		
	}

}
