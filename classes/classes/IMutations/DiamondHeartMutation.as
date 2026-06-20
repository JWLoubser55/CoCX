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

public class DiamondHeartMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Diamond Heart";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var PCd:Number = 5;
			var PCb:Number = 25;
			var JF:Number = 25;
			var PDR:Number = 20;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 3) {
				PCb += 125;
				JF += 40;
			}
            if (pTier >= 4) {
				PCd += 5;
				PCb += 150;
				JF += 85;
				PDR -= 10;
			}
			if (pTier >= 1) descS += "Your Judgment flare makes enemies "+(pTier*5)+"0% more vulnerable to magic for "+(pTier*2)+" rounds";
            if (pTier >= 2) descS += ". Perfect Clarity's duration is increased by "+PCd+" turns and spellpower is boosted by "+PCb+"%";
            if (pTier >= 3) descS += " while it only lowers physical resistance reduction by "+PDR+"%";
            if (pTier >= 2) descS += ", Infernal Flare is empowered by "+JF+"%";
            if (pTier >= 3) descS += " and has 20% higher chance to crit";
            if (pTier >= 4) descS += ". Magic scales damage with your Libido as well as your intelligence, the true power of want";
            if (descS != "")descS += ".";
            return descS;
        }

        override public function evolveText():String {
            var descS:String = "\nYou feel radiant today as if some of the weight of the world dropped from your shoulder. It feels right to fight against corruption and you feel twice as gratified for doing so. Your heart feels in the right place or maybe it's the pure powers flooding through it that makes it feel so?";
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
                    .requireCor(-100).requireRace(Races.AZAZEL);
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
                pBuffs['str.mult'] = 0.01;
                pBuffs['tou.mult'] = 0.01;
                pBuffs['spe.mult'] = 0.01;
            }
            if (pTier == 2) {
                pBuffs['str.mult'] = 0.03;
                pBuffs['tou.mult'] = 0.03;
                pBuffs['spe.mult'] = 0.03;
            }
            if (pTier == 3) {
                pBuffs['str.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            if (pTier == 4) {
                pBuffs['str.mult'] = 0.07;
                pBuffs['tou.mult'] = 0.07;
                pBuffs['spe.mult'] = 0.07;
            }
            return pBuffs;
        }

        public function DiamondHeartMutation() {
            super(MNAME, SLOT_HEART, 4);
        }

    }
}
