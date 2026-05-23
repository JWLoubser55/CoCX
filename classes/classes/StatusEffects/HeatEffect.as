package classes.StatusEffects {
import classes.IMutations.IMutationsLib;
import classes.StatusEffectClass;
import classes.StatusEffectType;

    public class HeatEffect extends StatusEffectClass {
        public static const TYPE:StatusEffectType = register("heat", HeatEffect);
        public function HeatEffect () {
            super(TYPE);
        }

        override public function onAttach():void {
            ApplyEffect();
        }

        public function ApplyEffect():void {
            if (host.perkv1(IMutationsLib.HellcatParathyroidGlandsIM) >= 4) host.buff("Rut").setStats({"int.mult":value2,"lib.mult":value2,"sens":value2*100/2}).withText("Rut");
			else host.buff("Heat").setStats({"lib.mult":value2, "sens":value2*100/2}).withText("Heat");
        }

        override public function onRemove():void {
            host.buff("Heat").remove();
        }

        //public function CurrentLibidoBuff():Number {
        //}
        //public function CurrentFertilityBuff():Number {
        //}
    }
}

