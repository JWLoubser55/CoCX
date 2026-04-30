/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.GlobalFlags.kFLAGS;
	
	public class GoodSamaritan extends WeaponRange {
		
		public function GoodSamaritan() 
		{
			super("GoodSam", "GoodSamaritan", "Good Samaritan", "a Good Samaritan", "shot", 150, 7500, "A single 22mm, four-round revolver, the Good Samaritan has even largest bullets than desert eagle. Its shots are deadly and precise through the gun has one hell of a recoil. Requires 200 strength to fully unleash it power.", "Pistol")
			withTag(I_LEGENDARY);
		}
		
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 20;
			if (game.player.str >= 200) {
				boost += 40;
				scal -= 6;
			}
			if (game.player.str >= 100) {
				boost += 40;
				scal -= 6;
			}
			if (game.player.str >= 50) {
				boost += 10;
				scal -= 4;
			}
			boost += Math.round((game.player.playerCorruption2()-game.player.playerCorruption()) / scal);
			return (10 + boost);
		}
		
	}

}
