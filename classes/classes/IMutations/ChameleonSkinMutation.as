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

public class ChameleonSkinMutation extends IMutationPerkType
	{
		public static const MNAME:String = "Chameleon Skin";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Increase sneak attack damage multiplier by "+pTier+"x";
            if (pTier >= 2) descS += ". The camouflage skill lasts "+(pTier-1)+" more round";
            if (pTier >= 3) descS += "half developed";
            if (pTier >= 4) descS += "fully developed";
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
                    this.requireAdaptationsMutationSlot()
                    .requireRace(Races.CHAMELEON);
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
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.10;
            if (pTier == 3) pBuffs['spe.mult'] = 0.15;
            if (pTier == 4) pBuffs['spe.mult'] = 0.20;
            return pBuffs;
        }

        public function ChameleonSkinMutation() 
		{
			super(MNAME, SLOT_ADAPTATIONS, 1);
        }

    }
}
