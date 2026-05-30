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

public class WyrmCursedBloodMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Wyrm Cursed Blood";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var ruin:Number = 2;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) ruin += 2;
			if (pTier >= 3) ruin += 4;
			if (pTier >= 4) ruin += 8;
            if (pTier >= 1) descS += "Your blood becomes ruinous cursing those who wound you with ill fate. When taking damage, inflict a "+ruin+"% strength drain as a backlash";
			if (pTier >= 2) descS += ". If you got a dragon mouth or fang you can inject your blood into opponents as part of your natural attack dealing "+ruin+"% drain as a continuous poison effect";
            if (pTier >= 3) descS += ". You gain regeneration %";
            if (pTier >= 4) descS += ". You recover from all stat damage";
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
                    .requireAnyRace(Races.FROSTWYRM, Races.MAGMAWYRM, Races.SANDDRAKE);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.1;
            if (pTier == 3) pBuffs['tou.mult'] = 0.15;
            if (pTier == 4) pBuffs['tou.mult'] = 0.2;
            return pBuffs;
        }

        public function WyrmCursedBloodMutation() 
		{
			super(MNAME, SLOT_BLOODSTREAM, 1);
        }
        
    }
}
