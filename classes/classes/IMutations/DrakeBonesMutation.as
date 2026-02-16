/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Arms;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.Player;
import classes.Races;

public class DrakeBonesMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Drake Bones";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Increases toughness, increases unarmed attack damage by 10";
            }
            if (pTier >= 2){
                descS = "Increases toughness further, increases unarmed attack damage by 20, 5% damage reduction from physical and magical attacks, +5% phantom toughness";
            }
            if (pTier >= 3){
                descS = "Increases toughness even further, increases unarmed attack damage by 40 + an additional 50%, 10% physical and magical damage reduction, +15% phantom toughness";
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
                    this.requireBonesAndMarrowMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return InCollection(player.arms.type, Arms.DRACONIC, Arms.FROSTWYRM, Arms.SEA_DRAGON, Arms.FEY_DRACONIC, Arms.LIZARD, Arms.YGGDRASIL, Arms.JABBERWOCKY);
                    }, "Dragon race or its variants arms")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (LowerBody.hasDraconicLegs(player) || player.lowerBody == LowerBody.JABBERWOCKY || player.lowerBody == LowerBody.KIRIN);
                    }, "Dragon race or its variants legs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (Tail.hasDraconicTail(player) || (LowerBody.hasDraconicLegs(player) && LowerBody.hasTail(player)) || player.tailType == Tail.KIRIN);
                    }, "Dragon race or its variants tail")
                    .requireAnyRace(Races.DRAGON, Races.JABBERWOCKY, Races.FROSTWYRM, Races.YGGDRASIL, Races.SEA_DRAGON, Races.FAERIEDRAGON, Races.KIRIN);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.35;
            return pBuffs;
        }

        public function DrakeBonesMutation() {
            super(MNAME, SLOT_BONE, 3);
        }

    }
}