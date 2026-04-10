package classes.Items.Shields 
{
	import classes.Items.IELib;
	import classes.Items.Shield;

	public class Pridwen extends Shield {
		
		public function Pridwen() 
		{
			super("Pridwen", "Pridwen", "Pridwen", "a Pridwen", 1, 200, "A legendary shield said to have been made by Marae for her champion. It radiates divine power, purifying its wielder and protecting them from impurity.");
			withTag(I_LEGENDARY);
			withEffect(IELib.Require_CorBelow, -33);
		}
		
		override public function get block():Number {
			var temp:int = 40 - (game.player.playerCorruption() / 4);
			if (temp < 1) temp = 1;
			return temp;
		}
	}
}
