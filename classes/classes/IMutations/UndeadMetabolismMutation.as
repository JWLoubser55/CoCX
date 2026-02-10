/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkType;

public class UndeadMetabolismMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Undead Metabolism";
		override public function get mName():String {
			return MNAME;
		}
		
		public function UndeadMetabolismMutation() 
		{
			super(MNAME, SLOT_NONE, 1);
		}
        
    }
}
