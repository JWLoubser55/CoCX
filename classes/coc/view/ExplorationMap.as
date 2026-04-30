package coc.view {
import classes.CoC;
import classes.Scenes.API.ExplorationEngine;
import classes.Scenes.API.ExplorationEntry;

import flash.display.Graphics;

import flash.display.Sprite;
import flash.text.TextField;

public class ExplorationMap extends Sprite {
	public function ExplorationMap() {
	}

	public function addNode(node:ExplorationMapNode):void {
		addChild(node);
	}

	public function drawOrthoLine(
			from:ExplorationEntry,
			to:ExplorationEntry,
			width: int,
			color:String,
			lineText: String = ""
	):void {
		var g:Graphics = graphics;
		g.lineStyle(width, Color.convertColor(color));
		g.moveTo(from.centerX, from.centerY);
		var midx:Number = (from.centerX + to.centerX) / 2;
		g.lineTo(midx, from.centerY);
		g.lineTo(midx, to.centerY);
		if (lineText) {
			var tf:TextField = UIUtils.newTextField({
				text             : lineText,
				x                : midx + 2,
				y                : to.centerY,
				defaultTextFormat: {
					font : CoC.instance.mainView.mainText.defaultTextFormat.font,
					size : Number(CoC.instance.mainView.mainText.defaultTextFormat.size) - 2,
					color: CoC.instance.mainView.mainText.defaultTextFormat.color
				}
			});
			addChild(tf);
			tf.y -= tf.height;
		}
		g.lineTo(to.centerX, to.centerY);
	}
	public function drawLine(
			from: ExplorationEntry,
			to: ExplorationEntry,
			width: int,
			color: String
	): void {
		var g:Graphics = graphics;
		g.lineStyle(width, Color.convertColor(color));
		g.moveTo(from.centerX, from.centerY);
		g.lineTo(to.centerX, to.centerY);
	}
}
}
