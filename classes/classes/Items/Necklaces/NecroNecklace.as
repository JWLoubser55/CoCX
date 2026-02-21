/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Necklace;
	import classes.Scenes.SceneLib;
	import classes.PerkLib;
	import classes.Player;
	
	public class NecroNecklace extends Necklace
	{
		
		public function NecroNecklace() 
		{
			super("NecroNe", "necronecklace", "necro necklace", "a necro necklace", 0, 0, 1200, "A simple necklace made from bones. Increases the user's mastery over animated bone constructs. \n\nType: Jewelry (Necklace) \nBase value: 4,500 \nSpecial: Increases control over skeletons of any normal size type by 3.", "Necklace");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equipNecroItemsSet();
			super.afterUnequip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if ((CoC.instance.player.perkv2(PerkLib.JobHaruspex) - 1) > SceneLib.campMakeWinions.maxSkeletonWarriors() || (CoC.instance.player.perkv1(PerkLib.BoneyBow) - 1) > SceneLib.campMakeWinions.maxSkeletonArchers() || (CoC.instance.player.perkv1(PerkLib.BoneyWand) - 1) > SceneLib.campMakeWinions.maxSkeletonMages()) {
				outputText("\n\nAfter unequipping the necro necklace, some of your skeletons fall apart due to insufficient control to sustain them. You gather the leftover bones for future use.  ");
				if ((CoC.instance.player.perkv2(PerkLib.JobHaruspex) - 1) > SceneLib.campMakeWinions.maxSkeletonWarriors()) {
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 2, -1);
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, 20);
				}
				if ((CoC.instance.player.perkv1(PerkLib.BoneyBow) - 1) > SceneLib.campMakeWinions.maxSkeletonArchers()) {
					CoC.instance.player.addPerkValue(PerkLib.BoneyBow, 1, -1);
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, 20);
				}
				if ((CoC.instance.player.perkv1(PerkLib.BoneyWand) - 1) > SceneLib.campMakeWinions.maxSkeletonMages()) {
					CoC.instance.player.addPerkValue(PerkLib.BoneyWand, 2, -1);
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, 20);
				}
			}
			SceneLib.setItemsChecks.unequipNecroItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
