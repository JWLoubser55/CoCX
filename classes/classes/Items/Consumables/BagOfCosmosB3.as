package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosB3 extends Consumable {
		
		public function BagOfCosmosB3() 
		{
			super("BagOCB3", "BagOfCosmosB3", "a Bag of Cosmos (B3)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(6)) {
				case 0:
				var SS1:int = 40 + Utils.rand(40);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				outputText("mid-grade Soulforce Recovery Pill inside.");
				SceneLib.inventory.takeItem(game.consumables.MG_SFRP, SceneLib.inventory.inventoryMenu);
				return true;

				case 2:
				outputText("elemental shard inside.");
				SceneLib.inventory.takeItem(game.useables.ELSHARD, SceneLib.inventory.inventoryMenu);
				return true;

				case 3:
				outputText("large elemental shard inside.");
				SceneLib.inventory.takeItem(game.useables.LELSHARD, SceneLib.inventory.inventoryMenu);
				return true;

				case 4:
				outputText("elemental crystal inside.");
				SceneLib.inventory.takeItem(game.useables.ELCRYST, SceneLib.inventory.inventoryMenu);
				return true;

				case 5:
				outputText("large elemental crystal inside.");
				SceneLib.inventory.takeItem(game.useables.LELCRYST, SceneLib.inventory.inventoryMenu);
				return true;

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}