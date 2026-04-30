/**
 * ...
 * @author Liadri
 */
package classes.Items.Necklaces 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Necklace;
	import classes.Player;
	import classes.StatusEffects;
	
	public class WinterBellCollar extends Necklace
	{
		
		public function WinterBellCollar() 
		{
			super("WBCollar", "WinterBellCollar", "Winter Bell Collar", "a Winter Bell Collar", 0, 0, 1600, "A collar ornamented with multiple chiming bells. Aside from granting seasonal cheers, it improves all movement based abilities as well as increases speed by 50. Those unable to fly can run into the sky while wearing this so long as they have the body configurations of a centaur.  \n\nType: Jewelry (Necklace) \nBase value: 1,600", "Necklace");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			game.player.createStatusEffect(StatusEffects.WinterBellCollarA, 0, 0, 0, 0);
			game.player.speStat.core.value += 50;
			super.afterUnequip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			game.player.removeStatusEffect(StatusEffects.WinterBellCollarA);
			game.player.speStat.core.value -= 50;
			super.afterUnequip(doOutput, slot);
		}
	}
}
