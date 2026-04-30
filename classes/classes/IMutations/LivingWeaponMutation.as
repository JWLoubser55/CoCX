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

public class LivingWeaponMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Living Weapon";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "All natural weapon and weapon damage is increased by an amount equal to ";
            if (pTier == 1) descS += "a quarter of ";
			if (pTier == 2) descS += "half of ";
			if (pTier == 3) descS += "3/4 of ";
			if (pTier >= 1) descS += "your armor class";
            if (pTier >= 2) descS += ". Your body is always considered naked and free of constraint no longer hindered by armors if able to wear any";
            if (pTier >= 3) descS += ". Base Armor value prior to perks is increased by ";
			if (pTier == 3) descS += "25%";
            if (pTier == 4) descS += "50%. Stuns last one more round";
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
                    .requireAnyRace(Races.GARGOYLE, Races.AUTOMATA, Races.HOLLOW);
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
            else if (pTier == 2) pBuffs['tou.mult'] = 0.1;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 4) pBuffs['tou.mult'] = 0.2;
            return pBuffs;
        }

        public function LivingWeaponMutation() {
            super(MNAME, SLOT_MUSCLE, 4);
        }

    }
}
