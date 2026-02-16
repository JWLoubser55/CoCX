package coc.view {
import classes.internals.Utils;

import flash.display.DisplayObject;

public class LoopedTween {
	/**
	 * Animate a property `prop` of sprite `spr` from its current value to `endVal` and then back (or again)
	 * @param spr
	 * @param prop
	 * @parma endVal
	 * @param ms Animation duration in milliseconds
	 * @param {Function} [options.easing] Easing function, default mx.effects.easing.Expontential.easeInOut
	 * @param {Boolean} [options.color] The values are colors
	 * @param {Boolean} [options.alternate]
	 * - (default) true: start->end, end->start, start->end, ...
	 * - false: start->end, start->end, start->end, ...
	 * @param {Boolean} [options.reset]
	 * - (default) 'start': reset to initial value
	 * - 'end': reset to end value
	 * @param {Function} [options.onEnd] Function to (repeatedly) call on reaching looping point
	 */
	public function LoopedTween(
			spr: DisplayObject,
			prop: String,
			endVal: *,
			ms:int = 300,
			options: Object = null
	) {
		this._spr      = spr;
		this._prop     = prop;
		this._startVal = _spr[_prop];
		this._endVal   = endVal;
		this._duration = ms;
		this._alternate   = Utils.valueOr(options && options.repeat, true);
		this._color    = Utils.valueOr(options && options.color, false);
		this._easing   = Utils.valueOr(options && options.easing, "easeInOut");
		this._reset = Utils.valueOr(options && options.reset, 'start');
		this._onEnd = Utils.valueOr(options && options.onEnd, null);

		createTween();
	}

	private var _st: SimpleTween;
	private var _fwd: Boolean = true;
	private var _active: Boolean = true;

	private var _spr: DisplayObject;
	private var _prop: String;
	private var _startVal: *;
	private var _endVal: *;
	private var _duration: int;
	private var _alternate: Boolean;
	private var _color: Boolean;
	private var _easing: String;
	private var _onEnd: Function;
	private var _reset: String;

	private function createTween():void {
		_st = new SimpleTween(
				_spr,
				_prop,
				_fwd ? _endVal : _startVal,
				_duration,
				{
					easing: _easing,
					color: _color,
					onEnd: onTweenEnd
				}
		);
	}
	private function onTweenEnd():void {
		if (_active) {
			if (_alternate) _fwd = !_fwd;
			if (_onEnd != null) _onEnd();
			createTween();
		}
	}
	public function stop():void {
		_active = false;
		_st.dispose();
		var value:* = _reset == 'start' ? _startVal : _endVal;
		if (_color) {
			value = Color.convertColor32(value);
		}
		_spr[_prop] = value;
	}
}
}
