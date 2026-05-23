package classes.StatusEffects {
import classes.IMutations.IMutationsLib;
import classes.StatusEffectClass;
import classes.StatusEffectType;

    public class RutEffect extends StatusEffectClass {
        public static const TYPE:StatusEffectType = register("rut", RutEffect);
        public function RutEffect() {
            super(TYPE);
        }

        override public function onAttach():void {
            ApplyEffect();
        }

        public function ApplyEffect():void {
            if (host.perkv1(IMutationsLib.HellcatParathyroidGlandsIM) >= 4) host.buff("Rut").setStats({"int.mult":value2,"lib.mult":value2,"sens":value2*100/2}).withText("Rut");
			else host.buff("Rut").setStats({"lib.mult":value2,"sens":value2*100/2}).withText("Rut");
        }

        override public function onRemove():void {
            host.buff("Rut").remove();
        }

        //public function CurrentLibidoBuff():Number {
        //}
        //public function CurrentFertilityBuff():Number {
        //}
    }
}


