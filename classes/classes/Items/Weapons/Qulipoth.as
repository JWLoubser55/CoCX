package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.EventParser;
import classes.TimeAwareInterface;

	public class Qulipoth extends Weapon implements TimeAwareInterface {
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
		public function Qulipoth() 
		{
			super("Qulipot", "Qulipoth", "Qulipoth", "a Qulipoth", "bonk", 180, 86400,
					"A massive staff made from a bought of the first tentacle tree. It channels green magic. Increase in potency with corruption. (+600% spell cost, spellpower bonus scales with corruption, increase Tease damage from spells by 50%, increase Tease damage from spells by 50%, increase the duration of Death Blossom by 2 rounds)",
					WT_STAFF, WSZ_MASSIVE);
			withBuff('spellpower', +3.0);
			withTags(W_MGWRATH, I_LEGENDARY, W_CORRUPT_TYPE);
			withEffect(IELib.AttackBonus_Cor,1/10);
			withEffect(IELib.ScaleAttack_Str,60);
			EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 3.0;
            if (game && game.player) multadd += game.player.playerCorruption() * 0.015;
			return multadd;
		}

        private static var lastCor:Number = 0;

        public function updateWizardsMult():void {
            if (game.player.playerCorruption() != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
                    //re-requip to update player's perk
	                var slot:int = game.player.slotOfEquippedItem(this);
					afterUnequip(false, slot);
					afterEquip(false, slot);
                }
                lastCor = game.player.playerCorruption();
            }
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor < -50 ? "\n\nYour pure aura almost breaks the flow of energy inside the staff, decreasing its power!\n" :
                    game.player.cor < 0 ? "\n\nYour pure aura slightly interrupts your connection with the staff, decreasing its power.\n" :
                    game.player.cor < 50 ? "\n\nYour corrupted aura slightly increases the staff's power.\n" :
                    "\n\nYour corrupted energy flows throgh the staff, empowering it!\n");
            else
                return _description;
        }
		

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
