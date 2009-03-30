/*
VERSION: 1.02
DATE: 1/31/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Tweens numbers in an Array. 
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([EndArrayPlugin]); //only do this once in your SWF to activate the plugin (it is already activated in TweenLite and TweenMax by default)

	var myArray:Array = [1,2,3,4];
	TweenMax.to(myArray, 1.5, {endArray:[10,20,30,40]});

	
BYTES ADDED TO SWF: 306 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;
import gs.utils.tween.*;

class gs.plugins.EndArrayPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.02;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _a:Array;
		private var _info:Array;
		
		public function EndArrayPlugin() {
			super();
			this.propName = "endArray"; //name of the special property that the plugin should intercept/manage
			this.overwriteProps = ["endArray"];
			_info = [];
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			if (!($target instanceof Array) || !($value instanceof Array)) {
				return false;
			}
			var a = $target, e = $value; //prevents compiler errors
			init(a, e);
			return true;
		}
		
		public function init($start:Array, $end:Array):Void {
			_a = $start;
			for (var i:Number = $end.length - 1; i > -1; i--) {
				if ($start[i] != $end[i] && $start[i] != undefined) {
					_info[_info.length] = new ArrayTweenInfo(i, _a[i], $end[i] - _a[i]);
				}
			}
		}
		
		public function set changeFactor($n:Number):Void {
			var i:Number, ti:ArrayTweenInfo;
			if (this.round) {
				for (i = _info.length - 1; i > -1; i--) {
					ti = _info[i];
					_a[ti.index] = Math.round(ti.start + (ti.change * $n));
				}
			} else {
				for (i = _info.length - 1; i > -1; i--) {
					ti = _info[i];
					_a[ti.index] = ti.start + (ti.change * $n);
				}
			}
		}
		
}