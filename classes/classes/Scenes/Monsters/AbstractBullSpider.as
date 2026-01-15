/**
 * Created by aimozg on 18.01.14.
 */
package classes.Scenes.Monsters
{
	import classes.*;
	import classes.Items.*
	import classes.Scenes.Areas.Swamp.AbstractSpiderMorph;
	
	public class AbstractBullSpider extends AbstractSpiderMorph
	{
		
		public function AbstractBullSpider() 
		{}
		
		public function toxicBreathBullSpider():void {
			var damage:Number = (eBaseStrengthDamage() + eBaseToughnessDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("[monster He] inhale deeply, then blow a toxic breath attack toward you! ");
			player.takePoisonDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.PoisonDoT)) player.addStatusValue(StatusEffects.PoisonDoT, 1, 1);
			else player.createStatusEffect(StatusEffects.PoisonDoT, 3, 0.02, 0, 0);
		}
		
	}

}