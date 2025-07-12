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
			super("Qulipot", "Qulipoth", "Qulipoth", "a Qulipoth", "bonk", 160, 19200,
					"A massive staff made from a bought of the first tentacle tree. It channels green magic. Increase in potency with corruption. (+250% spell cost, spellpower bonus scales with corruption)",
					WT_STAFF, WSZ_MASSIVE);
			withBuff('spellpower', +1.5);
			withTags(W_MGWRATH, I_LEGENDARY, W_PURE_TYPE);
			withEffect(IELib.AttackBonus_Cor,1/10);
			withEffect(IELib.ScaleAttack_Str,60);
			EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 1.5;
            if (game && game.player) multadd += game.player.cor * 0.01;
			return multadd;
		}

        private static var lastCor:Number = 0;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
                    //re-requip to update player's perk
	                var slot:int = game.player.slotOfEquippedItem(this);
					afterUnequip(false, slot);
					afterEquip(false, slot);
                }
                lastCor = game.player.cor;
            }
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor < 25 ? "\n\nYour pure aura almost breaks the flow of energy inside the staff, decreasing its power!\n" :
                    game.player.cor < 50 ? "\n\nYour pure aura slightly interrupts your connection with the staff, decreasing its power.\n" :
                    game.player.cor < 75 ? "\n\nYour corrupted aura slightly increases the staff's power.\n" :
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
