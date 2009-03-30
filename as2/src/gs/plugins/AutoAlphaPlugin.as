/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Use autoAlpha instead of the _alpha property to gain the additional feature of toggling 
	the "_visible" property to false if/when _alpha reaches 0. It will also toggle _visible 
	to true before the tween starts if the value of autoAlpha is greater than zero.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([AutoAlphaPlugin]); //only do this once in your SWF to activate the plugin (it is already activated in TweenLite and TweenMax by default)
	
	TweenLite.to(mc, 1, {autoAlpha:0});
	
BYTES ADDED TO SWF: 419 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.*;
import gs.plugins.*;

class gs.plugins.AutoAlphaPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _tweenVisible:Boolean;
		private var _visible:Boolean;
		private var _tween:TweenLite;
		private var _target:Object;
		
		private var _tweenAlpha:Boolean;
		private var _alphaStart:Number;
		private var _alphaChange:Number;
		
		public function AutoAlphaPlugin() {
			super();
			this.propName = "autoAlpha";
			this.overwriteProps = ["_alpha","_visible"];
			this.onComplete = onCompleteTween;
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			_target = $target;
			_tween = $tween;
			_visible = Boolean($value != 0);
			_tweenVisible = true;
			_alphaStart = _target._alpha;
			_alphaChange = (typeof($value) == "number") ? $value - _alphaStart : Number($value);
			_tweenAlpha = Boolean(_alphaChange != 0);
			return true;
		}
		
		public function killProps($lookup:Object):Void {
			super.killProps($lookup);
			_tweenVisible = Boolean($lookup._visible == undefined);
			_tweenAlpha = Boolean($lookup._alpha == undefined);
		}
		
		public function onCompleteTween():Void {
			if (_tweenVisible && _tween.vars.runBackwards != true && _tween.ease == _tween.vars.ease) { //_tween.ease == _tween.vars.ease checks to make sure the tween wasn't reversed with a TweenGroup
				_target._visible = _visible;
			}
		}
		
		public function set changeFactor($n:Number):Void {
			if (_tweenAlpha) {
				_target._alpha = _alphaStart + (_alphaChange * $n);
			}
			if (_target._visible != true && _tweenVisible) {
				_target._visible = true;
			}
		}
		
}