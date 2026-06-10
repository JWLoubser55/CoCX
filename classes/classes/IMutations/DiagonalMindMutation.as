/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.Player;
import classes.Races;

public class DiagonalMindMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Diagonal Mind";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1 && pTier < 4) descS += "When you deny defeat by damage you instead take "+(pTier * 2)+"0% less lust damage as a recoil";
            if (pTier >= 2) descS += " x2";
            if (pTier >= 3) descS += " x3";
            if (pTier >= 4) descS += " x2";
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
                    this.requirePeripheralNervSysMutationSlot()
                    .requireRace(Races.CHESHIRE);
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

        public function DiagonalMindMutation() {
            super(MNAME, SLOT_NERVSYS, 1);
        }

    }
}
