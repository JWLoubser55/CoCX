package classes {
import classes.IMutations.IMutationsLib;

/**
 * This class manages player-related events (change hp/resources and similar)
 */
public class PlayerController extends BaseContent {
	public function PlayerController() {
	}

	public function maxOverHPCW():Number {
		var mOHPCW:Number = player.maxOverHP();
		if (CoC.instance.player.hasStatusEffect(StatusEffects.CombatWounds)) {
			mOHPCW *= (1 - CoC.instance.player.statusEffectv1(StatusEffects.CombatWounds));
			mOHPCW = Math.round(mOHPCW);
		}
		return mOHPCW;
	}

	/**
	 * Alters player's HP.
	 * @param    changeNum The amount to damage (negative) or heal (positive).
	 * @param    display Show the damage or heal taken.
	 * @return  effective delta
	 */
	public function HPChange(changeNum:Number, display:Boolean, stillness:Boolean):Number {
		var before:Number = player.HP;
		var healingFromHealer:Number = 1;
		if (changeNum == 0) return 0;
		if (changeNum > 0 && player.HP >= maxOverHPCW() && !stillness) changeNum = 0;
		if (changeNum > 0) {
			//Increase by 20%!
			if (player.hasPerk(PerkLib.HistoryHealer) || player.hasPerk(PerkLib.PastLifeHealer)) {
				healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.Nurse)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.Doctor)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.FirstResponse)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.Paramedic)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.SurgeonsAide)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.Surgeon)) healingFromHealer += 0.2;
				if (player.hasPerk(PerkLib.Medic)) healingFromHealer += 0.2;
				changeNum *= healingFromHealer;
				changeNum = Math.min(changeNum, int.MAX_VALUE)
			}
			var maximus:Number = maxOverHPCW();
			if (stillness) maximus = Math.round(maximus * (1 + (0.15 * (player.perkv1(IMutationsLib.StillHeartIM) - 1))));
			if (Math.min(player.HP + changeNum, int.MAX_VALUE) > maximus) {
				if (player.HP >= maximus) {
					if (display) HPChangeNotify(changeNum);
					return player.HP - before;
				}
				if (display) HPChangeNotify(changeNum);
				player.HP = maximus;
			}
			else {
				if (display) HPChangeNotify(changeNum);
				player.HP += int(changeNum);
				CoC.instance.mainViewManager.showStatUp('hp');
				// hpUp.visible = true;
			}
		}
		//Negative HP
		else {
			if (player.HP + changeNum <= player.minHP()) {
				if (display) HPChangeNotify(changeNum);
				player.HP = player.minHP();
				CoC.instance.mainViewManager.showStatDown('hp');
			}
			else {
				if (display) HPChangeNotify(changeNum);
				player.HP += changeNum;
				CoC.instance.mainViewManager.showStatDown('hp');
			}
		}
		player.dynStats("lust", 0, "scale", false); //Workaround to showing the arrow.
		statScreenRefresh();
		return player.HP - before;
	}

	public function HPChangeNotify(changeNum:Number):void {
		if (changeNum == 0) {
			if (player.HP >= player.maxOverHP())
				outputText("You're as healthy as you can be.\n");
		}
		else if (changeNum > 0) {
			if (player.HP >= player.maxOverHP())
				outputText("Your HP maxes out at " + player.maxOverHP() + ".\n");
			else
				outputText("You gain <b>[font-heal]" + formatNumber(int(changeNum)) + "[/font]</b> HP.\n");
		}
		else {
			if (player.HP <= player.minHP())
				outputText("You take <b>[font-damage]" + formatNumber(int(changeNum * -1)) + "[/font]</b>" +
						" damage, dropping your HP to "+player.minHP()+".\n");
			else
				outputText("You take <b>[font-damage]" + formatNumber(int(changeNum * -1)) + "[/font]</b> damage.\n");
		}
	}
	public function SoulforceChange(changeNum:Number):Number {
		var before:Number = player.soulforce;
		if (changeNum == 0) return 0;
		if (changeNum > 0) {
			if (player.soulforce + int(changeNum) > player.maxOverSoulforce()) player.soulforce = player.maxOverSoulforce();
			else player.soulforce += changeNum;
		} else {
			if (player.soulforce + changeNum <= 0) player.soulforce = 0;
			else player.soulforce += changeNum;
		}
		player.dynStats("lust", 0, "scale", false);
		statScreenRefresh();
		return player.soulforce - before;
	}
	public  function ManaChange(changeNum:Number):Number {
		var before:Number = player.mana;
		if (changeNum == 0) return 0;
		if (changeNum > 0) {
			if (player.mana + int(changeNum) > player.maxOverMana()) player.mana = player.maxOverMana();
			else player.mana += changeNum;
			if (player.racialScore(Races.LICH) >= 28) SoulforceChange(changeNum);
		} else {
			if (player.mana + changeNum <= 0) player.mana = 0;
			else player.mana += changeNum;
			if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) HPChange(-changeNum, false, false);
		}
		player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
		statScreenRefresh();
		return player.mana - before;
	}
	public function WrathChange(changeNum:Number):Number {
		var before:Number = player.wrath;
		if (changeNum == 0) return 0;
		if (changeNum > 0) {
			if (player.gaindHoldWithAllHandBonus()) changeNum *= 2;
			if (player.wrath + int(changeNum) > player.maxOverWrath()) player.wrath = player.maxOverWrath();
			else player.wrath += changeNum;
		} else {
			if (player.wrath + changeNum <= 0) player.wrath = 0;
			else player.wrath += changeNum;
		}
		player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
		statScreenRefresh();
		return player.wrath - before;
	}

	public function VenomWebChange(changeNum:Number):Number {
		var before:Number = player.tailVenom;
		if (changeNum == 0) return 0;
		if (changeNum > 0) {
			if (player.tailVenom + int(changeNum) > player.maxVenom()) player.tailVenom = player.maxVenom();
			else player.tailVenom += changeNum;
		} else {
			if (player.tailVenom + changeNum <= 0) player.tailVenom = 0;
			else player.tailVenom += changeNum;
		}
		player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
		statScreenRefresh();
		return player.tailVenom - before;
	}

}
}
