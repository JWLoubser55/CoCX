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

public class TrachealSystemMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Tracheal System";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var ml1:Number = 5;
			var ml2:Number = 15;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) ml1 += 10;
            if (pTier >= 3) ml1 += 15;
            if (pTier >= 4) {
				ml1 += 20;
				ml2 += 30;
			}
            if (pTier >= 1) descS += "Your body possesses a ";
            if (pTier == 1) descS += "rudimentary";
            if (pTier == 2) descS += "basic";
            if (pTier == 3) descS += "half developed";
            if (pTier == 4) descS += "fully developed";
            if (pTier >= 1) descS += " respiratory system modeled after insects";
            if (descS != "")descS += ".";
			if (pTier >= 1) descS += " (+"+ml1+"% to Spe";
			if (pTier >= 3) descS += ", +"+ml2+"% max core spe as phantom spe";
			if (pTier >= 4) descS += ". Increases maximum base/core (30) and trainable Spe (30%)";
			if (pTier >= 1) descS += ")";
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
                    .requireRacialGroup(Races.InsectRaces, "Any insect race");
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
                pBuffs['str.mult'] = 0.01;
                pBuffs['spe.mult'] = 0.02;
            }
            else if (pTier == 2){
                pBuffs['str.mult'] = 0.03;
                pBuffs['spe.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.01;
            }
            else if (pTier == 3){
                pBuffs['str.mult'] = 0.07;
                pBuffs['spe.mult'] = 0.1;
                pBuffs['tou.mult'] = 0.04;
            }
            else if (pTier == 4){
                pBuffs['str.mult'] = 0.15;
                pBuffs['spe.mult'] = 0.2;
                pBuffs['tou.mult'] = 0.1;
            }
            return pBuffs;
        }

        public function TrachealSystemMutation() {
            super(MNAME, SLOT_ADAPTATIONS, 4);
        }

    }
}
