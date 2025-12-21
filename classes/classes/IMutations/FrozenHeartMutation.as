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

public class FrozenHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Frozen Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Allows you to retain any ice race learned abilities at all times and increase their damage by " + 25 * pTier + "%";
            }
            if (pTier >= 2){
                descS += ". Freeze effects last for ";
            }
            if (pTier >= 2){
                descS += "1 additional turn and cold racial skill recharges 1 turn";
            }
            if (pTier >= 3){
                descS += "2 additional turns and cold racial skill recharges 2 turns";
            }
            if (pTier >= 4){
                descS += "3 additional turns and cold racial skill recharges 3 turns";
            }
            if (pTier >= 2){
                descS += " faster. Gain an extra modifier from your intelligence to health (increase original value by " + 25 * (pTier - 1) + "%)";
            }
            if (pTier >= 4){
                descS += ". While in a cold or wet environment gain 2% stat regeneration";
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
                    this.requireHeartMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isRace(Races.YUKIONNA) || player.isRace(Races.YETI) || player.isRace(Races.DEER,2);
                    }, "Yuki Onna, Yeti, Deer (tier 2+) race");
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

        public function FrozenHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }

    }
}
