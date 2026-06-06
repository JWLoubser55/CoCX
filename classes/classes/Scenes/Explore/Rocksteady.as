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
			addButton(1, "Books", bookMenu);
			addButton(2, "Misc", miscMenu);
			addButton(3, "Trade", tradeMenu);
			addButton(14, "Leave", explorer.done);
			statScreenRefresh();
		}
		
		private function firstEncounter():void {
			outputText("As you travel, you see another person on the road. He is tethered to a small cart that is overloaded with a hodgepodge of items. The man sees you, smiles and stops his cart.\n");
			outputText("\"<i>Greetings, traveler! My name is Rocksteady. I am, as you can see, a humble purveyor of items, curios and other accoutrements. While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n");
			outputText("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving.  The merchant twists his way around to access a sack he has around his back. After a moment, he swings the sack from his back to have better access to its contents. Inquisitively, the merchant turns back to you.\n");
			outputText("\"<i>So stranger, be you interested in some drafts to aid you in your travels, some quick pamphlets to warn you of dangers on journeys?</i>\"\n\n");
			outputText("Rocksteady's grin is nothing short of creepy as he offers his wares to you. What are you interested in?");
			player.createStatusEffect(StatusEffects.MeetRocksteady, 0, 0, 0, 0);
		}
		
		private function bookMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Which book are you interested in perusing?");
			menu();
			addButton(0, "TelAdreMagI2", pitchTelAdreMagazineIssue2).hint("Tel'Adre Magazine Issue 2");
			addButton(1, "TelAdreMagI5", pitchTelAdreMagazineIssue5).hint("Tel'Adre Magazine Issue 5");
			addButton(2, "TelAdreMagI8", pitchTelAdreMagazineIssue8).hint("Tel'Adre Magazine Issue 8");
			addButton(3, "TelAdreMagI10", pitchTelAdreMagazineIssue10).hint("Tel'Adre Magazine Issue 10");
			addButton(14, "Back", rocksteadyEncounter);
			statScreenRefresh();
		}
		
		private function miscMenu():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();/*
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
			}*/
			addButton(0, "Torch", pitchTorch);
			if (Holidays.nieveHoliday()) {
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 0) addButton(1, "Mysterious Seed", pitchMysteriousSeed);
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 5) addButton(2, "Decorations", pitchDecorations);
			}
			addButton(3, "E. Tome", pitchElementalistsTome).hint("Elementalist’s Tome");
			if (player.hasPerk(PerkLib.ExanimationI) && !player.hasPerk(PerkLib.ExanimationIII) && player.level < 32) addButton(13, "Peach", pitchPurePeach);
			addButton(14, "Back", rocksteadyEncounter);
			statScreenRefresh();
		}
		
		private function tradeMenu():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();
			var merchantMenu:MerchantMenu = new MerchantMenu();
			merchantMenu.playerCanSell = true;
			merchantMenu.playerSellFactor = merchantMenu.greedCheck() ? 0.4 : 0.8;
			merchantMenu.addItem(consumables.GRHINOS, 25);
			merchantMenu.addItem(consumables.W__BOOK, 100);
			merchantMenu.addItem(consumables.G__BOOK, 500);
			merchantMenu.addItem(consumables.B__BOOK, 100);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.RMANUSC, 125);
			merchantMenu.addItem(weaponsrange.E_TOME_, 1000);
			merchantMenu.addItem(consumables.CRIMS_J, 125);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.SAPILL_);
			merchantMenu.addItem(consumables.MAPILL_).disableIf(player.level < 24, "Req. lvl 24+", true);
			merchantMenu.addItem(consumables.BAPILL_).disableIf(player.level < 42, "Req. lvl 42+", true);
			merchantMenu.addItem(consumables.LAPILL_).disableIf(player.level < 78, "Req. lvl 78+", true);
			merchantMenu.addItem(consumables.HAPILL_).disableIf(player.level < 150, "Req. lvl 150", true);
			merchantMenu.show(rocksteadyEncounter);
		}
		
		private function pitchTelAdreMagazineIssue2():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 2") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 2'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Rocksteady holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Rocksteady, \"<i>is a 2nd issue of Tel'Adre Magazine.  It dive into matters of distilling moonshine and mixing dyes... I mean, refining alchemical ingredients and medicine-crafting.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your alchemic horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue2, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue2():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Rocksteady sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in producing stinky goo... and sometimes, alchemical products. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 2", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue5():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 5") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 5'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Rocksteady holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Rocksteady, \"<i>is a 5th issue of Tel'Adre Magazine.  It dive into matters of so called fifth finger or green thumb.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your herbalism horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue5, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue5():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Rocksteady sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in herb cultivation. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 5", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue8():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 8") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 8'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Rocksteady holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Rocksteady, \"<i>is a 8th issue of Tel'Adre Magazine.  It dive into matters of so benefits of having all ten fingers... err well sometimes just eight to hold your farming tools.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your farming horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue8, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue8():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Rocksteady sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in.... not cutting any of your fingers when you try to use farming tools. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 8", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue10():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 10") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 10'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Rocksteady holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Rocksteady, \"<i>is a 10th issue of Tel'Adre Magazine.  It dive into matters of so benefits of having all ten fingers... like to hold your pickaxe.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your mining horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue10, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue10():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Rocksteady sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in diggin the hole.... err mining to your heart content. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 10", 0, 0, 0, 0);
			}
		}
		
		private function pitchTorch():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Torch") > 0) {
				outputText("<b>Trying to cope with that pyromania? You already have a torch!</b>");
				doNext(miscMenu);
				return;
			}
			outputText("Rocksteady shrugs.  \"<i>You may think this item to be unnecessary but it’s in the kit of any smart adventurers wishing to explore nowadays, who knows it might even save your life. Only 100 gems, I recommend it, really.</i>\"");
			doYesNo(buyTorch, miscMenu);
		}
		
		private function buyTorch():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("\n\nRocksteady sighs, indicating you need 100 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over hundred gems and in exchange gives you a torch.");
				player.gems -= 100;
				player.createKeyItem("Torch", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchMysteriousSeed():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>Ah, that. That's just a seed I acquired from someone on my travels. They said planting it will result in something truly extraordinary to happen but I haven't really had the time to get around to it. Perhaps it'll be better suited for someone with more time on their hands? Maybe for let's say… 30 gems?</i>\"");
			doYesNo(buyMysteriousSeed, miscMenu);
		}
		
		private function buyMysteriousSeed():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 30) {
				outputText("\n\nRocksteady sighs, indicating you need 30 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the seed. It’s actually fairly large and light brown in color. Other than that it just looks like an ordinary seed. Maybe you'll plant it later to see what it'll grow into. <b>You acquired the Mysterious Seed.</b>");
				player.gems -= 30;
				flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 1;
				player.createKeyItem("Mysterious Seed", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchDecorations():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>Ah, yes! I make sure to keep these in stock for the season! Though not many people around here really buy these anymore… I can sell these to you for a decent price. Let's say about 100 gems?</i>\"");
			doYesNo(buyDecorations, miscMenu);
		}
		
		private function buyDecorations():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("\n\nRocksteady sighs, indicating you need 100 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the seed. It’s actually fairly large and light brown in color. Other than that it just looks like an ordinary seed. Maybe you'll plant it later to see what it'll grow intoYou buy the package filled with holiday decorations. Inside are shiny, colorful ornaments, garland, and lights. You can't help but think this will be perfect for decorating the tree back at camp. <b>You acquired Holiday Decorations.</b>");
				player.gems -= 100;
				flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 7;
				player.createKeyItem("Decorations", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchElementalistsTome():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Rocksteady holds up an Elementalist’s Tome.  \"<i>While you may not find value in this as a simple tome,</i>\", Rocksteady opens, \"<i>you never know what you may learn from it!  I will offer the super-cheap price of 1,000 gems!</i>\"");
			doYesNo(buyElementalistsTome, miscMenu);
		}
		
		private function buyElementalistsTome():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 1000) {
				outputText("Rocksteady sighs, indicating you need 1,000 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over thousand gems and in exchange gives you an Elementalist’s Tome.");
				player.gems -= 1000;
				inventory.takeItem(weaponsrange.E_TOME_, miscMenu);
			}
		}
		
		private function pitchPurePeach():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Rocksteady holds up a peach.  \"<i>While you may not find value in this as a fruit,</i>\", Rocksteady opens, \"<i>you never know what you may gain from eating it!  I will offer the super-cheap price of 25 gems!</i>\"");
			doYesNo(buyPurePeach, miscMenu);
		}
		
		private function buyPurePeach():void {
			//spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 25) {
				outputText("Rocksteady sighs, indicating you need 25 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over a twenty five gems and in exchange gives you a yellowy-orange peach.");
				player.gems -= 25;
				inventory.takeItem(consumables.PURPEAC, miscMenu);
			}
		}
	}
}