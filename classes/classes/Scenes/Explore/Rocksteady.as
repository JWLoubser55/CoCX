package classes.Scenes.Explore {
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.MerchantMenu;
import classes.Scenes.Camp.Garden;
import classes.Scenes.Crafting;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class Rocksteady extends BaseContent {
		
		public function Rocksteady() 
		{}

		public function rocksteadyEncounter():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.MeetRocksteady)) { //Normal greeting
				outputText("You spy the merchant Rocksteady in the distance.  He makes a beeline for you, setting up his shop in moments.  ");
				outputText("Rocksteady's grin is nothing short of creepy as he offers his wares to you. What are you interested in?");
			}
			else firstEncounter();
			menu();
			//addButton(0, "Potions", potionMenu);
			//addButton(1, "Books", bookMenu);
			//addButton(2, "Erotica", eroticaMenu);
			//addButton(3, "Misc", miscMenu);
			//addButton(4, "Trade", tradeMenu);
			addButton(14, "Leave", explorer.done);
			statScreenRefresh();
		}
		
		private function firstEncounter():void {
			outputText("As you travel, you see another person on the road.  He is tethered to a small cart that is overloaded with a hodgepodge of items.  He is dressed in a very garish manner, having a broad, multicolored hat, brocaded coat and large, striped pantaloons.  His appearance is almost comical and contrasts with his severe and hawkish facial features.  The man sees you, smiles and stops his cart.\n");
			outputText("\"<i>Greetings, traveler! My name is Giacomo.  I am, as you can see, a humble purveyor of items, curios and other accoutrements.  While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n");
			outputText("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving.  The merchant twists his way around to access a sack he has around his back.  After a moment, he swings the sack from his back to have better access to its contents.  Inquisitively, the merchant turns back to you.\n");
			outputText("\"<i>So stranger, be you interested in some drafts to aid you in your travels, some quick pamphlets to warn you of dangers on journeys or...</i>\"\n\n");
			outputText("Giacomo pauses and turns his head in both directions in a mocking gesture of paranoid observation.  His little bit of theatrics does make you wonder what he is about to offer.\n");
			outputText("\"<i>...maybe you would be interested in some items that enhance the pleasures of the flesh?  Hmmm?</i>\"\n\n");
			outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you.  What are you interested in?");
			player.createStatusEffect(StatusEffects.MeetRocksteady, 0, 0, 0, 0);
		}
		
		private function tradeMenu():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();
			var merchantMenu:MerchantMenu = new MerchantMenu();
			merchantMenu.playerCanSell = true;
			merchantMenu.playerSellFactor = merchantMenu.greedCheck() ? 0.8 : 0.4;
			merchantMenu.addItem(consumables.MANUP_B, 15);
			merchantMenu.addItem(consumables.VITAL_T, 15);
			merchantMenu.addItem(consumables.SMART_T, 15);
			merchantMenu.addItem(consumables.CERUL_P, 75);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(useables.CONDOM, 10);
			merchantMenu.addItem(consumables.SAPILL_);
			merchantMenu.addItem(consumables.MAPILL_).disableIf(player.level < 24, "Req. lvl 24+", true);
			merchantMenu.addItem(consumables.BAPILL_).disableIf(player.level < 42, "Req. lvl 42+", true);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.W__BOOK, 100);
			merchantMenu.addItem(consumables.G__BOOK, 500);
			merchantMenu.addItem(consumables.B__BOOK, 100);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.RMANUSC, 125);
			merchantMenu.addItem(weaponsrange.E_TOME_, 1000);
			merchantMenu.addItem(consumables.CRIMS_J, 125);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.GRHINOS, 25);
			merchantMenu.show(rocksteadyEncounter);
		}/*
		
		private function miscMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();
			addButton(0, "MiningProdigyBag", pitchMiningProdigyBag);
			if (player.hasKeyItem("Tarnished Ore Bag (Lowest grade)") >= 0) addButton(1, "Ore Bag (LowG)", pitchLLOreBag).hint("Ore Bag (Lowest Grade)");
			if (Garden.IngrediantBagSlot01Cap == 0) addButton(4, "Herb Bag (LLowG)", pitchLLHerbsBag).hint("Herbs Bag (Lowest Grade)");
			if (Garden.IngrediantBagSlot07Cap == 0) {
				if (player.farmingLevel >= 5) addButton(5, "Herb Bag (LowG)", pitchLHerbsBag).hint("Herbs Bag (Low Grade)");
				else addButtonDisabled(5, "Herb Bag (LowG)", "Herbs Bag (Low Grade) Req. lvl 5 in Farming.");
			}
			if (Garden.IngrediantBagSlot09Cap == 0) {
				if (player.farmingLevel >= 10) addButton(6, "Herb Bag (MidG)", pitchMHerbsBag).hint("Herbs Bag (Mid Grade)");
				else addButtonDisabled(6, "Herb Bag (MidG)", "Herbs Bag (Mid Grade) Req. lvl 10 in Farming.");
			}
			if (Garden.PotionsBagSlot01Cap == 0) addButton(7, "Pot Bag (LLowG)", pitchLLPotionsBag).hint("Potion Bag (Lowest Grade)");
			if (Garden.PotionsBagSlot07Cap == 0) {
				if (player.herbalismLevel >= 5) addButton(8, "Pot Bag (LowG)", pitchLPotionsBag).hint("Potion Bag (Low Grade)");
				else addButtonDisabled(8, "Pot Bag (LowG)", "Potion Bag (Low Grade) Req. lvl 5 in Herbalism.");
			}
			if (Garden.PotionsBagSlot09Cap == 0) {
				if (player.herbalismLevel >= 10) addButton(9, "Pot Bag (MidG)", pitchMPotionsBag).hint("Potion Bag (Mid Grade)");
				else addButtonDisabled(9, "Pot Bag (MidG)", "Potion Bag (Mid Grade) Req. lvl 10 in Herbalism.");
			}
			if (player.hasPerk(PerkLib.ExanimationI) && !player.hasPerk(PerkLib.ExanimationIII) && player.level < 32) addButton(10, "Peach", pitchPurePeach);
			if (Holidays.nieveHoliday()) {
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 0) addButton(11, "Mysterious Seed", pitchMysteriousSeed);
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 5) addButton(12, "Decorations", pitchDecorations);
			}
			addButton(13, "Torch", pitchTorch);
			addButton(14, "Back", rocksteadyEncounter);
			statScreenRefresh();
		}
		
		private function itemBuy2(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>Interested? It’s yours for only " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				doNext(potionMenu);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			doYesNo(curry(debitWeapon2,itype), potionMenu);
		}
		
		private function debitWeapon2(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, potionMenu);
		}*/
		
	}
}