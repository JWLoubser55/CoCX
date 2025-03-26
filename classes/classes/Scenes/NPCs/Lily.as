/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.Scenes.Combat.CombatAbilities;

	public class Lily extends Monster//drider cumdump slave from swamp area
	{
		private function lilyBasicAttack():void {
			outputText("The drider woman draws her recurve bow, nocking an arrow and firing in less than half a second. You try to dodge, but the arrow hits you in the [foot], pinning you to the ground. ");
			damageCalc();
			var lBAR:Number = 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 2) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 4) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 6) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 8) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 10) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 12) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 14) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 16) lBAR += 1;
			if (flags[kFLAGS.LILY_LVL_UP] >= 18) lBAR += 1;
			while (lBAR-->0) lilyBasicAttackRe();
		}
		private function lilyBasicAttackRe():void {
			var choices:Number = 4;
			if (!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon()) choices += 1;
			var re:Number = rand(choices);
			switch (re) {
				case 0:
					outputText("Another arrow follows, sinking deep into your [chest]. ");
					damageCalc();
					break;
				case 1:
					outputText("Another arrow follows, sinking into your [leg]. ");
					damageCalc();
					break;
				case 2:
					outputText("An arrow is fired into your shoulder. ");
					damageCalc();
					break;
				case 3:
					outputText("The drider fires an arrow with an explosive tip. You cover your [face] as the concussive blast erupts, sending metal shards into your body. ");
					damageCalc();
					if (rand(10) == 0 && !player.hasPerk(PerkLib.Resolute) && !player.hasStatusEffect(StatusEffects.Stunned)) player.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
					break;
				case 4:
					outputText("You look down at your foot, and another arrow comes whistling at you. You block with your [weapon], but the impact sends your [weapon] tumbling from your hands. ");
					if (rand(3) == 0) {
						flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
						player.setWeapon(WeaponLib.FISTS);
						player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
					}
					break;
				default:
					outputText("Another arrow follows, sinking deep into your [chest]. ");
					damageCalc();
			}
		}
		
		private function lilyWebAttack():void {
			outputText("She spins, exposing her spider back-half and spinnerets. The Drider spits webbing in great strands.");
			//Determine if dodged!
			if (player.getEvasionRoll()) {
				outputText("You dodge away, avoiding the sticky strands! As she spins back around, your opponent…seems to be looking at the strands in disappointment. Is it your imagination, or does she seem to regret the loss of silk?");
			}
			//Got hit
			else {
				if (player.buff("Web").isPresent()) {
					outputText("The silky strands hit you, weighing you down and restricting your movement even further.\n");
					player.buff("Web").addStats( {"spe":-50} ).withText("Web").combatPermanent();
				}
				else {
					outputText("You’re unable to dodge, and the heavy strands wrap around your arms and legs, weighing you down and restricting your movements.");
					if (player.canFly()) outputText("  Your wings struggle uselessly in the bindings, no longer able to flap fast enough to aid you.");
					outputText("\n");
					player.buff("Web").addStats( {"spe":-50} ).withText("Web").combatPermanent();
				}
			}
		}
		
		private function lilyVolley():void {
			outputText("Several arrows come flying at you, and you see the Drider-woman’s top half through the treeline. You gasp, disbelieving, as said arrows seem to multiply into a veritable shower of shafts, and you barely have time to crouch down, making yourself less of a target. ");
			if (CombatAbilities.EAspectAir.isActive()) outputText("Still surrounding you wind wall stops them without much trouble. ");
			var lFB:Number = 6;
			if (flags[kFLAGS.LILY_LVL_UP] >= 3) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 5) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 7) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 9) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 11) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 13) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 15) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 17) lFB += 3;
			if (flags[kFLAGS.LILY_LVL_UP] >= 19) lFB += 3;
			while (lFB-->0) LilyFireBow();
		}
		public function LilyFireBow():void {
			if (CombatAbilities.EAspectAir.isActive()) CombatAbilities.EAspectAir.advance(true);
			else damageCalc();
		}
		
		private function damageCalc():void {
			var damage:Number = 0;
			damage += eBaseSpeedDamage() * 0.4;
			damage += eBaseStrengthDamage() * 0.2;
			if (hasPerk(PerkLib.ElementalArrows)) damage += eBaseIntelligenceDamage() * 0.1;
			if (damage < 50) damage = 50;
			//weapon bonus
			if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
			else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
			else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
			else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
			if (hasPerk(PerkLib.Sadomasochism)) {
				var smB:Number = 1;
				if (this.HP < this.maxHP() * 0.25) smB += 0.2;
				if (this.lust > this.maxLust() * 75) smB += 0.2;
				damage *= smB;
			}
			player.takePhysDamage(damage, true);
			if (flags[kFLAGS.LILY_LVL_UP] >= 3) {
				var lustArrowDmg:Number = (flags[kFLAGS.LILY_LVL_UP] * 2);
				if (hasPerk(PerkLib.Cupid) && this.mana >= 1) {
					mana -= 1;
					lustArrowDmg += this.inte / 10;
				}
				if (flags[kFLAGS.LILY_LVL_UP] >= 9) lustArrowDmg += (this.inte / 5 + rand(player.lib - player.inte * 2 + player.cor) / 5);
				player.takeLustDamage(lustArrowDmg, true);
			}
			if (hasPerk(PerkLib.ArrowStorm) && rand(2) == 0) {
				outputText(" Her arrow make an U-turn after piercing before hitting you again! ");
				player.takePhysDamage(damage, true);
				player.takeLustDamage(lustArrowDmg, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			mana += 20;
			var choice0:Number = rand(3);
			switch (choice0) {
				case 0:
					lilyBasicAttack();
					break;
				case 1:
					lilyWebAttack();
					break;
				case 2:
					lilyVolley();
					break;
				default:
					lilyBasicAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (LilyFollower.LilyFollowerState) SceneLib.lily.LilySparLost();
			else SceneLib.lily.LilyAfterBattle();
		}
		
		public function Lily()
		{
			if (flags[kFLAGS.LILY_LVL_UP] < 2) {
				initStrTouSpeInte(164, 186, 340, 290);
				initWisLibSensCor(220, 310, 220, 80);
				this.weaponAttack = 5;
				this.weaponRangeAttack = 60;
				this.armorDef = 140;
				this.armorMDef = 70;
				this.bonusHP = 500;
				this.bonusLust = 564;
				this.level = 34;
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 2 && flags[kFLAGS.LILY_LVL_UP] < 19) {
				var mod:int = (flags[kFLAGS.LILY_LVL_UP] - 1);
				initStrTouSpeInte(164 + 12*mod, 186 + 18*mod, 340 + 60*mod, 290 + 45*mod);
				initWisLibSensCor(220 + 15*mod, 310 + 75*mod, 220 + 60*mod, 80);
				this.weaponAttack = 5 + 1*mod;
				this.weaponRangeAttack = 60 + 15*mod;
				this.armorDef = 140 + 10*mod;
				this.armorMDef = 70 + 5*mod;
				this.bonusHP = 500 + 50*mod;
				this.bonusLust = 564 + 141*mod;
				this.level = 22 + 6*mod;
			}
			if (flags[kFLAGS.LILY_LVL_UP] == 19) {
				initStrTouSpeInte(380, 510, 1420, 1100);
				initWisLibSensCor(490, 1510, 1300, 80);
				this.weaponAttack = 23;
				this.weaponRangeAttack = 330;
				this.armorDef = 320;
				this.armorMDef = 160;
				this.bonusHP = 1400;
				this.bonusLust = 3102;
				this.level = 142;
			}
			this.imageName = "corrupteddrider";
			if (LilyFollower.LilyTalked > 0) {
				this.a = "";
				this.short = "Lily";
				this.long = "Lily is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
			}
			else {
				this.a = "the ";
				this.short = "corrupted drider";
				this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
			}
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,70,0,0,0);
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DRIDER;
			this.bodyColor = LilyFollower.LilySkinTone;
			this.hairColor = LilyFollower.LilyHairColor;
			this.hairLength = 24;
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.weaponRangeName = "bow";
			this.armorName = "carapace";
			this.armorPerk = "";
			this.armorValue = 70;
			this.nipplesPierced = 1;
			this.lust = 35;
			this.lustVuln = .2;
			this.gems = rand(15) + 35;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (flags[kFLAGS.LILY_LVL_UP] >= 14 && flags[kFLAGS.LILY_LVL_UP] < 20) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			if (flags[kFLAGS.LILY_LVL_UP] >= 2) {
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.Masochist, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 3) {
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 4) {
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 5) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobHunter, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 6) {
				this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.NakedTruth, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 7) {
				this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 8) {
				this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 9) {
				this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 10) {
				this.createPerk(PerkLib.HalfStepToInhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEromancer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 11) {
				this.createPerk(PerkLib.InhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 12) {
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 13) {
				this.createPerk(PerkLib.HalfStepToEpicSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 14) {
				this.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
				this.createPerk(PerkLib.PrestigeJobBindmaster, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 15) {
				this.createPerk(PerkLib.EpicSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 16) {
				this.createPerk(PerkLib.ElementalArrows, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 17) {
				this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.Cupid, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 18) {
				this.createPerk(PerkLib.ArrowStorm, 0, 0, 0, 0);
				this.createPerk(PerkLib.Sadomasochism, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 19) {
				this.createPerk(PerkLib.MythicalLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.LILY_LVL_UP] >= 20) //this.createPerk(PerkLib., 0, 0, 0, 0);
			if (flags[kFLAGS.LILY_LVL_UP] >= 21) this.createPerk(PerkLib.MythicalSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.LILY_LVL_UP] >= 22) //this.createPerk(PerkLib., 0, 0, 0, 0);
			if (flags[kFLAGS.LILY_LVL_UP] >= 23) this.createPerk(PerkLib.MythicalStrength, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
