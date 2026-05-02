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

public class DraconicBonesMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Draconic Bones";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var uad:Number = 10;
			var uad2:Number = 50;
			var pt:Number = 5;
			if (pTier >= 2) uad += 10;
			if (pTier >= 3) {
				uad += 20;
				pt += 10;
			}
            if (pTier >= 4) {
				uad += 30;
				pt += 15;
			}
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increases toughness, increases unarmed attack damage by "+uad+"";
            }
			if (pTier >= 3){
                descS += " + an additional "+uad2+"%";
            }
            if (pTier >= 2){
                descS += ", "+((pTier - 1) * 5)+"% physical and magical damage reduction, +"+pt+"% phantom toughness";
            }
            if (pTier >= 4){
                descS += ", receives +25 to DR from toughness, +25% OverMax HP";
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
                        return (player.arms.type == Arms.DRACONIC || player.arms.type == Arms.FROSTWYRM || player.arms.type == Arms.PLANT || player.arms.type == Arms.PLANT2 || player.arms.type == Arms.SEA_DRAGON || player.arms.type == Arms.FEY_DRACONIC);
                    }, "Dragon race or its variants arms")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (LowerBody.hasDraconicLegs(player));
                    }, "Dragon race or its variants legs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (Tail.hasDraconicTail(player) || LowerBody.hasDraconicLegs(player) && LowerBody.hasTail(player));
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
            if (pTier == 4) pBuffs['tou.mult'] = 0.75;
            return pBuffs;
        }

        public function DraconicBonesMutation() {
            super(MNAME, SLOT_NONE, 1);//super(MNAME, SLOT_BONE, 3);
        }

    }
}