package classes.Scenes.Areas.VolcanicCrag {

import classes.*;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.Races.SalamanderRace;
public class LavaHotspring extends BaseContent implements TimeAwareInterface {
    public function LavaHotspring() {
        EventParser.timeAwareClassAdd(this);
    }

    public function timeChange():Boolean
    {
        var needNext:Boolean = false;
        return needNext;
    }

    public function timeChangeLarge():Boolean {
        return false;
    }

    private var fireRez:Boolean = player.hasPerk(PerkLib.FireAffinity)
    public function discoverLavaHotsprings():void{
        clearOutput()
        if (!fireRez){
            outputText("While exploring the crag, you run into a beautiful hot spring with a running waterfall. The water looks clear albeit smoky. After all the things you've been through, not to mention the ambient heat, your body is practically covered with sweat. It would be quite pleasant and regenerating to take a dip this.");
        }
        else{
         outputText("While exploring the crag, you run into a particular pool of magma with a running lavafall. The heat coming from this spot is nothing short of amazing. You can practically feel the fire element radiating from this pool. If you were still the fleshy human you were before, this would be the very definition of a dumb idea... But seeing as you are literally fireproof you think a lava bath would be quite pleasant and regenerating after the crazy journey you have been on.");
        }

        outputText("Would you like to take a dip?");
        //addButtonIfTrue(1,"Yes",lavaHotspringsBanzai, "Hm... Something just feels off. Like you don't have anything to expose for an accidental slip-up. Maybe if you had some genitals...", (player.hasCock || player.hasVagina));
        addButton(1,"Yes",lavaHotspringsBanzai);
        addButton(3, "No", endEncounter);
    }


    public function lavaHotspringsBanzai():void{
        var tempstr:String = ""
        var MorF:int
        clearOutput();

        outputText("Eager to clean the grime of your previous battles and relax a few minutes, you put your stuff on a rock to the side and submerge yourself up to the neck in the " + (fireRez? "red hot lava" : "steaming water") + " sighing in relief as the bath work out its amazing therapeutic magic, washing you off.\n\n");
        outputText("So hot… so comfortably warm… you can't help but abandon yourself to the delicious sensation as you close your eyes and enjoy the warmth running across your naked flesh.\n\n");

        if (!fireRez){
            outputText("You're so caught in it that you unconsciously begin to use your scaly tail to teasingly brush against your ");
            if (player.hasCock()) tempstr += "hardening member"
            if (player.hasVagina()) tempstr += (tempstr == "" ? "" : "&") + "juicing pussy"
            outputText(tempstr + ", blushing in arousal as you pleasure yourself.\n\n");

            outputText("Wait, what the hell? You open your eyes in confusion as your body begins to change. ");
            becomeSalamander();

            outputText((player.hasTail()? "Instead of your old tail a new one" : "A long reptilian tail grew from your butt. Your brand new tail"));
            outputText(" with [scale colour] is lazily floating in the bath right in front of your sex, and had you not been alerted by the change you would have likely jerked/fucked yourself with it too. " +
                    "The entire length of it is ablaze with fire causing the ambient water to steam even more.\n");
            outputText("Just as you confirm the existence of this new appendage your body begin itching uncontrollably as your arms and legs covers with scales the same color as your tail, the digits of your hands becoming reptile-like and ending up with vicious claws as smaller patches of scales cover the other area of your body heck you can even feel some on your cheeks.\n");
            outputText("Running your now reptilian tongue in your mouth you immediately discover that your canines have also enlarged.\n");
            outputText("Your vision blurs for a moment as vertigo overwhelms you. When your sight finally clears you're no longer bathing in steaming water but an actual pool of molten lava.");
            outputText("What the actual fuck! You've been turned into a horny salamander?! This pool must be magical in nature, some kind of trap designed to appear as a hotspring to the common onlooker maybe? \n\n" +
                    "As if to confirm your theory, a group of reptilian looking people suddenly approach the pool from a distance and you swiftly recognise them as salamanders, the same as you.");
        }
        else{
            outputText("Aroused by the warmth permeating your already smoldering body you begin to ");
            outputText((player.tail.type == Tail.SALAMANDER)? "use your scaly tail to brush" : "rub your fingers");
            outputText(" against your ");
            if (player.hasCock() && player.hasVagina()){
                MorF = rand(1)
            }
            else{
                if(player.hasCock()) MorF = 0
                if(player.hasVagina()) MorF = 1
            }
            outputText(MorF == 0? "hardening member blushing in arousal as you pleasure yourself. With no one watching you proceed to eagerly jerk" : "juicing pussy blushing in arousal as you pleasure yourself. With no one watching you proceed to eagerly rub");
            outputText(" yourself using your " + (player.hasTail() ? "tail as a third prehensile limb" : "hand") + " while you rest your head and " + (player.hasTail() ? "arms" : "free arm") + " against the side of the bath, mouth gaping blissfully, as your mind slowly melt in pleasure, your orgasm closing in.\n\n");
            outputText("The magma deliciously caressing your exposed skin only helps this sexy imagery. Just as your riding toward your peak you are interrupted in your revelry as a group of reptilian looking people approach the pool from a distance.\n\n");
            outputText("You're suddenly interrupted in your meditation as a group of reptilian looking people approach the pool from a distance. You swiftly recognise them as salamanders. This spot must be a quite popular stop in the area for fiery species to stop by.")
        }
        if (SalamanderOreMerchants.VisitedCount > 0) outputText("Come to think of it, you know them. They are the ore peddlers that travel across the volcanic region to mine and sell ore.");

       doNext(steamySalamanderSeggs);
    }

    public function steamySalamanderSeggs():void{
        var MorF:int
        clearOutput();
        outputText("\"The group has a female, a sexy herm and a single male and they are heading your way. The male notices you right away and waves a friendly scaled hand at you.\"");
        outputText("\"Hey, look at that! Someone's already bathing in our favored hotspot! Couldn't resist that soothing warmth either eh? " +
                "How about you share some space and let us in, the more the merrier right?\"");

        outputText("You nod utterly relaxed and too hot and bothered to say no. You're lazily splayed in the bath, ");
        if (player.hasCock()) outputText("your cock" + (player.hasSheath()? " slipping out of its sheathe and" : "") + " twitching");
        if (player.hasCock() && player.hasVagina()) outputText(" while");
        if (player.hasVagina()) outputText(" your hot vaginal fluids mix with the molten lava");
        outputText(" in anticipation. Of course, all of this happens out of sight beneath the lava although the salamanders can somehow tell your mood from the flushed face you make. " +
                "They themselves look to be holding their urge back and it becomes clear real quick that you are all primed to fuck.\n")
        if (player.hasCock() && player.hasVagina()){
            MorF = rand(1)
        }
        else{
            if(player.hasCock()) MorF = 0
            if(player.hasVagina()) MorF = 1
        }
        if (MorF == 0) doNext(salamanderSeggsM)
        else doNext(salamanderSeggsF)
    }

    public function salamanderSeggsM():void{
        clearOutput();
        postSeggsAftercare(false);
    }

    public function salamanderSeggsF():void{
        clearOutput();
        postSeggsAftercare(true);
    }

    public function postSeggsAftercare(MorF:Boolean):void{
        outputText("\"Hey babe, just so you know, that session was damn great. Feel free to visit again if you ever feel like blowing off steam. We tend to hang around here so chances are high we'll meet again!\"");
        if (MorF) outputText("You expected the girls to be jealous and protective of their guys but the pair gives you a thumbs up of approval. ");
        else outputText("The male gives you a thumbs up of approval unsurprisingly, there's no way he alone can satisfy this pair, not that it surprises you.");
        outputText("Through pillow talk, you did learn that salamanders are fond of swapping partners regularly to keep their bed life spicy, " +
                "and you can't say you disagree with that ethic. You still got the cinnamonny taste of one of the girl’s mouth on your lips, what a good kisser!\n\n");
        outputText("You head back to camp slightly more horny and energetic from the session.");

    }

    private function becomeSalamander():void{
        if (player.hasCock()){
            for each(var cockSala:int in player.cocks.length){
                if (player.cocks[cockSala].cockType != CockTypesEnum.LIZARD) {
                    transformations.CockLizard(cockSala).applyEffect(false);
                }
            }
        }
        transformations.LowerBodySalamander(2).applyEffect(false);
        transformations.ArmsSalamander.applyEffect(false);
        transformations.EyesLizard.applyEffect(false);
        transformations.FaceSalamanderFangs.applyEffect(false);
        transformations.EarsLizard.applyEffect(false);
        transformations.SkinScales(Skin.COVERAGE_LOW, {colors: SalamanderRace.SalamanderScaleColors}).applyEffect(false);
        transformations.GillsNone.applyEffect(false);
        transformations.tail.TailSalamander.applyEffect(false);

    }
}
}
