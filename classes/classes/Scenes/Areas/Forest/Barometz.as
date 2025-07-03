/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

import coc.view.CoCButton;

public class Barometz extends Monster
	{
		override protected function performCombatAction():void
		{
			
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.barometzScene.barometzDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.forest.barometzScene.barometzDeepwoodsLost();
		}
		
		public function Barometz() 
		{
			this.a = "a ";
			this.short = "barometz";
			this.long = "You are fighting a barometz. This centauress is half plant, half goat and half human. While she pretend to be guarding the area you trespassed in, the excited look in her eyes and the writhing set of green tentacle cocks at her crotch tells you she was really just looking for a good excuse to fuck you. She wields a gnarled wooden staff for a weapon and appears to excel in nature magic.";
			initStrTouSpeInte(30, 420, 30, 180);
			initWisLibSensCor(180, 300, 150, 10);
			this.armorDef = 450;
			this.armorMDef = 60;
			this.bonusHP = 1500;
			this.bonusLust = 500;
			this.level = 50;
			this.drop = new WeightedDrop().
			add(consumables.RAUNENECT,7).
			addMany(1,consumables.HORNFRU,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.imageName = "barometz";
			checkMonster();
		}
		
	}

}
