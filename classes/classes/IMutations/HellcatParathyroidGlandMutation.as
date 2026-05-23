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

public class HellcatParathyroidGlandMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Hellcat Parathyroid Glands";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Increase Fire and dark damage by "+(pTier*5)+"0% when in rut or in heat";
            if (pTier >= 2) descS += ". Increase the libido gain from heat and rut by "+((pTier-1)*5)+"0%";
            if (pTier >= 3) descS += ". Gain "+(pTier-2)+"% mana regeneration when in heat or in rut";
            if (descS != "")descS += ". Add the bonus from heat and rut to intelligence as well";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireParathyroidGlandMutationSlot()
                    .requireRace(Races.HELLCAT);
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
			if (pTier == 2) pBuffs['lib.mult'] = 0.10;
			if (pTier == 3) pBuffs['lib.mult'] = 0.15;
            if (pTier == 4) pBuffs['lib.mult'] = 0.20;
            return pBuffs;
        }

        public function HellcatParathyroidGlandMutation() {
            super(MNAME, SLOT_PARATHYROID, 4);
        }

    }
}
