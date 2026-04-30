/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.Races;

public class EctoplasmicEssenceMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Ectoplasmic Essence";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Reduce Physical damage taken by " + (5 + (5 * pTier)) + "% after damage reduction";
			if (pTier >= 1 && pTier < 4) {
				descS += " but increase magical damage taken by ";
				if (pTier == 1) descS += "40%";
				if (pTier == 2) descS += "20%";
				if (pTier == 3) descS += "10%";
			}
			if (pTier >= 2) descS += ". Increase the potency of M.Ability with a soulforce cost by " + (5 * (pTier - 1)) + "0%";
            if (pTier >= 3) descS += ". Increase tease modifier by a percentage equal to ";
			if (pTier == 3) descS += "half of current lust percentage";
            if (pTier == 4) descS += "current lust percentage. Add your soulforce to your health but cause soulskills and specials using soulforce to also consume health in equal amounts";
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
                    .requireAnyRace(Races.POLTERGEIST, Races.BANSHEE);
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            if (pTier == 3) pBuffs['lib.mult'] = 0.15;
            if (pTier == 4) pBuffs['lib.mult'] = 0.2;
            return pBuffs;
        }

        public function EctoplasmicEssenceMutation() 
		{
			super(MNAME, SLOT_BLOODSTREAM, 4);
        }
        
    }
}
