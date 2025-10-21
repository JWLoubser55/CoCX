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
		addButton(5, useables.MITHRAL.shortName, sellItem, useables.MITHRAL);
		addButton(6, useables.ORICHAL.shortName, sellItem, useables.ORICHAL);
		addButton(7, useables.ADAMANT.shortName, sellItem, useables.ADAMANT);
		addButton(7, useables.SKYMETA.shortName, sellItem, useables.SKYMETA);
		addButtonIfTrue(13, "Pickaxes", pickaxes, "Req. to have Old Pickaxe.", player.hasKeyItem("Old Pickaxe") >= 0, "Better Pickaxes then Old Pickaxe.");
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
				break;
			case useables.MITHRAL:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Mithral, uh? That’s rather rare on the market. Like silver in appearance it has the unique property to never rust which makes it rather sought off as a material for high quality jewelry. Furthermore, mithral is harder than steel and half as light, perfect material for a swift weapon like a knife or a rapier. Damn metal is like diamond however it only grows in rare places next to high pressure volcanic grounds and is hard to come by. I got some for trade but it will be for <b>" + priceToShow.toString() + " gems</b> a bargain I assure you considering the efforts to extract it.</i>\"";
				break;
			case useables.ORICHAL:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Orichalcum, uh? That’s rather rare on the market. Stuff is amazing, conducts magic like nothing else, not even moonstone can beat it but there's a catch it can only be found underwater. Ever tried to teach a salamander to swim? Only me and an old colleague of mine dared to ever go down there. There's stuff beneath the waters that are best left unspoken off. Material is risky to obtain even for us so I'll have to ask at least <b>" + priceToShow.toString() + " gems</b> if you want to even see a chunk.</i>\"";
				break;
			case useables.ADAMANT:
				descString = "The salamander merchant nod at your choice.\n\n\"<i>Adamantine, uh? That’s quite rare. Adamantine, while it can be found anywhere, is most often found in areas of high pressure similar to diamonds. Damn metal is indestructible and while it can be melted with crazy high temperatures it will never bend noor break. Planning to make an armor out of that maybe? Well it's your lucky day, I have chunks of adamantine but they will not come cheaply. If you want some I will sell it to you but only for <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
			case useables.SKYMETA:
				descString = "Skymetal, uh? That’s next to impossible to find on the market. Skymetal can only be mined from meteorites and even then only in small quantities. The thing combines the best property of adamantine and orichalcum truly the metal of the gods or so they say. What are you even planning to do with that, make a legendary weapon? If memory serves, the king of the land struggled to find enough to build a single shield back then. Well it's your lucky day, I have one chunk of skymetal but that’s it only one. I wanted to keep it as a trophy you know, to say that I own some amount of the rarest mineral in Mareth but right now bragging rights aren’t exactly of much use. If you want it I will sell it to you but only for <b>" + priceToShow.toString() + " gems</b> per chunk.</i>\"";
				break;
		}
		var onBuyStr:String = "\n\nYou pass on the gems to the salamander merchant's hands and he nods.\n\n\"Happy to do business with you adventurer here is your piece of "+item.shortName+". Would you like to purchase anything else?\"\n\n";
		MultiBuy.confirmBuyMulti(curry(shopSalamanderWares, true), "ore peddler", priceRate, item, descString, onBuyStr, false);
	}
	
	public function pickaxes():void {
		clearOutput();
		outputText("You ask out the salamander merchant if he could sell you mining tools. He looks at you with a smile clearly approving of your interest in the mining craft.\n\n");
        outputText("\"<i>Well we have no shortage of spare mining tools for trade so long as you got the gems for them though you will also need a certain level of proficiency to use them. The only mining tool I can’t provide is one made of skymetal. The ore is just too rare for me to own a pickaxe made of it though if you could bring me some material I might be able to create one for you at a cost. Anyway, which kind of pickaxe would you like to purchase?</i>\"\n\n");
		menu();
		if (player.gems >= 500) addButtonIfTrue(1, "Steel Pickaxe", curry(pickaxesType, 1), "You already have Steel Pickaxe.", player.hasKeyItem("Steel Pickaxe") < 0, "A common pickaxe with a steel head. Better than an ordinary low quality pickaxe.");
		else addButtonDisabled(1, "Steel Pickaxe", "Req. 500+ gems.");
		if (player.gems >= 2000 && player.miningLevel > 2) addButtonIfTrue(2, "Moonstone Pickaxe", curry(pickaxesType, 2), "You already have Moonstone Pickaxe.", player.hasKeyItem("Moonstone Pickaxe") < 0, "A pickaxe with a moonstone head. Better than an iron pickaxe. The magical conductivity of the moonstone head makes it possible to find moonstone ore even during the day.");
		else addButtonDisabled(2, "Moonstone Pickaxe", "Req. 2,000+ gems and mining lvl 3+.");
		if (player.gems >= 10000 && player.miningLevel > 4) addButtonIfTrue(3, "Mithril Pickaxe", curry(pickaxesType, 3), "You already have Mithril Pickaxe.", player.hasKeyItem("Mithril Pickaxe") < 0, "A pickaxe with a mithral head. The mithral head makes it easier to mine rare ore while finding ores with magical property.");
		else addButtonDisabled(3, "Mithril Pickaxe", "Req. 10,000+ gems and mining lvl 5+.");
		if (player.gems >= 15000 && player.miningLevel > 6) addButtonIfTrue(6, "Orichalcum Pickaxe", curry(pickaxesType, 4), "You already have Orichalcum Pickaxe.", player.hasKeyItem("Orichalcum Pickaxe") < 0, "A pickaxe with an orichalcum head. More magically conductive than mithral it also has better durability.");
		else addButtonDisabled(6, "Orichalcum Pickaxe", "Req. 15,000+ gems and mining lvl 7+.");
		if (player.gems >= 25000 && player.miningLevel > 8) addButtonIfTrue(7, "Adamantine Pickaxe", curry(pickaxesType, 5), "You already have Adamantine Pickaxe.", player.hasKeyItem("Adamantine Pickaxe") < 0, "A pickaxe with an adamantine head. Slightly less conductive than orichalcum but capable of harvesting next to any material without fail. This pickaxe digs through stone like a knife through warm butter.");
		else addButtonDisabled(7, "Adamantine Pickaxe", "Req. 25,000+ gems and mining lvl 9+.");
		if (player.gems >= 50000 && player.miningLevel > 10 && player.hasItem(useables.SKYMETA, 4)) addButtonIfTrue(8, "Skymetal Pickaxe", curry(pickaxesType, 6), "You already have Skymetal Pickaxe.", player.hasKeyItem("Skymetal Pickaxe") < 0, "A pickaxe made of skymetal this tool is so good and rare as to be considered a national treasure. Not only is skymetal magic conductibility the best out of all metal but it has sharpness and hardness rivaling that of adamantine."+(silly()?" Steve and his netherite pickaxe has got nothing on you this is the one true ultimate mining tool.":"")+"");
		else addButtonDisabled(8, "Skymetal Pickaxe", "Req. 50,000+ gems, mining lvl 11+ and 4 Skymetal ore pieces.");
		addButton(14, "Finished!", shopSalamanderWares);
	}
	public function pickaxesType(type:Number):void {
		clearOutput();
		switch(type){
			case 1:
				outputText("The salamander picks up your gems and hands you a steel pickaxe.\n\n\"<i>Finaly decided to get on the mining job seriously too? Sure heres a quality pickaxe it'll at least be better then that piece of rusted metal you’ve been using until now.</i>\"");
				player.createKeyItem("Steel Pickaxe", 0, 0, 0, 0);
				player.gems -= 500;
				break;
			case 2:
				outputText("The salamander picks up your gems and hands you a moonstone pickaxe.\n\n\"<i>Now that's one hell of a good pickaxe, reacts to magical material too and can sniff it out even in broad daylight. Sure, here's a moonstone pickaxe.</i>\"");
				player.createKeyItem("Moonstone Pickaxe", 0, 0, 0, 0);
				player.gems -= 2000;
				break;
			case 3:
				outputText("The salamander picks up your gems and hands you a mithril pickaxe.\n\n\"<i>Now that's one hell of a good pickaxe you bought there, I wish you happy mining.</i>\"");
				player.createKeyItem("Mithril Pickaxe", 0, 0, 0, 0);
				player.gems -= 10000;
				break;
			case 4:
				outputText("The salamander picks up your gems and hands you an orichalcum pickaxe.\n\n\"<i>Not many of those around these days better take care of it. If I hear you got eaten by a sea monster don’t blame me for pillaging your remains to retrieve it back.</i>\"");
				player.createKeyItem("Orichalcum Pickaxe", 0, 0, 0, 0);
				player.gems -= 15000;
				break;
			case 5:
				outputText("The salamander picks up your gems and hands you an adamantine pickaxe.\n\n\"<i>Careful with that friend, this tool is precious enough for thieves to waylay you to get it. Honestly only ever known six people who could properly make use of this four of them travels with me and the sixth one is you.</i>\"");
				player.createKeyItem("Adamantine Pickaxe", 0, 0, 0, 0);
				player.gems -= 25000;
				break;
			case 6:
				outputText("The salamander looks at you astonished as you show him the Skymetal ores in your possession.\n\n\"<i>So you want a Skymetal pickaxe and you got the material to make one? Where in Marae's name did you find all that material. Well know what thats none of my business ill create the pickaxe for you but it will cost you. I'll be taking the 50 000 gems for crafting payment as well as those ores. Now just you wait I will make you a tool of legend</i>\"");
				outputText("\n\nThe salamander caravan suddenly set up in the area assembling a makeshift forge just to craft this one pickaxe. You can tell it's a big deal because of how excited they are at working with such a rare material. An hour later before your very eyes they unveil the blueish pickaxes of which the azure steel gleams with charged mana mining with this tool is gonna be like a dream you can tell that.");
				player.createKeyItem("Skymetal Pickaxe", 0, 0, 0, 0);
				player.destroyItems(useables.SKYMETA, 4);
				player.gems -= 50000;
				break;
		}
		doNext(pickaxes);
	}
}
}
