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

public class SoulCoreMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Soul Core";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var perkCent:int = 1;
			var perkCent1:int = 50;
			var perkCent2:int = 25;
			var perkCent3:int = 2;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) perkCent += 1;
			if (pTier >= 3) {
				perkCent += 1;
				perkCent2 += 25;
			}
			if (pTier >= 4) {
				perkCent += 2;
				perkCent1 += 25;
				perkCent2 += 50;
				perkCent3 += 2;
			}
            if (pTier >= 1) descS += "Gain " + perkCent + " % mana regeneration";
            if (pTier >= 2) descS += ". While above " + perkCent1 + " % of your total mana gain a " + perkCent2 + " % increase to all physical damage";
            if (pTier >= 3) descS += ". While under " + perkCent1 + "% of your total fatigue gain a " + perkCent2 + " % increase to all magical damage. Gain regeneration " + perkCent3 + "% while mana is above 50%";
            if (pTier >= 4) descS += ". Add intelligence to your toughness score for the purpose of calculating hit points";
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
                    .requireAnyRace(Races.GARGOYLE, Races.AUTOMATA);
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
            else if (pTier == 2) pBuffs['tou.mult'] = 0.1;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 4) pBuffs['tou.mult'] = 0.2;
            return pBuffs;
        }

        public function SoulCoreMutation() {
            super(MNAME, SLOT_ADAPTATIONS, 4);
        }

    }
}
