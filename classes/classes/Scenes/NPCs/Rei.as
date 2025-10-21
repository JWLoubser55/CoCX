/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.AbstractFleshGargoyle;

use namespace CoC;
	
	public class Rei extends AbstractFleshGargoyle
	{
		
		public function Rei() 
		{
			super(false);
			this.a = "the ";
			this.short = "corrupted basic flesh golem";
			this.imageName = "corrupted basic flesh golem";
			this.long = "You're currently fighting a corrupted basic flesh golem. She's seven feet tall, her flesh covered sporadically by fragments of what must have once been a decorative set of armor. They seem to have been broken in places, but the shards of armor still provide decent protection. Several large holes in the armor were clearly made intentionally, exposing a throbbing cock and firm breasts. The golem keeps its head aligned with you, large, gaping mouth open constantly. She clutches a pair of swords in her meaty fists.";
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			//this.createVagina(true, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity, 200, 0, 0, 0);
			initStrTouSpeInte(360, 425, 333, 20);
			initWisLibSensCor(20, 200, 100, 100);
			this.tallness = 84;
			this.hips.type = Hips.RATING_AVERAGE + 1;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.bodyColor = "pink";
			this.weaponName = "dual swords";
			this.weaponVerb = "slash";
			this.weaponAttack = 200;
			this.armorName = "white armor";
			this.armorDef = 400;
			this.armorMDef = 200;
			this.bonusHP = 700;
			this.lust = 30;
			this.bonusLust = 354;
			this.lustVuln = .5;
			this.level = 54;
			this.additionalXP = 400;
			this.gems = rand(10)+10;
			this.tailType = Tail.DEMONIC;
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(consumables.BROBREW, 1).
					add(weapons.DDAGGER, 10).
					add(weapons.DL_AXE_, 10).
					add(weapons.DSWORD_, 10).
					add(weapons.DKATANA, 10).
					add(weapons.D_LANCE, 10);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}