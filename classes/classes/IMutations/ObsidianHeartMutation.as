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

public class ObsidianHeartMutation extends IMutationPerkType
    {
		public static const MNAME:String = "Obsidian Heart";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var Md:Number = 5;
			var Mb:Number = 25;
			var IF:Number = 25;
			var LR:Number = 30;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 3) {
				Mb += 125;
				IF += 40;
			}
            if (pTier >= 4) {
				Md += 5;
				Mb += 150;
				IF += 85;
				LR -= 15;
			}
            if (pTier >= 1) descS += "Devil special abilities are available even if you do not qualify as Devilkin but will increase your corruption on each use until it reaches 60";
            if (pTier >= 2) descS += ". Maleficium's duration is increased by "+Md+" turns and spellpower is boosted by "+Mb+"%";
            if (pTier >= 3) descS += " while it only lowers lust resistance by "+LR+"%";
            if (pTier >= 2) descS += ", Infernal Flare is empowered by "+IF+"%";
            if (pTier >= 3) descS += " and has 20% higher chance to crit";
            if (pTier >= 4) descS += ". Magic scales damage with your Libido as well as your intelligence, the true power of want";
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

        public function ObsidianHeartMutation() {
            super(MNAME, SLOT_HEART, 4);
        }

    }
}
