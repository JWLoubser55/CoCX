package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosA2 extends Consumable {
		
		public function BagOfCosmosA2() 
		{
			super("BagOCA2", "BagOfCosmosA2", "a Bag of Cosmos (A2)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(6)) {
				case 0:
				var SS1:int = 3 + Utils.rand(3);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				var SS2:int = 6 + Utils.rand(6);
				outputText("" + Utils.num2Text(SS2) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS2;
				EngineCore.statScreenRefresh();
				break;

				case 2:
				outputText("low-grade Soulforce Recovery Pill inside.");
				SceneLib.inventory.takeItem(game.consumables.LG_SFRP, SceneLib.inventory.inventoryMenu);
				return true;

				case 3:
				outputText("Moonlight grass inside.");
				SceneLib.inventory.takeItem(game.consumables.MOONGRASS, SceneLib.inventory.inventoryMenu);
				return true;

				case 4:
				outputText("Elemental Crystal inside.");
				SceneLib.inventory.takeItem(game.useables.ELCRYST, SceneLib.inventory.inventoryMenu);
				return(true);

				case 5:
				outputText("clump of red gel inside.");
				SceneLib.inventory.takeItem(game.useables.RED_GEL, SceneLib.inventory.inventoryMenu);
				return(true);

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}