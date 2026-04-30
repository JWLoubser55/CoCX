/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Shield;
	import classes.Scenes.SceneLib;
	import classes.PerkLib;
	import classes.Player;
	
	public class NecroShield extends Shield
	{
		
		public function NecroShield() 
		{
			super("NecroSh", "necroshield", "necro shield", "a necro shield", 5, 1000, "A simple shield made from bones. Increase user mastery over animated bone constructs.");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equipNecroItemsSet();
			super.afterUnequip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if ((CoC.instance.player.perkv2(PerkLib.JobHaruspex) - 1) > SceneLib.campMakeWinions.maxSkeletonWarriors() || (CoC.instance.player.perkv1(PerkLib.BoneyBow) - 1) > SceneLib.campMakeWinions.maxSkeletonArchers() || (CoC.instance.player.perkv1(PerkLib.BoneyWand) - 1) > SceneLib.campMakeWinions.maxSkeletonMages()) {
				outputText("\n\nAfter unequipping the necro shield, some of your skeletons fall apart due to insufficient control to sustain them. You gather the leftover bones for future use.  ");
				if ((CoC.instance.player.perkv2(PerkLib.JobHaruspex) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxSkeletonWarriors() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 2, -SceneLib.campMakeWinions.maxSkeletonMulti());
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
				}
				if ((CoC.instance.player.perkv1(PerkLib.BoneyBow) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxSkeletonArchers() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
					CoC.instance.player.addPerkValue(PerkLib.BoneyBow, 1, -SceneLib.campMakeWinions.maxSkeletonMulti());
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
				}
				if ((CoC.instance.player.perkv1(PerkLib.BoneyWand) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxSkeletonMages() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
					CoC.instance.player.addPerkValue(PerkLib.BoneyWand, 2, -SceneLib.campMakeWinions.maxSkeletonMulti());
					CoC.instance.player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
				}
			}
			SceneLib.setItemsChecks.unequipNecroItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
