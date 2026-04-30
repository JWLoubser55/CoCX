package coc.view {
import classes.internals.Utils;

import flash.display.Graphics;

import flash.display.Sprite;
import flash.text.TextField;

public class StatOrbBar extends Block {

	private static function factoryReset():Object {
		return {
			width: 160,
			height: 160,
			radius: 75,
			minValue: 0,
			maxValue: 100,
			rawValue: 0,
			animate: true,
			bgColor: '#000000',
			bgAlpha: 0.1,
			barColor: '#0000ff',
			barAlpha: 1.0,
			minBarColor: '#8080ff',
			minBarAlpha: 1.0,
			hasValue: true,
			hasMaxValue: true,
			hasMinValue: false,
			hasMinBar: false,
			percentage: false,
			numberStyle: 'kmb'
		}
	}
	private static var DEFAULT_OPTIONS:Object     = factoryReset();
	public static function setDefaultOptions(options:Object):void {
		Utils.extend(DEFAULT_OPTIONS,options);
	}
	public static function resetDefaultOptions():void {
		DEFAULT_OPTIONS = factoryReset();
	}

	private var _radius:Number;
	private var _bgOrb:Sprite;
	private var _mainOrb:Sprite;
	private var _mainMask:Sprite;
	private var _minOrb:Sprite;
	private var _minMask:Sprite;
	private var _valueLabel: TextField;
	private var _minValueLabel: TextField;
	private var _maxValueLabel: TextField;
	private var _hasValue: Boolean;
	private var _hasMaxValue: Boolean;
	private var _hasMinValue: Boolean;
	private var _hasMinBar: Boolean;
	private var _tween:SimpleTween;
	private var _animate:Boolean;
	private var _numberStyle:String;
	private var _minValue:Number;
	private var _maxValue:Number;
	private var _value:Number;

	public function StatOrbBar(options:Object) {
		super();
		options = Utils.extend({},DEFAULT_OPTIONS, options);
		_hasValue = options.hasValue;
		_hasMaxValue = options.hasMaxValue;
		_hasMinValue = options.hasMinValue;
		_hasMinBar = options.hasMinBar;

		var myWidth:Number = options.width;
		var myHeight:Number = options.height;
		_radius = options.radius;
		const orbSize:Number = _radius*2;
		var orbX:Number = (myWidth-orbSize)/2;
		var orbY:Number = (myHeight-orbSize)/2;

		if (options.bgAlpha > 0.0) {
			_bgOrb = new Sprite();
			_bgOrb.x = orbX;
			_bgOrb.y = orbY;
			drawCircle(_bgOrb.graphics, _radius, _radius, _radius, options.bgColor, options.bgAlpha);
			addElement(_bgOrb);
		}

		_mainOrb = new Sprite();
		_mainOrb.x = orbX;
		_mainOrb.y = orbY;
		drawCircle(_mainOrb.graphics, _radius, _radius, _radius, options.barColor, options.barAlpha);
		_mainMask = new Sprite();
		_mainMask.x = orbX;
		_mainMask.y = orbY;
		_mainOrb.mask = _mainMask;
		addElement(_mainMask);
		addElement(_mainOrb);

		if (_hasMinBar) {
			_minOrb = new Sprite();
			_minOrb.x = orbX;
			_minOrb.y = orbY;
			drawCircle(_mainOrb.graphics, _radius, _radius, _radius, options.minBarColor, options.minBarAlpha);
			_minMask = new Sprite();
			_minMask.x = orbX;
			_minMask.y = orbY;
			_minOrb.mask = _minMask;
			addElement(_minMask);
			addElement(_minOrb);
		}

		if (_hasValue) {
			_valueLabel = addTextField({
				x: 0,
				y: myHeight/2-15,
				width: myWidth,
				height: 30,
				defaultTextFormat: {
					font: 'Georgia',
					size: 20,
					align: 'center'
				},
				filters: [UIUtils.outlineFilter("#ffffff")]
			});
		}
		if (_hasMinValue) {
			_minValueLabel = addTextField({
				x: 0,
				y: myHeight-30,
				width: myWidth,
				height: 30,
				defaultTextFormat: {
					font: 'Georgia',
					size: 20,
					align: 'center'
				}
			})
		}
		if (_hasMaxValue) {
			_maxValueLabel = addTextField({
				x: 0,
				y: 0,
				width: myWidth,
				height: 30,
				defaultTextFormat: {
					font: 'Georgia',
					size: 20,
					align: 'center'
				}
			})
		}

		UIUtils.setProperties(this, options);
		update();
	}

	public function get minValue():Number {
		return _minValue;
	}
	public function set minValue(value:Number):void {
		_minValue = value;
		if (_hasMaxValue) renderValue();
		update();
	}
	public function get maxValue():Number {
		return _maxValue;
	}
	public function set maxValue(value:Number):void {
		if (_tween && _maxValue != value) {
			_tween.fastForward();
		}
		_maxValue = value;
		if (_hasMaxValue) renderValue();
		update();
	}
	public function get rawValue():Number {
		return _value;
	}
	public function set rawValue(value:Number):void {
		_value    = value;
		renderValue();
		update();
	}
	public function get numberStyle():String {
		return _numberStyle;
	}
	public function set numberStyle(value:String):void {
		_numberStyle = value;
		renderValue();
	}
	public function get value():Number {
		return _value;
	}
	public function set value(value:Number):void {
		if (_animate) {
			if (_tween && _tween.endVal != value) {
				// animating
				_tween = _tween.retarget(value);
			} else if (_value != value) {
				// not animating
				_tween = new SimpleTween(this, "rawValue", value, 300, {easing: "linear"});
			}
		} else {
			rawValue = value;
		}
	}
	public function get animate():Boolean {
		return _animate;
	}
	public function set animate(value:Boolean):void {
		_animate = value;
		if (!value && _tween) {
			_tween.fastForward();
			_tween = null;
		}
	}
	public function get valueText():String {
		return _valueLabel ? _valueLabel.text : value + '';
	}
	public function set valueText(value:String):void {
		if (_valueLabel) _valueLabel.text = value;
	}
	public function update():void {
		var f:Number;
		var size:Number = 2*_radius;
		if (_mainMask) {
			f = Utils.boundFloat(0, value/maxValue, 1) * size;
			_mainMask.graphics.clear();
			_mainMask.graphics.beginFill(0x000000);
			_mainMask.graphics.drawRect(0, size, size, size);
			_mainMask.graphics.endFill();
			_mainMask.graphics.beginFill(0xff0000);
			_mainMask.graphics.drawRect(0, size-f, size, f);
			_mainMask.graphics.endFill();
		}
		if (_minMask) {
			f = Utils.boundFloat(0, 1-minValue/maxValue, 1) * size;
			_minMask.graphics.clear();
			_minMask.graphics.beginFill(0x000000);
			_minMask.graphics.drawRect(0, size, size, size);
			_minMask.graphics.endFill();
			_minMask.graphics.beginFill(0xff0000);
			_minMask.graphics.drawRect(0, size-f, size, f);
			_minMask.graphics.endFill();
		}
		renderValue();
	}
	private function format(value:Number):String {
		switch (_numberStyle) {
			case 'raw':
				return String(value);
			case 'kmb':
				return StatBar.shortHandNumber(value);
			case 'comma':
				return Utils.addComma(value);
		}
		return '';
	}
	private function renderValue():void {
		if (_valueLabel) {
			_valueLabel.text = format(value);
		}
		if (_minValueLabel) {
			_minValueLabel.text = format(minValue);
		}
		if (_maxValueLabel) {
			_maxValueLabel.text = format(maxValue);
		}
	}

	public static function drawCircle(g:Graphics, cx:Number, cy:Number, radius:Number, fillColor:*, fillAlpha:Number):void {
		g.clear();
		fillColor = UIUtils.convertColor(fillColor);
		g.beginFill(fillColor, fillAlpha);
		g.drawCircle(cx,cy,radius);
		g.endFill();
	}

	override public function get width():Number {
		return super.width;
	}

	override public function set width(value:Number):void {
	}

	override public function get height():Number {
		return super.height;
	}

	override public function set height(value:Number):void {
	}
}
}
