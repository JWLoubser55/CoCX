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

public class WendigoMetabolismMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Wendigo Metabolism";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Gain High regeneration (2%) but make Endless hunger permanent";
            }
            if (pTier >= 2){
                descS += ". Regeneration is further increased (" + pTier + "%) but so is the hunger (" + (15 * (pTier - 1)) + "%)";
            }
            if (pTier >= 1){
                descS += ". Feeding now increases toughness and strength up to " + (5 * pTier) + "0% more and the increment increased to " + (pTier + 1) + "% per stack";
            }
            if (pTier >= 2){
                descS += ". Increase the duration of spectral scream to 3 rounds";
            }
            if (pTier >= 3){
                descS += ". Spectral Scream and Possess gains an increased modifier based on your combined strength and toughness and have their cooldowns reduced by ";
            }
            if (pTier == 3){
                descS += "1 increment";
            }
            if (pTier == 4){
                descS += "2 increments";
            }
            if (pTier >= 4){
                descS += ". Do four more claw attacks when hunger is mostly sated (90%+)";
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
                    this.requireMetabolismMutationSlot()
                    .requireRace(Races.WENDIGO);
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
            return pBuffs;
        }

        public function WendigoMetabolismMutation() {
            super(MNAME, SLOT_METABOLISM, 4);
        }

    }
}
