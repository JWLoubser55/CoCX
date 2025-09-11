/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Items.*;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class DianaFollower extends NPCAwareContent implements SaveableState
	{

		public static var DianaState:Number;
		//public static var AhriTavernTalks:Boolean;
		//public static var DianaTavernTalks3:Number;

		public function stateObjectName():String {
			return "DianaFollower";
		}

		public function resetState():void {
			DianaState = 0;
			//AhriTavernTalks = false;
			//DianaTavernTalks3 = 0;
		}

		public function saveToObject():Object {
			return {
				"DianaState": DianaState//,
				//"AhriTavernTalks": AhriTavernTalks,
				//"DianaTavernTalks3": DianaTavernTalks3
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				DianaState = o["DianaState"];
				//AhriTavernTalks = valueOr(o["AhriTavernTalks"], false);
				//DianaTavernTalks3 = valueOr(o["DianaTavernTalks3"], 0);
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function DianaFollower() {
			Saves.registerSaveableState(this);
		}

public function dianaTalkName():void {
	clearOutput();
	outputText("\"<i>I'm sorry but this is nothing i'm willing to talk about.</i>\" She shakes her head, \"<i>That's also a very personal matter.</i>\" As she gently dismissed you, a visibly wounded patient hobbled to the table. \"<i>Since you do not need any treatment, I have to attend to the other patients.</i>\"");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(5);
}
public function dianaTalkYourself():void {
	clearOutput();
	outputText("\"<i>Oh, I'm nobody. Just another healer, assisting anyone in the village that needs my aid… Like many others in the village…</i>\"");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(5);
}
public function dianaTalkJob():void {
	clearOutput();
	outputText("\"<i>What kind of job?</i>\"n\n");
	outputText("You intended one that would require leaving the village.\n\n");
	outputText("\"<i>Leaving He'Xin'Dao?</i>\" She hesitates. \"<i>I do not feel the need to move anywhere. Perhaps to somewhere that is lacking a healer. Maybe...</i>\"\n\n");
	if (DianaState < 1) DianaState = 1;
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(10);
}
public function dianaTalkInvite2Camp():void {
	if (DianaState > 2) dianaTalkInvite2CampRepeat();
	else dianaTalkInvite2CampFirst();
}
public function dianaTalkInvite2CampFirst():void {
	clearOutput();
	outputText("After thinking it over, you feel that your [camp] would need a dedicated healer, one that could help with any injuries or negative ailments.\n\n");
	outputText("She ponders the thought for only a fleeting moment, \"<i>I would need to check if there will be anyone that could replace me. Please come tomorrow.</i>\"\n\n");
	DianaState = 2;
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(10);
}
public function dianaTalkInvite2CampRepeat():void {
	clearOutput();
	outputText("Seeing the healer again, you ask if she checked the matter you discussed with her.\n\n");
	outputText("\"<i>Um. I do.</i>\" She sounds a bit... disappointed or perhaps resigned. \"<i>Apparently, there is a surplus of healers in this village, and the leading council of elders aren't particularly interested in stopping one or two of healers from moving to a different settlement.</i>\"\n\n");
	outputText("Does it mean if she wants, she could just move out?\n\n");
	outputText("After a short sigh, she answers. \"<i>Yes. I just need to notify the elders about it and then would be free to leave. So, you still need a healer in your [camp]?</i>\"\n\n");
	menu();
	addButton(1, "No", dianaTalkInvite2CampRepeatNo);
	addButtonDisabled(3, "Yes", "Owen. Yes that right. You left owen turn on at the camp so you must come be back asap.");
}
public function dianaTalkInvite2CampRepeatNo():void {
	clearOutput();
	outputText("You need to prepare a few things at home first before she can join you.\n\n");
	outputText("\"<i>Well, okay. Just let me know.</i>\" She replies in low spirits, but it does not last long as a patient appears, thus she excuses herself before you.\n\n");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(15);
}
public function dianaTalkInvite2CampRepeatYes():void {
	clearOutput();
	outputText("\"<i></i>\"");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMainTalk);
	advanceMinutes(45);
}

public function dianaMenuMain():void {
	
	outputText("\"<i></i>\"");
	
}

public function dianaAppearance():void {
	
	outputText("\"<i></i>\"");
	
}

public function dianaTalkMenuMain():void {
	
	outputText("\"<i></i>\"");
	
}

public function uncurseCost(item:IDynamicItem, equipped:Boolean):int {
	var cost:int = 250 * (1 + item.rarity);
	if (equipped) cost *= 2;
	return cost;
}
public function dianaAtJttECursedItemsRemoval1():void {
	clearOutput();
	outputText("Uncurse which item?");
	var buttons:ButtonDataList = new ButtonDataList();
	var cost:int;
	for each (var slot:ItemSlotClass in player.carriedKnownCursedItems()) {
		cost = uncurseCost(slot.itype as IDynamicItem, false);
		buttons.add(slot.itype.shortName, curry(uncurseItem, slot))
				.hint("Lift the curse from "+slot.itype.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	for each (var item:ItemType in player.equippedKnownCursedItems()) {
		cost = uncurseCost(item as IDynamicItem, true);
		buttons.add(item.shortName, curry(uncurseEquippedItem,item))
				.hint("Lift the curse from "+item.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	submenu(buttons, SceneLib.journeyToTheEast.dianaAtJttEMain, 0, false);
}
public function uncurseItem(slot:ItemSlotClass):void {
	clearOutput();
	var newItem:ItemType = (slot.itype as IDynamicItem).uncursedCopy();
	outputText("The curse is lifted from "+slot.itype.longName);
	slot.setItemAndQty(newItem, slot.quantity);
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
}
public function uncurseEquippedItem(item:ItemType):void {
	clearOutput();
	var newItem:ItemType = (item as IDynamicItem).uncursedCopy();
	player.replaceEquipment(item as Equipable, newItem as Equipable);
	outputText("The curse is lifted from "+newItem.longName+". You can unequip it now.");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
}
public function dianaAtJttECursedItemsRemoval2():void {
	menu();
	if (player.weaponRange == weaponsrange.SAGITTB) addButton(0, "Cursed Bow", dianaAtJttECursedItemsRemovalBow);
	if (player.necklace == necklaces.SILCNEC) addButton(1, "Cursed Necklace", dianaAtJttECursedItemsRemovalNecklace);
	addButton(14, "Back", SceneLib.journeyToTheEast.dianaAtJttEMain);
}
public function dianaAtJttECursedItemsRemovalBow():void {
	clearOutput();
	outputText("As horse healer proceed with the purification ritual you struggle in pain at first as you feel the cursed weapon in your hand resist the unbinding before release washes over you as your grip opens dropping the malevolent item on the ground. ");
	outputText("Horse healer wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
	player.gems -= 500;
	player.removeStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
	player.createStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow,1,0,0,0);
	if (player.statStore.hasBuff('Sagittarius Curse')) player.buff("Sagittarius Curse").remove();
	if (player.statStore.hasBuff('Sagittarius Focus')) player.buff("Sagittarius Focus").remove();
	player.unequipWeaponRange(false,true);
	inventory.takeItem(weaponsrange.SAGITTB, SceneLib.journeyToTheEast.dianaAtJttEMain);
}
private function dianaAtJttECursedItemsRemovalNecklace():void {
	clearOutput();
	outputText("As horse healer proceed with the purification ritual you struggle in pain at first as you feel the cursed necklace resist the unbinding before release washes over you. ");
	outputText("Horse healer wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
	player.gems -= 500;
	player.unequipNecklace(false,true);
	inventory.takeItem(necklaces.SILCNEC, SceneLib.journeyToTheEast.dianaAtJttEMain);
}
	}
}
//