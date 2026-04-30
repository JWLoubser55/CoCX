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

public class HumanSecondaryHeart extends IMutationPerkType
    {
		public static const MNAME:String = "Human Secondary Heart";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var perkCent:int = 1 + pTier;
			if (pTier >= 3) perkCent += 1;
			if (pTier >= 4) perkCent += 4;
            if (pTier >= 3){
                descS += "You’ve been given a secondary heart, the newly added organ pumping in tandem with the original. Your health and fatigue recovery are increased ";
            }
            else {
                descS += "Your heart grew " + (pTier == 1 ? "slightly":"almost doubled") +  " in size. Your health and fatigue recovery are increased ";
            }
			if (pTier == 1) descS += "a bit";
			else if (pTier == 2) descS += "slightly";
			else if (pTier == 4) descS += "greatly ";
			if (pTier >= 3){
				descS += "("+perkCent+"%) as the new heart ";
			}
            // bit unhealthy innit
            // if (pTier == 1) descS += "struggles to find its rhythm alongside your first";
            // if (pTier == 2) descS += "begins to find its rhythm alongside your first";
			if (pTier == 3) descS += "adapted to the rhythm of the original";
			else if (pTier == 4) descS += "pumps in perfect opposition to your original. As your secondary heart has grown to rival the first, the first time you would lose in combat, prevent that loss and continue on with 1HP as your secondary heart takes the full weight of running your body until your win or lose a second time";
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
                    this.requireHeartMutationSlot()
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
				if (pTier == 1) pBuffs['tou.mult'] = 0.13;
				if (pTier == 2) pBuffs['tou.mult'] = 0.25;
				if (pTier == 3) pBuffs['tou.mult'] = 0.5;
				if (pTier == 4) pBuffs['tou.mult'] = 1.0;
			}
            return pBuffs;
        }

        public function HumanSecondaryHeart() 
		{
			super(MNAME, SLOT_HEART, 4);
        }
        
    }
}
