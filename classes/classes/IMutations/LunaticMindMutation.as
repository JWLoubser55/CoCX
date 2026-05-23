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

public class LunaticMindMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Lunatic mind";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            //var perChg:int = 5 * pTier
            var descS:String = "";
			if (pTier >= 1) descS += "Gain a static percentage bonus to speed and strength based on moon phase between "+(pTier*5)+"0 and -50";
			if (pTier >= 2) descS += ". Gain "+((pTier-1)*0.5)+"% regeneration";
			if (pTier >= 3) descS += ". Sneak attack is improved by +"+(pTier-2)+"x";
			if (pTier >= 4) descS += "";
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
                    .requireAnyRace(Races.WEREWOLF, Races.WERESHARK, Races.WERECAT);
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
			if (pTier == 2) pBuffs['lib.mult'] = 0.10;
			if (pTier == 3) pBuffs['lib.mult'] = 0.15;
            if (pTier == 4) pBuffs['lib.mult'] = 0.20;
            return pBuffs;
        }

        public function LunaticMindMutation() 
		{
			super(MNAME, SLOT_NERVSYS, 2);
        }

    }
}
