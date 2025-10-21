package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosA1 extends Consumable {
		
		public function BagOfCosmosA1() 
		{
			super("BagOCA1", "BagOfCosmosA1", "a Bag of Cosmos (A1)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(6)) {
				case 0:
				var SS1:int = 2 + Utils.rand(2);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				var SS2:int = 4 + Utils.rand(4);
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
				outputText("empty pill bottle inside.");
				SceneLib.inventory.takeItem(game.useables.E_P_BOT, SceneLib.inventory.inventoryMenu);
				return true;

				case 5:
				outputText("Large Elemental Shard inside.");
				SceneLib.inventory.takeItem(game.useables.LELSHARD, SceneLib.inventory.inventoryMenu);
				return true;

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}