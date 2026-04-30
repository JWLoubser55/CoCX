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

public class SalamanderAdrenalGlandsMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Salamander Adrenal Glands";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Your Salamander adrenal glands are giving you slight boosts to your natural stamina";
            if (pTier == 1) descS += " and libido";
            if (pTier >= 2) descS += ", strength, speed and libido, extend lustzerker and berserker duration by ";
            if (pTier == 2) descS += "2";
            if (pTier == 3) descS += "10";
			if (pTier == 4) descS += "20";
            if (pTier >= 2) descS += " turns";
            if (pTier >= 3) descS += ", allows for either or both to trigger on combat start, ";
            if (pTier == 3) descS += "double";
            if (pTier == 3) descS += "triple";
			if (pTier >= 3) descS += " bonus to attack, boost";
			if (pTier >= 3) descS += " slight";
            if (pTier >= 3) descS += " natural wrath generation rate";
            if (pTier == 4) descS += ". While lustzerking fire damage is increased by 50%";
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
                    this.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Lustzerker).requireAnyRace(Races.SALAMANDER, Races.PHOENIX, Races.KITSHOO);
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
            if (pTier == 1) {
                pBuffs['tou.mult'] = 0.05;
                pBuffs['lib.mult'] = 0.05;
            }
            else if (pTier == 2) {
                pBuffs['tou.mult'] = 0.1;
                pBuffs['lib.mult'] = 0.1;
                pBuffs['str.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            else if (pTier == 3) {
                pBuffs['tou.mult'] = 0.15;
                pBuffs['lib.mult'] = 0.15;
                pBuffs['str.mult'] = 0.2;
                pBuffs['spe.mult'] = 0.2;
            }
            else if (pTier == 4) {
                pBuffs['tou.mult'] = 0.2;
                pBuffs['lib.mult'] = 0.2;
                pBuffs['str.mult'] = 0.55;
                pBuffs['spe.mult'] = 0.55;
            }
            return pBuffs;
        }

        public function SalamanderAdrenalGlandsMutation() {
            super(MNAME, SLOT_ADRENALS, 4);
        }

    }
}
