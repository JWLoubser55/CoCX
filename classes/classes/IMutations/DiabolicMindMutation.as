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

public class DiabolicMindMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Diabolic Mind";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "While lust is above "+(8 - pTier)+"0% increase all spell damage by "+(5 * pTier)+"0%";
            if (pTier >= 2) descS += ". Decrease lust damage taken after lust resistance by "+(15 * (pTier - 1))+"%";
            if (pTier >= 3) descS += ". Black magic potency is empowered by "+(pTier - 2)+"00% against opponents of pure alignment";
            if (pTier >= 4) descS += ". Reduce Feedback lust damage from health defeat denial by half";
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
                    .requireCor(100).requireRace(Races.DEVIL);
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
            if (pTier == 1) pBuffs['int.mult'] = 0.05;
            if (pTier == 2) pBuffs['int.mult'] = 0.1;
            if (pTier == 3) pBuffs['int.mult'] = 0.15;
            if (pTier == 4) pBuffs['int.mult'] = 0.2;
            return pBuffs;
        }

        public function DiabolicMindMutation() {
            super(MNAME, SLOT_NERVSYS, 4);
        }

    }
}
