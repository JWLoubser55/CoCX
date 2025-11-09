/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables {
import classes.*;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

//Checks if the perk is present before use. Algo gives a prompt because why not.
public class Leth2te extends Consumable {

    public function Leth2te() {
        var descr:String;
        descr = "A chunk of greater lethicite. It's rare as lethicite is only produced when a mortal becomes a demon and cums their souls out. A demon's favorite treat."
        super("Leth2te", "Greater Lethicite", "a chunk of greater lethicite", 5000, descr );
    }

    override public function useItem():Boolean {
        clearOutput();
        if (!player.hasPerk(PerkLib.SoulEater) && !player.hasPerk(PerkLib.Soulless) && !player.hasPerk(PerkLib.Phylactery) && !player.hasPerk(PerkLib.SpiritualHunger)) {
            outputText("You examine the pinkish-purple crystal. It must be lethicite. You know that the demons like to consume them but you're sure there might be a use for it.");
            SceneLib.inventory.returnItemToInventory(this);
        }
		else if (player.hasPerk(PerkLib.SpiritualHunger)) {
			eatItHollow();
		}
        else {
            eatItDemon();
        }
        return true; //Wait for confirmation
    }

    public function eatItHollow():void {
		clearOutput();
		outputText("You look at the purple crystal in your [hands], swirls of deeper hues dancing along its sharp edges. In another life, it could have been the key to owning a manor with ample acres and even serfs to till it for you. But here, on Mareth, you know that it is likely the product of some poor sod who succumbed to the temptations of a demon.\n\n");
		outputText("Regardless of its reality, it is a potent source of soul force. A fact that sings in your veins, the urge to break into the crystal alone sends you into a shiver.\n\n");
		outputText("Your mask cracks open to reveal your [lips], and as you place them upon it. Your vision swims with images of places you've never been and people you've never seen. Then a surge of spiritual energy flares within you. It batters you in waves of unrelenting pleasure. Shivers rip through you as convulsions rack your senses, a fierce display of satisfaction.\n\n");
		outputText("The world seemingly tilts as drowned voices crash at the edges of your mind. Then, silence. And the only thing you feel is a high that you are sure would send you on an out-of-body experience if you were mortal.\n\n");
		outputText("Your vision returns to normal, and the immense soul force cloaking you dissipates. Yet your eyes burn with the silver flame of a soul. The air bends around you. For a fleeting instant, you understand what it means to feed and to be fed upon, and why hollows would go out of their way to hunt demons.\n\n");
		player.addPerkValue(PerkLib.ExanimationII, 1, 25);
		if (player.perkv1(PerkLib.ExanimationII) > player.hollowFeedSoulPointsCap()) player.setPerkValue(PerkLib.ExanimationII, 1, player.hollowFeedSoulPointsCap());
		outputText("Soul points: "+player.perkv1(PerkLib.ExanimationII)+" / "+player.hollowFeedSoulPointsCap()+"");
        SceneLib.inventory.itemGoNext();
	}
    public function eatItDemon():void {
        clearOutput();
        outputText("You grab the crystal and gulp it down, smiling contently as you feel it dissolve into your core and suffuse your body with raw power.");
		var gains:Number = 250;
		if (player.hasPerk(PerkLib.Phylactery)) gains *= 0.5;
		if (player.hasPerk(PerkLib.LethiciteConnoisseur)) gains *= 2;
		if (player.demonicenergy + gains > player.maxDemonicEnergy()) gains = player.maxDemonicEnergy() - player.demonicenergy;
		player.demonicenergy += gains;
		outputText(" (+"+gains+" DE)");
        SceneLib.inventory.itemGoNext();
    }
}
}
