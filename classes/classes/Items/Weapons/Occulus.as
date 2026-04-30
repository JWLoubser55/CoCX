package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class Occulus extends Weapon implements TimeAwareInterface
	{
		//Implementation of TimeAwareInterface
        //Recalculate Wizard's multiplier every hour
		public function timeChange():Boolean
		{
			updateWizardsMult();
			return false;
		}

		public function timeChangeLarge():Boolean {
            updateWizardsMult();
			return false;
		}

        //Normal weapon stuff
		public function Occulus()
		{
			super("Occulus", "Occulus", "Occulus", "an Occulus", "bonk", 10, 1600,
					"A wand rumored to have been the favored catalyst of the now missing god of magic. The Occulus is said to have been used as early as the genesis of Mareth. It was made to create, not to destroy, and performs best when casting restorative magic. (Greatly empowers healing spells, increases Spellpower based on purity)",
					WT_WAND, WSZ_MEDIUM
			);
			withBuff('spellpower', +1.0);
			withTag(I_LEGENDARY);
			EventParser.timeAwareClassAdd(this);
		}

		public function calcWizardsMult():Number {
			var multadd:Number = 1.0;
            if (game && game.player) multadd += (game.player.playerCorruption2() - game.player.playerCorruption()) * 0.02;
			return multadd;
		}

        private static var lastCor:Number = 200;

        public function updateWizardsMult():void {
            if (game.player.playerCorruption() != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == game.weapons.OCCULUS) {
                    //re-requip to update player's perk
	                var slot:int = game.player.slotOfEquippedItem(this);
                    afterUnequip(false, slot);
                    afterEquip(false, slot);
                }
            }
            lastCor = game.player.playerCorruption();
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor > 50 ? "\n\nYour demonic aura almost breaks the flow of energy inside the wand, decreasing its power!\n" :
                    game.player.cor > 0 ? "\n\nYour corrupted aura interrupts your connection with the wand, decreasing its power.\n" :
                    game.player.cor > -50 ? "\n\nYour aura slightly distorts the wand's energy flow, not allowing you to use its full power.\n" :
                    "\n\nYour pure energy flows through the wand, empowering it!\n");
            else
                return _description;
        }
		
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 50;
			if (game.player.str >= 50) {
				boost += 4;
				scal -= 10;
			}
			boost += Math.round(game.player.playerCorruption() / scal);
			return (1 + boost);
		}

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
