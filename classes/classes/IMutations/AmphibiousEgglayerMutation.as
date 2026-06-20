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

public class AmphibiousEgglayerMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Amphibious Egglayer";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            var maxL:Number = 10;
			var res:Number = 5;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Make the Egg Carrier ability permanent and gain a +"+(pTier*25)+"% toughness while carrying Eggs or +"+(pTier*25)+"% Speed while Empty";
            if (pTier >= 2) descS += ", +"+res+"% to lust resistance, ";
            if (pTier >= 3) descS += ", increase milk production by ~150%";
            if (pTier >= 4) descS += ", increase milk production by ~200%";
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
                    this.requireOvariesMutationSlot()
                    requireCustomFunction(function (player:Player):Boolean {
                        return player.hasVagina();
                    }, "is Female")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity >= 95;
                    }, "95+ feminity")
                    .requireRace(Races.FROG);
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
            if (pTier == 3) pBuffs['lib.mult'] = 0.2;
            if (pTier == 4) pBuffs['lib.mult'] = 0.4;
            return pBuffs;
        }

        public function AmphibiousEgglayerMutation() 
		{
			super(MNAME, SLOT_NONE, 1);//SLOT_OVARIES
        }

    }
}
