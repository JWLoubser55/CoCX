package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosB4 extends Consumable {
		
		public function BagOfCosmosB4() 
		{
			super("BagOCB4", "BagOfCosmosB4", "a Bag of Cosmos (B4)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(2)) {
				case 0:
				var SS1:int = 50 + Utils.rand(50);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				outputText("mid-grade Soulforce Recovery Pill inside.");
				SceneLib.inventory.takeItem(game.consumables.MG_SFRP, SceneLib.inventory.inventoryMenu);
				return true;

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}