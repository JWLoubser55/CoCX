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

public class LizanMarrowMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Lizan Marrow";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Regenerate +"+pTier+"% of HP per round in combat and +"+(pTier*2)+"% of HP per hour. Additionally your limit for innate self-regeneration rate increased";
            }
            if (pTier == 3){
                descS = ". When below 25% of max HP regeneration provided by Lizan regeneration is 2x. You can't lose by HP until your health drops into the negatives more than 5% of max HP";
            }
            if (pTier == 4){
                descS = ". When below 60%/20% of max HP regeneration provided by Lizan regeneration is 2x/3x. Could slowly recover lost bodyparts (~1/2% per combat round/hour). You can't lose by HP until your health drops into the negatives more than 10% of max HP, +10% OverMax HP";
            }
            if (descS != "")descS += ".";
            if (pTier >= 1) descS += " (Lizan race gaining extra profits: +1 to multi of the regeneration values per reached race bonuses tier (excluding increased HP recover below specific HP tresholds))";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireBonesAndMarrowMutationSlot()
                    .requirePerk(PerkLib.LizanRegeneration)
					.requireAnyRace(Races.LIZARD, Races.CHAMELEON);
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
			if (pTier == 1){
                pBuffs['tou.mult'] = 0.01;
            }
            else if (pTier == 2){
                pBuffs['tou.mult'] = 0.03;
            }
            else if (pTier == 3){
                pBuffs['tou.mult'] = 0.07;
            }
            else if (pTier == 4){
                pBuffs['tou.mult'] = 0.15;
            }
            return pBuffs;
        }

        public function LizanMarrowMutation() {
            super(MNAME, SLOT_BONE, 4);
        }

    }
}
