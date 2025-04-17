package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class AbsorbNutrientPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String {
			if (!player || !params) return _desc;
			var descS:String = "You are ";
			if (params.value1 > 6) descS += "a royal myconid. Increase Total intelligence by 50%, +200% total sensitivity, Increase servant damage by 200%, Gain Regeneration 1% and Esper ability are 50% stronger. You can control up to 30 Matango. ";
			else if (params.value1 > 5) descS += "a royal myconid. Increase Total intelligence by 40%, +175% total sensitivity, increase servant damage by 100% and gain Regeneration 0.5%. You can control up to 20 Matango. ";
			else if (params.value1 > 4) descS += "a high noble myconid. Increase total intelligence by 30%, +150% total sensitivity, increase servant damage by 50%. You can control up to 15 Matango. ";
			else if (params.value1 > 3) descS += "a noble myconid. Increase total intelligence by 20% +125% total sensitivity. You can control up to 10 Matango. ";
			else if (params.value1 > 2) descS += "an evolved matango. Your intelligence is as good as that of a common human +100% total sensitivity. You can control up to 5 Matango. ";
			else if (params.value1 > 1) descS += "currently an ordinary matango with a fully grown mushroom cap. -25% total intelligence +75% total sensitivity. ";
			else if (params.value1 > 0) descS += "currently an ordinary matango with a mushroom cap. -50% total intelligence, +50% total sensitivity. ";
			else descS += "currently an ordinary matango with a small mushroom cap. -100% total intelligence. ";
            descS += " You are fed and healed by bodily fluids. Recover health, mana, soulforce and fatigue from harvesting sexual fluids. As you absorb more nutrients your mushroom cap will also grow granting your increasing abilities.";
			return descS;
		}

		public function AbsorbNutrientPerk() 
		{
			super("Absorb nutrient", "Absorb nutrient",
					"NOT RELEVANT TEXT");
		}
		
	}

}