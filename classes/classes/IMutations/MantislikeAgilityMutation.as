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

public class MantislikeAgilityMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Mantislike Agility";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var mla:Number = 30;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 4) mla += 60;
            if (pTier >= 1){
                descS += "Your agility is increased, and can be even further boosted if you have natural armor or thick skin";
            }
            if (pTier >= 3){
                descS += ", +"+mla+"% max core spe as phantom spe";
            }
			if (pTier >= 4){
				descS += ". Increases maximum base/core (50) and trainable Spe (50%). All natural weapon and weapon damage is increased by an amount equal to sum of your speed stat core and train values";
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
                    this.requireMusclesMutationSlot()
                    .requireMutation(IMutationsLib.TrachealSystemIM)
                    .requireRace(Races.MANTIS);
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
            if (pTier == 1) pBuffs['spe.mult'] = 0.1;
            if (pTier == 2) pBuffs['spe.mult'] = 0.3;
            if (pTier == 3) pBuffs['spe.mult'] = 0.7;
            if (pTier == 3) pBuffs['spe.mult'] = 1.5;
            return pBuffs;
        }

        public function MantislikeAgilityMutation() {
            super(MNAME, SLOT_MUSCLE, 4);
        }

    }
}
