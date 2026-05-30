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

public class WyrmMusculatureMutation extends IMutationPerkType
	{
		public static const MNAME:String = "Wyrm Musculature";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1){
				descS += "Increase total strength by "+(pTier*5)+"% but reduce intelligence by the same amount";
			}
            if (pTier >= 2){
                descS += ". Physical ability damage is increased by "+((pTier-1)*5)+"0%";
            }
            if (pTier >= 3){
                descS += ". Leap only consumes "+pTier+"% of the wrath it should";
            }
            if (pTier >= 4){
                descS += ". Leap has a 100% increased chance of critical strike";
            }
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
                    .requireAnyRace(Races.FROSTWYRM, Races.MAGMAWYRM, Races.SANDDRAKE);
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
            if (pTier == 2) pBuffs['str.mult'] = 0.10;
            if (pTier == 3) pBuffs['str.mult'] = 0.15;
            if (pTier == 4) pBuffs['str.mult'] = 0.20;
            return pBuffs;
        }

        public function WyrmMusculatureMutation() 
		{
			super(MNAME, SLOT_MUSCLE, 2);
		}
		
	}

}