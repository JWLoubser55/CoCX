/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.PerkLib;

	public class ArchNecromancerCloak extends Armor {
		
		public function ArchNecromancerCloak() 
		{
			super("ArchNecC", "ArchNecromancerCloak", "Arch-Necromancer cloak", "an Arch-Necromancer cloak", 0, 1, 800, "An outfit once worn by a powerful necromancer. It is old and tattered yet still charged with magic. This cloak and set of jewelry doubles cold and dark damage at the expense of fire and lightning. While worn, increase spell power by 1% for every minion under your command and increase minion damage by 25%.", "Light");
				withBuffs({
					'teasedmg': 10
				});
				withTag(A_REVEALING);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) game.player.createPerk(PerkLib.Misdirection, 0, 0, 1, 0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if (game.player.perkv4(PerkLib.Misdirection) == 0 && game.player.perkv3(PerkLib.Misdirection) > 0) game.player.removePerk(PerkLib.Misdirection);
			super.afterUnequip(doOutput, slot);
		}
	}
}
