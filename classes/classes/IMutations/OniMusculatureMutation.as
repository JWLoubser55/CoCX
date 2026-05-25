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

public class OniMusculatureMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Oni Musculature";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var tone:Number = 10;
			var dmgMult:Number = 4;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) tone += 20;
			if (pTier >= 3) {
				tone += 30;
				dmgMult += 2;
			}
            if (pTier >= 1) descS += "Your altered musculature allows you to increase your natural strength and tone (+"+tone+"). Oni Rampage and Drunker Power req. only ";
			if (pTier == 1) descS += "6";
			if (pTier >= 2) descS += "3";
			if (pTier >= 1) descS += "+ pts in Oni score";
            if (pTier >= 2) descS += " and dmg multi from Oni Rampage increased to "+dmgMult+"x";
            if (pTier >= 3) descS += ", its duration is increased by 3 turns and its cooldown is decreased by 3 turns. Drunken Power boost increased to 6x";
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
                    this.requireMusclesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tone >= 100;
                    }, "100+ tone")
                    .requireRace(Races.ONI);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.3;
            if (pTier == 4) pBuffs['str.mult'] = 0.7;
            return pBuffs;
        }

        public function OniMusculatureMutation() {
            super(MNAME, SLOT_MUSCLE, 3);
        }
        
    }
}
