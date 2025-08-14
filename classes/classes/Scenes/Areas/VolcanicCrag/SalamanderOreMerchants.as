package classes.Scenes.Areas.VolcanicCrag {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Useable;
import classes.Scenes.API.MultiBuy;
import classes.internals.SaveableState;

public class SalamanderOreMerchants extends BaseContent implements SaveableState {

    public static var VisitedCount:int;
	public static var boughtStuff:Boolean;
	
    public function stateObjectName():String {
        return "SalamanderOreMerchants";
    }

    public function resetState():void {
        VisitedCount = 0;
		boughtStuff = false;
    }

    public function saveToObject():Object {
        return {
            "VisitCount": VisitedCount,
            "boughtStuff": boughtStuff
        };
    }
    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            VisitedCount = o["VisitCount"];
            boughtStuff = o["boughtStuff"];
        }
    }

    public function SalamanderOreMerchants() {
    }

    public function introOreMerchant():void {
        clearOutput();
		boughtStuff = false;
        outputText("As you explore the crag you run into a group of salamanders, a single male and two females. ");
        if (VisitedCount == 0 && flags[kFLAGS.HEL_TIMES_ENCOUNTERED] > 0) {
            outputText("At first you expected them to draw their scimitar and run at you screaming savagely like Helia but turns out that’s not as common a thing as you thought. ");
			VisitedCount++;
        }
        outputText("They wave at you before coming closer. The male, well ripped and equipped with a massive pickaxe which must serve as both a weapon and a harvesting tool greets you.\n\n");
        outputText("\"<i>Well met traveler, we are peddlers traveling the region to gather and sell minerals. You seem to be an adventurer so if I may ask, are you perhaps interested in our products?</i>\"\n\n");
        outputText("Funnily you thought everyone in the salamander society was either a blacksmith or a warrior but you guess they need somebody to mine material if they are to forge something. Maybe you should browse his wares?\n\n");
        menu();
		addButton(1, "Shop", shopSalamanderWares);
        addButton(3, "No, thanks!", unShop);
    }

    public function unShop(boughtStuff:Boolean = false):void {
        clearOutput();
        if (!boughtStuff) outputText("You aren’t looking for any of those at the time so you bid the ore peddlers farewell for now as you resume your exploration.");
        else outputText("You thank the salamander group, and go on your way with your haul.");
        endEncounter();
    }

    public function shopSalamanderWares(buyStuff:Boolean = false):void {
        clearOutput();
		if (buyStuff) boughtStuff = true;
        outputText("As you voice your interest the salamander grabs a parchment and hands you over what appears to be a list of materials.\n\n");
        outputText("\"<i>If any of those catch your eyes let me know, I got large quantities of those in my bag of hoarding and would be willing to trade them for the right amount of gems. I also sell pickaxes if that's up your alley.</i>\"\n\n");
        menu();
		addButton(0, useables.TIN_ORE.shortName, sellItem, useables.TIN_ORE);
        addButton(1, useables.COP_ORE.shortName, sellItem, useables.COP_ORE);
		addButton(2, useables.IRONORE.shortName, sellItem, useables.IRONORE);
		addButton(3, useables.MOONSTO.shortName, sellItem, useables.MOONSTO);
		addButton(14, "Finished!", unShop, true);
    }
	private function sellItem(item:Useable,cost:int = -1,buy:Boolean=false):void {
		var priceRate:Number = 10;
		var priceToShow:int = item.value * 10;
		var descString:String;
		switch(item){
			case useables.TIN_ORE:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Tin, uh? Not a very useful metal by itself but mix it with copper and you will get some good oll bronze. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.COP_ORE:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Copper, uh? You can make some jewelry out of it or combine it with tin to get some bronze. Not the best metal but good for apprentice smith training. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.IRONORE:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Iron, uh? Can’t be bothered to go mine it yourself uh? Don’t worry I know not everyone is cut out for mining that's why us people exist. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.MOONSTO:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Moonstone, uh? That’s rather rare on the market. Metal is a pain in the ass to mine because it's the same color as ordinary rock by day but only becomes shiny at night. With the current creeps that show up post nightfall mining moonstone has become hazardous. It's famous for its property to conduct magic and rather expensive but sure I’ll sell you some moonstone for <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;/*
			case useables.MOONSTO:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Tin, uh? Not a very useful metal by itself but mix it with copper and you will get some good oll bronze. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.MOONSTO:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Tin, uh? Not a very useful metal by itself but mix it with copper and you will get some good oll bronze. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.MOONSTO:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Tin, uh? Not a very useful metal by itself but mix it with copper and you will get some good oll bronze. Sure that will be <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;*/
		}
		var onBuyStr:String = "\n\nYou pass on the gems to the salamander merchant's hands and he nods.\n\n\"Happy to do business with you adventurer here is your piece of "+item.shortName+". Would you like to purchase anything else?\"\n\n";
		MultiBuy.confirmBuyMulti(curry(shopSalamanderWares, true), "ore peddler", priceRate, item, descString, onBuyStr, false);
	}
}
}
