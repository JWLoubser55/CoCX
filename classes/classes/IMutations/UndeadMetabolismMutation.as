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

public class UndeadMetabolismMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Undead Metabolism";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1){
                descS += "Your hunger is now sated by sex. You cannot die of hunger or lose weight from it, but take libido damage instead of regular stat damage when your hunger bar is empty. When overeating instead of gaining weight gain a stacking "+(pTier*5)+"% bonus to libido up to "+(pTier*5)+"0% and heal libido damage from starvation. These bonuses decay over time";
            }
            if (pTier >= 2){
                descS += ". All of your undead racial abilities and necromancy skills are "+(pTier-1)+"00% stronger";
            }
            if (pTier >= 3){
                descS += ". You permanently gain the Darkness Affinity perk";
            }
            if (pTier >= 4){
                descS += ". Fluid intake heals all status damage, drains and weakening by 5% per intake";
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
                    .requireAnyRace(Races.LICH, Races.JIANGSHI, Races.MUMMY);
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            else if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            else if (pTier == 3) pBuffs['lib.mult'] = 0.15;
            else if (pTier == 4) pBuffs['lib.mult'] = 0.2;
            return pBuffs;
        }

        public function UndeadMetabolismMutation() {
            super(MNAME, SLOT_METABOLISM, 3);
        }
        
    }
}
