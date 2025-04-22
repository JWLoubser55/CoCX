/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

    public class PlantChlorophyllMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Plant Chlorophyll";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var perkCent1:int = pTier;
			var perkCent2:int = pTier - 1;
			if (pTier >= 4) perkCent1 += 1;
            if (pTier >= 1) descS += "For plants, increase all recovery effects (mana, hp, sf, wrath, fatigue) by "+(pTier * 5)+"% while outdoors during daytime";
            if (pTier >= 2) descS += ". Plant abilities are increased by "+perkCent1+"0%";
            if (pTier >= 3) descS += ". Synthesis is "+perkCent1+"0% stronger";
            if (pTier >= 4) descS += " and can be auto cast";
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
                    this.requireFatTissueMutationSlot()
					.requireRace(Races.MYCONID);
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
            else if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            else if (pTier == 3) pBuffs['lib.mult'] = 0.15;
            else if (pTier == 4) pBuffs['lib.mult'] = 0.2;
            return pBuffs;
        }

        public function PlantChlorophyllMutation() {
            super(mName + " IM", mName, SLOT_FAT, 4);
        }

    }
}
