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

public class HumanEyesMutation extends IMutationPerkType
    {
        private static const mName:String = "Human Eyes";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var pAcc:int = 5;
			if (pTier >= 1){
                descS = "Increase precision of all attacks by " + pAcc + "%. Same bonus as Eyes of the Hunter (Ex) perk but with limit to ";
            }
			if (pTier == 1){
                descS = "5 lvl's.";//-x% penatly to acc for attacks? or for tier 3
            }
			if (pTier == 2){
                descS = "10 lvl's.";
            }
            if (pTier >= 3){
				pAcc += 5;
                descS = "Your fat tissue increased again your natural toughness and thickness limit. Increased damage reduction against physical damage & increase natural resistance to damage, increase max Hunger cap by 50 (if PC have Hunger bar active) (+45% of max core Tou as phantom Tou)";
            }
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return mName + sufval;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireEyesMutationSlot()
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
            if (pTier == 1) {
				pBuffs['spe.mult'] = 0.15;
                pBuffs['sens'] = 15;
			}
            if (pTier == 2) {
				pBuffs['spe.mult'] = 0.45;
                pBuffs['sens'] = 45;
			}
            if (pTier == 3) {
				pBuffs['spe.mult'] = 1.5;
                pBuffs['sens'] = 150;
			}
            return pBuffs;
        }

        public function HumanEyesMutation() 
		{
			super(mName + " IM", mName, SLOT_EYES, 1);
        }

    }
}