package classes.Scenes.Areas.VolcanicCrag {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.internals.SaveableState;

public class SalamanderOreMerchants extends BaseContent implements SaveableState{

    public static var VisitedCount:int;
    public function stateObjectName():String {
        return "SalamanderOreMerchants";
    }

    public function resetState():void {
        VisitedCount = 0;
    }

    public function saveToObject():Object {
        return {
            "VisitCount": VisitedCount
        };
    }
    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o){
            VisitedCount = o["VisitCount"];
        }
    }

    public function SalamanderOreMerchants() {
    }

    public function introOreMerchant():void{
        clearOutput();

        outputText("As you explore the crag you run into a group of salamanders, a single male and two females. ");
        if(VisitedCount == 0 && flags[kFLAGS.HEL_TIMES_ENCOUNTERED] > 0){
            outputText("At first you expected them to draw their scimitar and run at you screaming savagely like Helia but turns out that’s not as common a thing as you thought.");
        }
        outputText("They wave at you before coming closer. The male, well ripped and equipped with a massive pickaxe which must serve as both a weapon and a harvesting tool greets you.\n");
        outputText("\"Well met traveler, we are peddlers traveling the region to gather and sell minerals. You seem to be an adventurer so if I may ask, are you perhaps interested in our products?\"\n");
        outputText("Funnily you thought everyone in the salamander society was either a blacksmith or a warrior but you guess they need somebody to mine material if they are to forge something. Maybe you should browse his wares?");
        VisitedCount++

        addButton(1, "Shop", shopSalamanderWares);
        addButton(3, "No, thanks!", unShop);
    }

    public function unShop(boughtStuff:Boolean = false):void{
        clearOutput()
        if (!boughtStuff) outputText("You aren’t looking for any of those at the time so you bid the ore peddlers farewell for now as you resume your exploration.");
        else outputText("You thank the salamander group, and go on your way with your haul.");
        endEncounter();
    }

    public function shopSalamanderWares():void{
        clearOutput();
        outputText("As you voice your interest the salamander grabs a parchment and hands you over what appears to be a list of materials.\n");
        outputText("\"If any of those catch your eyes let me know, I got large quantities of those in my bag of hoarding and would be willing to trade them for the right amount of gems. I also sell pickaxes if that's up your alley.\"\n");

        //insertshopmenuhere
        addButton(14, "Finished!", unShop,true);
    }

}
}
