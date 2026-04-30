/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.PerkLib;
import classes.Races;

public class CaveWyrmAcidMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Cave Wyrm Acid";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Your fluids are a highly volatile acidic compound. You can burn hp to gain wrath periodically at the rate of ";
            if (pTier == 1) descS += "" + pTier + "% to " + (pTier * 2) + "%";
			if (pTier >= 2) descS += "" + (pTier * 2) + "% to " + (pTier * 4) + "%. While wrath is above 90% increases physical damage by " + ((pTier - 1) * 25) + "%";
            if (pTier >= 3) descS += ". Increase Nitroblade damage by " + (pTier - 2) + "00%";
			if (pTier >= 4) descS += ". While affected by Nitroblade the acid sharpens the edge and cleans it of grime increasing critical damage by 1x. Nitroblade acid is even more volatile, increasing the chance of explosion by 10%";
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
                    this.requireBloodsteamMutationSlot()
                    .requireRace(Races.CAVEWYRM);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.1;
            else if (pTier == 2) pBuffs['str.mult'] = 0.3;
            else if (pTier == 3) pBuffs['str.mult'] = 0.7;
            else if (pTier == 4) pBuffs['str.mult'] = 1.0;
            return pBuffs;
        }

        public function CaveWyrmAcidMutation() {
            super(MNAME, SLOT_BLOODSTREAM, 4);
        }

    }
}
