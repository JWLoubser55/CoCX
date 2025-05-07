/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.BaseContent;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.PerkLib;
import classes.Races;
import classes.Races.MyconidRace;
import classes.StatusEffects;
import classes.VaginaClass;

public class MatangoScene extends BaseContent
{
	public function MatangoScene() {}

public function mantangoEncounter():void {
	clearOutput();
	if (player.isRaceCached(Races.MYCONID)) {
		outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest. At first, you marvel at the bioluminescent spectacle, exploring the beautiful mushroom forest, but your wonder is short lived as what sounded like a lusty woman moan coming from behind you interrupts your sightseeing.\n\nTurning around to confront this new threat, ")
		outputText("you are greeted by the sight of a mushroom girl. She, just like you, is covered in fungal growth. For a moment you think she is going to attack you before you remember you both are fungi now, there is no reason for her to do anything to you and as such she indeed walks past you like if nothing happened. Guess you won’t need to worry about the matango’s trying to rape you for the time being.\n\n");
		endEncounter();
        return;
	}
	outputText("As you explore the caves, you arrive in an area filled with what appears to be a glowing giant mushroom forest. At first, you marvel at the bioluminescent spectacle, exploring the beautiful mushroom forest, but your wonder is short lived as what sounded like a lusty woman moan coming from behind you interrupts your sightseeing.\n\n");
	outputText("Turning around to confront this new threat, you are greeted by the sight of a human woman… or what used to be one? Her body seems to be partially transformed into something that looks like mushroom frills in a fashion reminiscent of a dress, but no matter how you look at it, this dress is actually growing out of her body. Atop her head grows a small, white glowing mushroom cap, not unlike the local mushrooms.\n\n");
	outputText("She stumbles toward you at a slow, zombie-like pace. Those lust-glazed eyes and drooling smile of hers promises a “feels gud” time should she get the better of you.\n\n");
	outputText("<b>It's a fight!</b>");
	startCombat(new Matango());
}
public function gainingMatango():void {
	clearOutput();
	player.addPerkValue(PerkLib.FungalNobility, 1, 1);
	outputText("As you explore the cave you run into a lone mushroom girl. She seems lost and not all too smart, there's no telling what kind of mishap could happen to her should you simply let her wander alone in the dark. Like the good big "+player.mf("brother","sister")+" you are, you firmly tell her to follow you around so you can protect her.\n\n");
	outputText("The not so bright little sister obeys you without protest, religiously bowing her cap to you along the way. Damn it feels good to be willingly served by others of your kind. ");
	if (player.perkv1(PerkLib.FungalNobility) < player.matangoControlLimit()) outputText("You recall you could use a few more like her still");
	else outputText("However you have started to strain your mind trying to keep all those new matango in an orderly line. Perhaps you should stop taming new matango until you are stronger");
	outputText(".\n\nYou now have "+player.perkv1(PerkLib.FungalNobility)+" mushroom servants.\n\n");
	endEncounter();
}

public function winningOverMantango():void {
	clearOutput();
	outputText("The mushroom-infested woman falls on the floor, defeated. She looks at you frustrated, but can’t seem to fight anymore. Looking at what became of her body, something in you keenly knows whatever made a horny mess out of her is highly contagious. ");
	outputText("Unless you got a means to have indirect sex with her or got some sort of special immunity granted by your race or anatomy, it'd be best you passed on this fuck entirely. Regardless, normal sex isn’t an option here.\n\n");
	menu();
	addButton(14, "Leave", winningOverMantangoLeave);
	SceneLib.uniqueSexScene.pcUSSPreChecksV2(winningOverMantango);
}
public function winningOverMantangoLeave():void {
	outputText("Yeah, no. It ain’t worth the damn risk! You leave her be and resume your exploration.\n\n");
	cleanupAfterCombat();
}

public function losingToMantango():void {
	clearOutput();
	if (rand(4) == 0) {
		outputText("You fall on the ground, defeated, but just as you are about to get thoroughly violated, a cave wyrm rampages through the area.\n\n");
		outputText("\"<i>GIVE ME YOUR COCK SHROOM BITCH, I NEED IT FOR MY EGGS!!</i>\"\n\n");
		outputText("Under your confused stare, the horny lizard steals away the mushroom infested woman and runs off into the dark. Damn, that was close, better not lose again. There’s no chance such luck will happen twice.\n\n");
		cleanupAfterCombat();
	}
	else {
		if (player.blockingBodyTransformations()) {
			outputText("Information Noona informs you that director Liadri now have script for this case, which is been uinable to be TF'd.\n\n");
		}
		else {
			var randon:Number = 0;
			if (player.gender > 2 && rand(2) == 0) randon += 1;
			outputText("As you fall, defeated, the heavily corrupted girl makes a dopey smile as she saunters toward you. You desperately try to repel her, but to no avail. She pushes you to the ground, using her small, but deceivingly strong arm to lock you down and, before you know it, your face is right in front of her drooling vagina.\n\n");
			outputText("You want to emit a protest, but the sound dies in your throat as her lips part ways on their own, something like a giant mushroom pushing them apart to set squarely in front of you before it unleashes a cloud of spores into your nose.\n\nWeary and too surprised by this sudden attack, you breathe it all in as a reflex. ");
			outputText("Suddenly very horny, all you can think about is this slimy mushroom in front of you, which you proceed to lick and put into your mouth. Shroom… Shroom, everything in your head is mush now. The mushroom girl moans as you proceed to eat out her shroomy clit with wild abandon, rewarding you by shooting spores right into your welcoming throat as she lustfully ");
			if ((player.hasCock() && !player.hasVagina()) || randon < 1) outputText("sucks your cock");
			if ((player.hasVagina() && !player.hasCock()) || randon > 0) outputText("eats your pussy out\n\n");
			if (!player.hasCock() && !player.hasVagina()) outputText("caresses your body to make up for the lack of your sexual endowments");
			outputText(".\n\nThinking becomes increasingly harder the more you breathe in the spores as your brain is reduced to complete mush, both addled by sex and by the fungal spore spreading in your body. Breed… fuck… spread… this is all your mind needs to think about right now, everything else is inconsequential. Distracted as you are, ");
			outputText("you fail to notice the small shroom cap growing up your head as your hair strands turn white like those of your partner.\n\nMany parts of your body changes starting with your back which grows a beautiful, long, organic skirt, not unlike a shroom frill to match the color of the small growing mushroom on your head as your arms grow frilled sleeves similar to those on ankles. ");
			outputText("Completing this setup, a frilly necklace and bra grows on your body as well. By the sixth ejaculation, you look just like the shroom girl. Well not exactly like her yet, the cap on your head is way smaller and there's still a last part of you that has to change first.\n\nYou cum hard into the mushroom girl’s mouth as ");
			if (player.hasVagina()) outputText("your clit suddenly engorges, growing longer and fatter into a mushroom-like shape you recognise is the same as the mushroom girl in front of you. It seems your clit grew into a mushroom-like penis that slides right out of your vagina");
			if (player.gender > 2) outputText(". Meanwhile ");
			if (player.hasCock()) outputText("your cock suddenly throbs as it undergoes changes, the crown and shape changing to match that of your fungal captor");
			outputText(".\n\nSensing that you have finally been fully infected, the mushroom girl relents and pulls off from you, walking away to seek out new victims to spread her spores to. You would do the same, but perhaps by virtue of your strong willpower, you manage to control yourself from fully giving into your parasitic instincts. ");
			outputText("Defeated and tired, you go back to camp with a new perspective and mindset all the same. You can’t help but think how good it would be to slide your mushroom down someone's throat.\n\n");
			transformations.HairGlowingMushroom.applyEffect(false);
			player.hairColor = randomChoice(MyconidRace.MyconidHairColors);
			transformations.ArmsShroom.applyEffect(false);
			transformations.HornsShroomHeadcap.applyEffect(false);
			transformations.LowerBodyShroomShirt.applyEffect(false);
			transformations.RearBodyMyconidBraAndNeck.applyEffect(false);
			transformations.EyesHuman.applyEffect(false);
			transformations.WingsNone.applyEffect(false);
			transformations.TailNone.applyEffect(false);
			transformations.EarsHuman.applyEffect(false);
			transformations.TongueHuman.applyEffect(false);
			transformations.FaceHuman.applyEffect(false);
			transformations.SkinPlain.applyEffect(false);
			if (player.breastRows.length == 0) transformations.CreateBreastRow(4).applyEffect(false);
			else player.growTits(4, 1, false, 3);
			player.skinColor = randomChoice(MyconidRace.MyconidSkinColors);
			if (player.hasVagina() && player.vaginaType() != VaginaClass.SHROOM) transformations.VaginaShroom().applyEffect(false);
			if (player.clitLength < 10) player.clitLength = 10;
			if (player.hasCock()) transformations.CockShroom().applyEffect(false);
			if (!player.hasStatusEffect(StatusEffects.GlowingNipples)) transformations.NipplesGlowing.applyEffect(false);
			if (!player.hasStatusEffect(StatusEffects.GlowingAsshole)) transformations.AssholeGlowing.applyEffect(false);
			if (!player.hasPerk(PerkLib.Androgyny)) player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
			if (player.tone > 9) player.tone = 9;
		}
		cleanupAfterCombat();
	}
}
}//outputText("\"<i></i>\"\n\n");
}