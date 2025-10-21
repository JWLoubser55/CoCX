package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class MysticalTrainingXPerk extends PerkType
{
	
	override public function desc(params:PerkClass = null):String
	{
		if (!player || !params) return _desc;
		return "You have trained to better handle mystical energies. (+1% to MaxOver Soulforce, MaxOver Fatigue and +0.1% of Soulforce recovery every 3 levels up to +" + params.value1 * 10 + "%)";
	}

	override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.SPMysticalTrainingX).toString();
        return "Mystical Training (Rank: " + sufval + ")";
    }

    public function MysticalTrainingXPerk() 
	{
		super("Mystical Training","Mystical Training", ".");
	}
}
}
