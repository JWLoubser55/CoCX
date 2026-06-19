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

public class CelestialBloodMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Celestial Blood";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var below:Number = 50;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 4) below -= 25;
            if (pTier >= 1) descS += "Increase mana regeneration by "+(pTier*5)+"0% of its total regeneration rate but double spell cost";
			if (pTier >= 2) descS += ". While Mana is above "+(5-pTier)+"0% Increase spell damage by "+((pTier-1)*5)+"0%";
            if (pTier >= 3) descS += ". While mana is above "+below+"% increase health regeneration by "+(pTier-2)+"%";
            if (pTier >= 4) descS += ". While Mana is at 75% or above, spell total damage is Increased by 100%";
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
                    .requireCor(-100).requireRace(Races.AZAZEL);
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

        public function CelestialBloodMutation() 
		{
			super(MNAME, SLOT_BLOODSTREAM, 4);
        }
        
    }
}
