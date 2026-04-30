package coc.view {
import classes.CoC;

import flash.display.Graphics;

import flash.display.Sprite;

import flash.events.MouseEvent;
import flash.text.TextField;

import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class ExplorationMapNode extends Sprite {
	public static const RADIUS:Number   = 16;
	private static const BORDER_WIDTH:Number   = 3;
	public var tfLabel:TextField;
	public function get centerX():Number { return x + RADIUS; }
	public function get centerY():Number { return y + RADIUS; }
	public function ExplorationMapNode(
			onClick: Function,
			onHover: Function,
			onDim: Function
	) {
		tfLabel         = UIUtils.newTextField({
			x                : 0,
			y                : 2 * RADIUS,
			width            : 2 * RADIUS,
			autoSize         : TextFieldAutoSize.CENTER
		});
//		tfLabel.filters       = [UIUtils.outlineFilter(LABEL_OUTLINE)];
		addChild(tfLabel);

		mouseChildren = false;
		addEventListener(MouseEvent.CLICK, onClick);
		addEventListener(MouseEvent.ROLL_OVER, onHover);
		addEventListener(MouseEvent.ROLL_OUT, onDim);
	}

	public function redraw(
			borderColor:String,
			fillColor:String,
			label:String,
			isButton:Boolean
	):void {
		var g:Graphics = graphics;

		g.clear();
		g.lineStyle(BORDER_WIDTH, Color.convertColor32(borderColor));
		g.beginFill( Color.convertColor32(fillColor));
		g.drawCircle(RADIUS, RADIUS, RADIUS);
		g.endFill();

		var mainTextFormat:TextFormat = CoC.instance.mainView.mainText.defaultTextFormat;
		tfLabel.defaultTextFormat = UIUtils.convertTextFormat({
			font : mainTextFormat.font,
			size : Number(mainTextFormat.size || 12) - 4,
			color: mainTextFormat.color,
			align: 'center'
		});
		tfLabel.text = label;

		buttonMode = isButton;
	}
}
}
