/**
 * ...
 * @author ...
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.CoC;

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
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
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
		//	if (player.hasStatusEffect(StatusEffects.ChainOfFate) || player.hasStatusEffect(StatusEffects.DarkSign) || !player.blockingBodyTransformations()) {
		//		outputText("\n\n");
		//		outputText("\n\n");
				cleanupAfterCombat();
		//	}
		//	else {
		//		outputText("\n\n");
		//		EventParser.gameOver();
		//	}
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