/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp;
//import classes.Scenes.NPCs.Charybdis;
import classes.internals.SaveableState;
	public class CaiLinFollower extends NPCAwareContent implements SaveableState
	{
		public static var CailinSeenState:int;
		public static var CailinTitSize:int;
		public static var CailinWingState:int;
		public static var CailinHipState:int;
		public static var CailinAssState:int;
		public static var CailinAffection:int;
		public static var CailinIgnamState:int;
		public static var CailinSeenBolthole:int;
		public static var CailinBurkerKingState:int;
		public static var CailinPreg:int;
		public static var CailinSnekKids:int;

		public function stateObjectName():String {
			return "CailinFollower";
		}
		public function CaiLinFollower() 
		{
			Saves.registerSaveableState(this);
		}

		public function resetState():void {
			CailinSeenState =0;
			CailinTitSize =0;
			CailinWingState =0;
			CailinHipState =0;
			CailinAssState =0;
			CailinAffection =0;
			CailinIgnamState =0;
			CailinSeenBolthole =0;
			CailinBurkerKingState =0;
			CailinPreg =0;
			CailinSnekKids =0;
		}

		public function saveToObject():Object {
			return {
				"CailinSeenState": CailinSeenState,
				"CailinTitSize": CailinTitSize,
				"CailinWingState": CailinWingState,
				"CailinHipState": CailinHipState,
				"CailinAssState": CailinAssState,
				"CailinAffection": CailinAffection,
				"CailinIgnamState": CailinIgnamState,
				"CailinSeenBolthole":CailinSeenBolthole,
				"CailinBurkerKingState": CailinBurkerKingState,
				"CailinPreg": CailinPreg,
				"CailinSnekKids": CailinSnekKids
			}
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				CailinSeenState = o["CailinSeenState"];
				CailinTitSize= o["CailinTitSize"];
				CailinWingState= o["CailinWingState"];
				CailinHipState= o["CailinHipState"];
				CailinAssState= o["CailinAssState"];
				CailinAffection= o["CailinAffection"];
				CailinIgnamState= o["CailinIgnamState"];
				CailinSeenBolthole= o["CailinSeenBolthole"];
				CailinBurkerKingState= o["CailinBurkerKingState"];
				CailinPreg= o["CailinPreg"];
				CailinSnekKids= o["CailinSnekKids"];

			} else {
				// loading from old save
				resetState();
			}
		}
		/*
		public function aaa():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		
		public function aaa():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		
		public function aaa():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		
		public function aaa():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		*/
	}
}