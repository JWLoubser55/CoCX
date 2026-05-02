/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.PerkLib;
import classes.Races;

public class DrakeLungMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Drake Lung";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var dbd:Number = 3;
			var cSpS:Number = 5;
			if (pTier >= 3) {
				dbd += 6;
				cSpS += 10;
			}
			if (pTier >= 4) {
				dbd += 9;
				cSpS += 15;
			}
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Allows you to use breath attacks more often. (All dragon breaths (excluding the most recent used) cooldowns are reduced by 1 increment as long PC is having any dragon race score on tier 1+)";
            }
            if (pTier >= 2){
                descS += " Increases the power of dragon breath attacks. (+"+dbd+"00% to dragon breaths damage, +"+cSpS+"% of max core Spe as phantom Spe)";
            }
            if (pTier >= 4){
                descS += " Dragon breaths would deal higher damage against single and group enemies. The larger group the higher bonus damage. (2x/10x/50x) All dragon breaths cooldowns are reduced by 1 increment as long PC is having any dragon race score on tier 1+.";
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
                    this.requireLungsMutationSlot()
                    .requireAnyPerk(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath, PerkLib.DragonPoisonBreath, PerkLib.DragonPoisonousSapBreath, PerkLib.DragonWaterBreath, PerkLib.DragonEarthBreath, PerkLib.DragonRegalBreath, PerkLib.DragonFaerieBreath, PerkLib.DragonBlackIceBreath)
                    .requireAnyRace(Races.DRAGON, Races.FROSTWYRM, Races.JABBERWOCKY, Races.VOUIVRE, Races.YGGDRASIL, Races.SEA_DRAGON, Races.FAERIEDRAGON, Races.DRAGONNE, Races.KRAMPUS);
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
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.15;
            if (pTier == 3) pBuffs['spe.mult'] = 0.35;
            if (pTier == 4) pBuffs['spe.mult'] = 0.75;
            return pBuffs;
        }

        public function DrakeLungMutation() {
            super(MNAME, SLOT_LUNGS, 4);
        }

    }
}