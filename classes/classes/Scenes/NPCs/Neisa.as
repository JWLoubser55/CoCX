/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.CatLikeNimblenessMutation;
import classes.IMutations.DraconicLungMutation;
import classes.IMutations.GorgonEyesMutation;
import classes.IMutations.IMutationsLib;
import classes.IMutations.LactaBovinaOvariesMutation;
import classes.IMutations.LizanMarrowMutation;
import classes.IMutations.OniMusculatureMutation;
import classes.IMutations.OrcAdrenalGlandsMutation;
import classes.IMutations.PigBoarFatMutation;
import classes.Scenes.SceneLib;

	public class Neisa extends Monster
	{
		public function drinkPotion():void {
			outputText("She grab health potion, pull the cork off and swiftly chug it down.");
			if (flags[kFLAGS.NEISA_LVL_UP] >= 20) HP += 8640;
			else if (flags[kFLAGS.NEISA_LVL_UP] >= 13) HP += 1440;
			else if (flags[kFLAGS.NEISA_LVL_UP] >= 6) HP += 240;
			else HP += 40;
			monsterSlimeMetabolismRecovery();
		}
		public function ramingWithShield():void {
			outputText("Neisa viciously rams you her shield, ");
			if (!player.hasPerk(PerkLib.Resolute)) {
				player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				outputText("dazing you.\n\n");
			} else {
				outputText("but you endured it.\n\n");
			}
		}
		public function bastardswordSlash():void {
			outputText("Neisa slashes at you with her bastard sword.  ");
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid her sword thanks to your reaction!");
				return;
			}
			else {
				outputText("She manages to swipe you!  You let out a cry in pain. ");
				var damage:int = eBaseStrengthDamage() * 2 + eBaseSpeedDamage();
				if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.03));
				else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (2.5 + ((weaponAttack - 50) * 0.025));
				else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (3.75 + ((weaponAttack - 100) * 0.02));
				else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (4.75 + ((weaponAttack - 150) * 0.015));
				else damage *= (5.5 + ((weaponAttack - 200) * 0.01));
				if (damage < 50) damage = 50;
				player.takePhysDamage(damage, true);
			}
		}

		override protected function performCombatAction():void {
			var choice1:Number = rand(4);
			if (choice1 < 2) bastardswordSlash();
			if (choice1 == 2) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) bastardswordSlash();
				else ramingWithShield();
			}
			if (choice1 == 3) drinkPotion();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.neisaFollower.neisaSparWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.neisaFollower.neisaSparLost();
		}
		
		public function Neisa()
		{//  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.
			if (flags[kFLAGS.NEISA_LVL_UP] == 1) {
				initStrTouSpeInte(50, 80, 50, 44);
				initWisLibSensCor(44, 52, 40, 0);
				this.weaponAttack = 32;
				this.armorDef = 20;
				this.armorMDef = 20;
				this.bonusHP = 200;
				this.bonusLust = 95;
				this.level = 3;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 2 && flags[kFLAGS.NEISA_LVL_UP] < 9) {
				var mod:int = (flags[kFLAGS.NEISA_LVL_UP] - 1);
				initStrTouSpeInte(50 + 45*mod, 80 + 52*mod, 50 + 45*mod, 44 + 38*mod);
				initWisLibSensCor(44 + 38*mod, 52 + 50*mod, 40 + 35*mod, 0);
				this.weaponAttack = 32 + 24*mod;
				this.armorDef = 20 + 50*mod;
				this.armorMDef = 20 + 50*mod;
				this.bonusHP = 200 + 200*mod;
				this.bonusLust = 95 + 91*mod;
				this.level = 3 + 6*mod;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 24) {
				initStrTouSpeInte(1085, 1276, 1085, 918);
				initWisLibSensCor(918, 52, 845, 0);
				this.weaponAttack = 584;
				this.armorDef = 1170;
				this.armorMDef = 1170;
				this.bonusHP = 4800;
				this.bonusLust = 2188;
				this.level = 141;
			}
			this.a = "";
			this.short = "Neisa";
			this.imageName = "Neisa";
			this.long = "Neisa is a seven foot tall, raven-haired shield maiden. Her full plate armor and giant shield makes it hard to have a good look at her. And if you would try to peek at her you have to be vary of her bastard sword that may swing your way.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("I"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,38,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			this.weaponName = "bastard sword and giant shield";
			this.weaponVerb="slash";
			this.armorName = "heavy plate armor";
			this.armorPerk = "";
			this.armorValue = 70;
			this.lust = 30;
			this.lustVuln = .35;
			this.gems = rand(10) + 25;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.Ferocity, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyDragonType, 0, 0, 0, 0);
			this.createPerk(IMutationsLib.DrakeLungsIM, 1, 0, 0, 0);
			this.createPerk(IMutationsLib.DrakeBloodIM, 1, 0, 0, 0);
			this.createPerk(IMutationsLib.DrakeHeartIM, 1, 0, 0, 0);
			this.createPerk(IMutationsLib.LactaBovinaOvariesIM, 1, 0, 0, 0);
			this.createPerk(IMutationsLib.HumanSmartsIM, 1, 0, 0, 0);
			this.createPerk(IMutationsLib.OrcAdrenalGlandsIM, 1, 0, 0, 0);//6-0
			if (flags[kFLAGS.NEISA_LVL_UP] >= 11 && flags[kFLAGS.NEISA_LVL_UP] < 25) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			if (flags[kFLAGS.NEISA_LVL_UP] >= 2) {
				this.createPerk(IMutationsLib.HumanThyroidGlandIM, 1, 0, 0, 0);
				this.createPerk(IMutationsLib.CatLikeNimblenessIM, 1, 0, 0, 0);
				this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodyInitialStage, 0, 0, 0, 0);//8-2
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 3) {
				this.createPerk(IMutationsLib.LizanMarrowIM, 1, 0, 0, 0);
				this.createPerk(IMutationsLib.GorgonEyesIM, 1, 0, 0, 0);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodySemiBasicStage, 0, 0, 0, 0);//10-5
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 4) {
				this.createPerk(IMutationsLib.OniMusculatureIM, 1, 0, 0, 0);
				this.createPerk(IMutationsLib.FerasBirthrightIM, 1, 0, 0, 0);
				this.createPerk(PerkLib.JobKnight, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodyBasicStage, 0, 0, 0, 0);//12-9
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 5) {
				this.createPerk(IMutationsLib.SlimeMetabolismIM, 1, 0, 0, 0);
				this.createPerk(IMutationsLib.PigBoarFatIM, 1, 0, 0, 0);
				this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 6) {
				this.setPerkValue(IMutationsLib.DrakeLungsIM, 1,2);
				this.setPerkValue(IMutationsLib.DrakeBloodIM, 1,2);
				this.createPerk(PerkLib.JobDefender, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodyImprovedStage, 0, 0, 0, 0);//16-15
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 7) {
				this.setPerkValue(IMutationsLib.DrakeHeartIM, 1,2);
				this.setPerkValue(IMutationsLib.LactaBovinaOvariesIM, 1,2);
				this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 8) {
				this.setPerkValue(IMutationsLib.HumanSmartsIM, 1,2);
				this.setPerkValue(IMutationsLib.OrcAdrenalGlandsIM, 1,2);
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 9) {
				this.setPerkValue(IMutationsLib.HumanThyroidGlandIM, 1,2);
				this.setPerkValue(IMutationsLib.CatLikeNimblenessIM, 1,2);
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 10) {
				this.setPerkValue(IMutationsLib.LizanMarrowIM, 1,2);
				this.setPerkValue(IMutationsLib.GorgonEyesIM, 1,2);
				this.createPerk(PerkLib.ImmovableObject, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodySemiAdvancedStage, 0, 0, 0, 0);//24-22
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 11) {
				this.setPerkValue(IMutationsLib.OniMusculatureIM, 1,2);
				this.setPerkValue(IMutationsLib.FerasBirthrightIM, 1,2);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 12) {
				this.setPerkValue(IMutationsLib.SlimeMetabolismIM, 1,2);
				this.setPerkValue(IMutationsLib.PigBoarFatIM, 1,2);
				this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 13) {
				this.setPerkValue(IMutationsLib.DrakeLungsIM, 1,3);
				this.setPerkValue(IMutationsLib.DrakeBloodIM, 1,3);
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 14) {
				this.setPerkValue(IMutationsLib.DrakeHeartIM, 1,3);
				this.setPerkValue(IMutationsLib.LactaBovinaOvariesIM, 1,3);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodyAdvancedStage, 0, 0, 0, 0);//32-30
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 15) {
				this.setPerkValue(IMutationsLib.HumanSmartsIM, 1,3);
				this.setPerkValue(IMutationsLib.OrcAdrenalGlandsIM, 1,3);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 16) {
				this.setPerkValue(IMutationsLib.HumanThyroidGlandIM, 1,3);
				this.setPerkValue(IMutationsLib.CatLikeNimblenessIM, 1,3);
				this.createPerk(PerkLib.Juggernaut, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 17) {
				this.setPerkValue(IMutationsLib.LizanMarrowIM, 1,3);
				this.setPerkValue(IMutationsLib.GorgonEyesIM, 1,3);
				this.createPerk(PerkLib.EpicDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 18) {
				this.setPerkValue(IMutationsLib.OniMusculatureIM, 1,3);
				this.setPerkValue(IMutationsLib.FerasBirthrightIM, 1,3);
				this.createPerk(PerkLib.LimitBreakerFlesh1stStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 19) {
				this.setPerkValue(IMutationsLib.SlimeMetabolismIM, 1,3);
				this.setPerkValue(IMutationsLib.PigBoarFatIM, 1,3);
				this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodySuperiorStage, 0, 0, 0, 0);//42-40
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 20) {
				this.setPerkValue(IMutationsLib.DrakeLungsIM, 1,4);
				this.setPerkValue(IMutationsLib.DrakeBloodIM, 1,4);
				this.createPerk(PerkLib.LimitBreakerPsyche1stStage, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 21) {
				this.setPerkValue(IMutationsLib.DrakeHeartIM, 1,4);
				this.setPerkValue(IMutationsLib.LactaBovinaOvariesIM, 1,4);
				this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 22) {
				this.setPerkValue(IMutationsLib.HumanSmartsIM, 1,4);
				this.setPerkValue(IMutationsLib.OrcAdrenalGlandsIM, 1,4);
				this.createPerk(PerkLib.LimitBreakerFlesh2ndStage, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 23) {
				this.setPerkValue(IMutationsLib.HumanThyroidGlandIM, 1,4);
				this.setPerkValue(IMutationsLib.CatLikeNimblenessIM, 1,4);
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 24) {
				this.setPerkValue(IMutationsLib.LizanMarrowIM, 1,4);
				this.setPerkValue(IMutationsLib.GorgonEyesIM, 1,4);
				this.createPerk(PerkLib.LimitBreakerPsyche2ndStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.ChimericalBodySemiPeerlessStage, 0, 0, 0, 0);//52-51
			}
			checkMonster();
		}

	}
}
