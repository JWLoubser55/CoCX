/**
 * ...
 * @author ...
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.CoC;
	import classes.Races;
	import classes.Races.BansheeRace;

public class WraithScene extends BaseContent
	{
		
		public function WraithScene() 
		{}
		
		public function encounterWraith1():void {
			encounterWraith(1);
		}
		public function encounterWraith2():void {
			encounterWraith(2);
		}
		private function encounterWraith(area:Number):void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("It's Information Noona here again (not Bashee just Abyssal Elf Maiden of 1k+ years) with info that Director Liadri would write text here... soon(tm) and now go fight that Wraith up there.\n\n");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_WRAITH);
			if (!player.hasStatusEffect(StatusEffects.WraithFace)) player.createStatusEffect(StatusEffects.WraithFace, 0, 0, 0, 0);
			if (area == 1) player.changeStatusValue(StatusEffects.WraithFace, 2, 1);
			else player.changeStatusValue(StatusEffects.WraithFace, 2, 2);
			if (rand(3) > 0) {
				if (rand(2) == 0) player.changeStatusValue(StatusEffects.WraithFace, 1, 3);
				else player.changeStatusValue(StatusEffects.WraithFace, 1, 2);
			}
			else player.changeStatusValue(StatusEffects.WraithFace, 1, 1);
			startCombat(new Wraith());
		}
		
		public function loseToWraith():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("You fall defeated by the wraith. In excitement, the spectral horror closes in and grabs hold of your head, digging into you with its clawed hands" + (player.hairLength > 0 ? " and pulling at your hair":"") + ".\n\n");
			outputText("You open your mouth to yell in pain, only for it to gag you with its monstrous cock. The wraith begins to viciously fuck your throat, desperate for a brief release of its bottled desire using you as a vessel to expell its excess lust. The wraith's cock releases drop after drop into your gullet as it attempts to achieve an orgasm that will never come. ");
			if (player.isAnyRace(Races.ELF, Races.WOODELF, Races.ABYSSAL_ELF) && !player.blockingBodyTransformations()) {
				outputText("As you drink in the wraith's corruption, your body begins to undergo a terrible change.\n\n");
				outputText("At first your fair elven skin and beautiful silken hairs lose their vibrancy as life is drained out of you. You feel lighter, as if some part of you was slowly being erased, something a quick glance at your not-so-opaque skin confirms. You're turning semi transparent and ethereal, like a ghost. Then the change explodes into your limb, your soulforce flowing out of your body like water seeping out of a leaking barrel; ");
				outputText("your hands spasm, turning into sharp, deformed claws, and your legs melt into a ghastly substance, turning into a ghostly shroud. Your throat, the place where the most corruption is being dumped, has changed, remodeled to accommodate and be a pleasing fit to the terrible penis of your aggressor. Feeling incredibly thirsty, you no longer choke from the insertion now - you are willingly taking in his corrupted penis, ");
				outputText("trying to flood your parched throat with as much of the inky black corruption as you can, as if to replace the soulforce constantly leaking out of your body. This in turn accelerates your unholy transformation.\n\n");
				outputText("The wraith keeps fucking your body until its cock finally breaks through your now-completely-ethereal form and past your neck! Its tip hoses black precum all over your back, no longer constrained by a fully physical barrier. Unable to get any further pleasure out of your changed body it effortlessly pulls out of your semi-transparent form and flies away with a frustrated wail. ");
				outputText("Yet even as it leaves you like this you feel angry… this asshole used you like a toy for hours on end, and just as you were finally starting to enjoy it he leaves you like that? Right at the edge of your own orgasm? At first you float around and run a hand through your genitals looking for a way to relieve yourself through masturbation but fail to feel anything… your sense of touch is completely dead. ");
				outputText("While you groan in frustration you hear a sound from nearby bushes and float past them to investigate. Here in a clearing, an imp is having its way with a goblin, using the green skinned slut for his pleasure. Before your very eyes, the pair of weaklings achieve an amazing orgasm, the imp blasting his corrupt seed down the goblin pussy. The more you watch, the more frustrated you get. ");
				outputText("How dare these two have pleasure when you can’t enjoy any! Who cares if that bitch was a victim and didn’t want this - at least she gets to enjoy something!\n\n");
				outputText("The fury boils within you, all the while, you’re still, horny and thirsty for life and sensation but as a spectral existence you lost the ability to enjoy the last two properly and can only feel burning jealousy for those two  who still have all of it. You voice your grievance in the most primal way possible, releasing a howling scream of frustration, echoing through Mareth like a death knell. ");
				outputText("Your formerly beautiful magical elven voice has been altered by corruption into an instrument of ruin.  As the soundwave expands outward, patches of grass blackens and withers, turning to dust; buzzing insects drop dead from the air all around you, the area turning ashen grey and devoid of life.\n\n");
				outputText("Finally noticing you, the terrified midget pair stops their wild copulating trying to flee but you grab hold of the goblin and force yourself into her body.\n\n");
				outputText("You need to feel something. You need to wear her. Nothing is going to stop you. YOU. MUST. SATE. YOURSELF. TO. FEEL. AGAIN!\n\n");
				outputText("It takes you mere seconds to overwhelm the terrified goblin's mind and take control of the slut. Her eyes, now your eyes, glow with an eerie blue light as you take command. Now that you're in charge, you smirk wickedly at the imp before grabbing his cock with your jade hand, pulling him closer. Unable to resist your overwhelming advance and aura of dominance, the imp yields control to you as you proceed to mount his huge fiendish cock. ");
				outputText("His eyes cross in delight from your borrowed, gushing gash as you hit orgasm after orgasm, the sensation amplified by corruption. Only when the imp passes out from exhaustion do you relent, ending the possession and leaving the broken goblin behind. While you were in control, you pushed her body far past her limits. It's surprising that she didn’t just die on the spot. ");
				outputText("Not that that's your problem - why would you care for the life of some goblin? You realize that you'll need to keep hopping bodies regularly in order to experience pleasure again - though thanks to the harvested soulforce from the green skank, you will now be able to manifest a solid enough form, to fuck at least semi-normally.\n\n");
				outputText("<b>Your unholy transformation is complete, you have been converted from an elf into a banshee.</b>\n\n");
				transformations.HairSilky.applyEffect(false);
				player.hairColor = randomChoice(BansheeRace.BansheeHairColors);
				transformations.ArmsBanshee.applyEffect(false);
				transformations.LowerBodyBanshee.applyEffect(false);
				transformations.RearBodyGhostlyAura.applyEffect(false);
				transformations.EyesElf.applyEffect(false);
				player.eyes.colour = "pale blue";
				transformations.EarsElven.applyEffect(false);
				transformations.TongueElf.applyEffect(false);
				transformations.FaceElf.applyEffect(false);
				if (!player.hasPlainSkinOnly()) transformations.SkinPlain.applyEffect(false);
                player.skinAdj = "flawless";
				player.skinColor = randomChoice(BansheeRace.BansheeSkinColors);
				if (player.femininity < 70) player.femininity = 70;
				if (player.tone > 60) player.tone = 60;
				if (player.thickness > 50) player.thickness = 50;
				if (player.cor < 20) player.cor = 20;
				if (!player.hasPerk(PerkLib.FlawlessBody)) player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
				if (!player.hasPerk(PerkLib.Incorporeality)) player.createPerk(PerkLib.Incorporeality, 0, 0, 0, 0);
				if (!player.hasPerk(PerkLib.Ethereal)) player.createPerk(PerkLib.Ethereal, 0, 0, 0, 0);
				if (!player.hasPerk(PerkLib.Undeath)) player.createPerk(PerkLib.Undeath, 0, 0, 0, 0);
			}
			else {
				outputText("After skullfucking you for several hours, the thing finally releases its hold on your head, looking for a more combative victim in a endless cycle of sating an unquenchable thirst.\n\n");
				outputText("You drop to the side, your half open eyes lifelessly staring upward. It takes you several minutes to catch up to the fact that the thing has released you, and several more to stand up. You feel like the thing has drained your life within an inch of leaving you an empty husk. You weakly hobble back to camp.\n\n");
				player.addCurse("tou.mult", 0.4, 2);
				player.addCurse("wis.mult", 1.6, 2);
			}
			cleanupAfterCombat();
		}
		
		public function wonWithWraith():void {
			clearOutput();
		//	spriteSelect(SpriteDb.);
			outputText("Completely repelled, the wraith backs off, fleeing into the night. knowing it can’t beat you. You sigh in relief as the monster vanishes into the distance to go look for easier prey to ravish.\n\n");
			menu();
			//addButtonIfTrue(0, "Souleater", SceneLib.uniqueSexScene.hollowSouleater, "Req. Exanimation II perk.", player.hasPerk(PerkLib.ExanimationII));
			addButton(14, "Leave", cleanupAfterCombat);
		}
		
		private function a():void {
			outputText("\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\n\n");
			outputText("\"<i></i>\"\n\n");
		}
	}
}