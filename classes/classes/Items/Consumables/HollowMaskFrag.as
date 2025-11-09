/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables {
import classes.*;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

//Checks if the perk is present before use. Algo gives a prompt because why not.
public class HollowMaskFrag extends Consumable{

    public function HollowMaskFrag() {
        var descr:String;
        descr = "Shard of a Hollow's mask. You have seen them eat the other, down to the mask."
        super("HollowMaskFrag", "Hollow Mask fragment", "a Hollow Mask fragment", 200, descr );
    }

    override public function useItem():Boolean {
        clearOutput();
        if (!player.hasPerk(PerkLib.ExanimationII)) {
            outputText("You examine the hollow mask fragment. You know that the hollows like to consume them but you're sure there might be a use for it.");
            SceneLib.inventory.returnItemToInventory(this);
        }
		else {
            eatIt();
        }
        return true; //Wait for confirmation
    }

	public function eatIt():void {
		clearOutput();
		outputText("The mask fragment feels heavy in your [hands]. You note how weighty it is despite being a fraction of a whole. You look upon its curved white features, feeling a faint hum of soulforce pulsing in its ceramic texture—like it's breathing.\n\n");
		outputText("Your mask cracks open to reveal your lips, and as you place them upon it, the first thing that surprises you is the warmth that blossoms across your [face], and the strange sensation of its pulse puts you on edge. A strangled cacophony whispers hisses in your [ears] as it touches your [tongue].\n\n");
		outputText("A surge of soulforce detonates through your [body], raw and chaotic, but it wanes as soon as it arrives. The shard dissolves, merging with your own. Cracks seal. Lines of spiritual energy carve new ridges into its bonelike surface.\n\n");
		outputText("For a fleeting moment, you understand what it means to feed and to be fed upon.\n\n");
		player.addPerkValue(PerkLib.ExanimationII, 1, 10);
		if (player.perkv1(PerkLib.ExanimationII) > player.hollowFeedSoulPointsCap()) player.setPerkValue(PerkLib.ExanimationII, 1, player.hollowFeedSoulPointsCap());
		outputText("Soul points: "+player.perkv1(PerkLib.ExanimationII)+" / "+player.hollowFeedSoulPointsCap()+"");
        SceneLib.inventory.itemGoNext();
	}
}
}
