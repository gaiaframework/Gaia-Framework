/*
VERSION: 1.1
DATE: 2/27/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	To change a MovieClip/TextField's tint/color, set this to the hex value of the tint you'd like
	to end up at (or begin at if you're using TweenLite.from()). An example hex value would be 0xFF0000.
	
	To remove a tint completely, use the RemoveTintPlugin (after activating it, you can just set removeTint:true)
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([TintPlugin]); //only do this once in your SWF to activate the plugin (it is already activated in TweenLite and TweenMax by default)
	
	TweenLite.to(mc, 1, {tint:0xFF0000});

	
BYTES ADDED TO SWF: 513 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;
import gs.utils.tween.*;

class gs.plugins.TintPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.1;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _color:Color;
		private var _ct:Object; //color transform
		private var _ignoreAlpha:Boolean;
		
		public function TintPlugin() {
			super();
			this.propName = "tint"; 
			this.overwriteProps = ["tint"];
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			if (typeof($target) != "movieclip" && !($target instanceof TextField)) {
				return false;
			}
			var alpha:Number = ($tween.vars._alpha != undefined) ? $tween.vars._alpha : ($tween.vars.autoAlpha != undefined) ? $tween.vars.autoAlpha : $target._alpha;
			var end:Object = ($value == null || $tween.vars.removeTint == true) ? {rb:0, gb:0, bb:0, ab:0, ra:alpha, ga:alpha, ba:alpha, aa:alpha} : {rb:($value >> 16), gb:($value >> 8) & 0xff, bb:($value & 0xff), ra:0, ga:0, ba:0, aa:alpha};
			_ignoreAlpha = true;
			init($target, end);
			return true;
		}
		
		public function init($target:Object, $end:Object):Void {
			_color = new Color($target);
			_ct = _color.getTransform();
			var i:Number, p:String;
			for (p in $end) {
				if (_ct[p] != $end[p]) {
					_tweens[_tweens.length] = new TweenInfo(_ct, p, _ct[p], $end[p] - _ct[p], "tint", false);
				}
			}
		}
		
		public function set changeFactor($n:Number):Void {
			var i:Number, ti:TweenInfo;
			for (i = _tweens.length - 1; i > -1; i--) {
				ti = _tweens[i];
				ti.target[ti.property] = ti.start + (ti.change * $n);
			}
			if (_ignoreAlpha) {
				var ct:Object = _color.getTransform();
				_ct.aa = ct.aa;
				_ct.ab = ct.ab;
			}
			_color.setTransform(_ct);		
		}
	
}