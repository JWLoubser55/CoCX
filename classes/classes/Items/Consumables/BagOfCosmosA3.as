package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosA3 extends Consumable {
		
		public function BagOfCosmosA3() 
		{
			super("BagOCA3", "BagOfCosmosA3", "a Bag of Cosmos (A3)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(6)) {
				case 0:
				var SS1:int = 4 + Utils.rand(4);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				var SS2:int = 8 + Utils.rand(8);
				outputText("" + Utils.num2Text(SS2) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS2;
				EngineCore.statScreenRefresh();
				break;

				case 2:
				outputText("mid-grade Soulforce Recovery Pill inside.");
				SceneLib.inventory.takeItem(game.consumables.MG_SFRP, SceneLib.inventory.inventoryMenu);
				return true;

				case 3:
				outputText("Ginseng inside.");
				SceneLib.inventory.takeItem(game.consumables.GINSENG, SceneLib.inventory.inventoryMenu);
				return true;

				case 4:
				outputText("Darksteel ingot inside.");
				SceneLib.inventory.takeItem(game.useables.DARKSTI, SceneLib.inventory.inventoryMenu);
				return true;

				case 5:
				outputText("Body Tempering Solution vial inside.");
				SceneLib.inventory.takeItem(game.useables.BTSOLUTION, SceneLib.inventory.inventoryMenu);
				return true;

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}