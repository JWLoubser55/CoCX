package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class MagicalTrainingXPerk extends PerkType
{
	
	override public function desc(params:PerkClass = null):String
	{
		if (!player || !params) return _desc;
		return "You have trained to better handle magical energies. (+1% to MaxOver Mana, MaxOver Wrath and +0.1% of Mana recovery every 3 levels up to +" + params.value1 * 10 + "%)";
	}

	override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.SPMysticalTrainingX).toString();
        return "Magical Training (Rank: " + sufval + ")";
    }

    public function MagicalTrainingXPerk() 
	{
		super("Magical Training","Magical Training", ".");
	}
}
}
