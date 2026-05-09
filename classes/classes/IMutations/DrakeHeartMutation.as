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

public class DrakeHeartMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Drake Heart";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Your heart was strengthened to better handle your changing body. (+5 SF & Mana / +1 Wrath & Fatigue regen)";
            }
            if (pTier >= 2){
                descS = "Each heartbeat fills your body with great power. (+10 SF & Mana / +2 Wrath & Fatigue regen, +5% of max core Str as phantom Str)";
            }
            if (pTier >= 3){
                descS = "Your heart metamorphosis reached pseudo-drake level. (+15 SF & Mana / +3 Wrath & Fatigue regen, +1% HP regen, +15% of max core Str as phantom Str)";
            }
            if (pTier >= 3){
                descS = "Your heart metamorphosis reached drake level. (+20 SF & Mana / +4 Wrath & Fatigue regen; +2% HP, +1% SF / Mana, +0.25% Fatigue / Wrath regen (doubled when having Drake Blood (Final Form) IM); +30% of max core Str as phantom Str)";
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
                    .requireAnyRace(Races.DRAGON,Races.FROSTWYRM, Races.YGGDRASIL,Races.SEA_DRAGON, Races.FAERIEDRAGON, Races.JABBERWOCKY, Races.FROG);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.35;
            if (pTier == 4) pBuffs['str.mult'] = 0.75;
            return pBuffs;
        }

        public function DrakeHeartMutation() {
            super(MNAME, SLOT_HEART, 4);
        }

    }
}