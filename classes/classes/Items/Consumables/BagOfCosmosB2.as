package classes.Items.Consumables
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class BagOfCosmosB2 extends Consumable {
		
		public function BagOfCosmosB2() 
		{
			super("BagOCB2", "BagOfCosmosB2", "a Bag of Cosmos (B2)", 0, "It's small bag used by enemy Soul Cultivator to store much more things that the size of itself would indicate. What could be in this one?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You open bag to find ");
			switch (Utils.rand(6)) {
				case 0:
				var SS1:int = 30 + Utils.rand(30);
				outputText("" + Utils.num2Text(SS1) + " spirit stones inside.");
				flags[kFLAGS.SPIRIT_STONES] += SS1;
				EngineCore.statScreenRefresh();
				break;

				case 1:
				outputText("mid-grade Soulforce Recovery Pill inside.");
				SceneLib.inventory.takeItem(game.consumables.MG_SFRP, SceneLib.inventory.inventoryMenu);
				return true;
				break;

				case 2:
				outputText("empty pill bottle inside.");
				SceneLib.inventory.takeItem(game.useables.E_P_BOT, SceneLib.inventory.inventoryMenu);
				return true;

				case 3:
				outputText("Moonstone inside.");
				SceneLib.inventory.takeItem(game.useables.MOONSTO, SceneLib.inventory.inventoryMenu);
				return true;

				case 4:
				outputText("Orichalcum inside.");
				SceneLib.inventory.takeItem(game.useables.ORICHAL, SceneLib.inventory.inventoryMenu);
				return true;

				case 5:
				outputText("soul training axe inside.");
				SceneLib.inventory.takeItem(game.weapons.TRASAXE, SceneLib.inventory.inventoryMenu);
				return true;

				default: trace("Bag of Cosmos roll spirit stones...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}