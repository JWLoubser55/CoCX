/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class HumanLungsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Lungs";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var perkCent:int = 1 + pTier;
			if (pTier >= 4) perkCent += 1;
            if (pTier >= 1) descS += "Your lungs have been enhanced in both size and strength, increasing your endurance ";
            if (pTier == 1) descS += "slightly ";
			if (pTier == 2) descS += "somewhat ";
			if (pTier == 4) descS += "greatly ";
			if (pTier >= 1){
				descS += "("+perkCent+"%), ";
			}
            if (pTier < 4) descS += "as well as aiding your metabolism in filtering toxins";
			if (pTier >= 4) descS += "aiding your metabolism in filtering toxins, and gives you the ability to breathe underwater, having been mutated away from humanity just enough to allow it";
            if (descS != "")descS += ".";
            if (pTier >= 1) descS += " (req. 18+ human score to have all effects active)";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireLungsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.HUMAN) > 16;
                    }, "Human race (17+)");
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
			if (player.racialScore(Races.HUMAN) > 17) {
				if (pTier == 1) pBuffs['spe.mult'] = 0.05;
				if (pTier == 2) pBuffs['spe.mult'] = 0.1;
				if (pTier == 3) pBuffs['spe.mult'] = 0.2;
				if (pTier == 4) pBuffs['spe.mult'] = 0.4;
			}
            return pBuffs;
        }

        public function HumanLungsMutation()
		{
			super(mName + " IM", mName, SLOT_LUNGS, 2);
        }
        
    }
}
