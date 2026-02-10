/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;

public class MutationTemplate extends IMutationPerkType
    {
		public static const MNAME:String = "PerkName Here";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += ", ";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (pTier >= 4){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }


        //Mutations Buffs
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            //if (player.perkv3(this) == 1){} //This checks in player has the "true" mutation.
            /*
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 2){
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 3){
                pBuffs['spe.mult'] = 0;
            }*/
            return pBuffs;
        }

        public function MutationTemplate() {
            // replace SLOT_NONE with other SLOT_XXXX constant
            super(MNAME, SLOT_NONE, 3);
        }

    }
}
