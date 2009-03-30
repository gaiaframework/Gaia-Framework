/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Bezier tweening allows you to tween in a non-linear way. For example, you may want to tween
	a MovieClip's position from the origin (0,0) 500 pixels to the right (500,0) but curve downwards
	through the middle of the tween. Simply pass as many objects in the bezier array as you'd like, 
	one for each "control point" (see documentation on Flash's curveTo() drawing method for more
	about how control points work).
	
	Keep in mind that you can bezier tween ANY properties, not just _x/_y. 
	
	Also, if you'd like to rotate the target in the direction of the bezier path, 
	use the orientToBeizer special property. In order to alter a rotation property accurately, 
	TweenLite/Max needs 4 pieces of information: 
		1) Position property 1 (typically "_x")
		2) Position property 2 (typically "_y")
		3) Rotational property (typically "_rotation")
		4) Number of degrees to add (optional - makes it easy to orient your MovieClip properly)
	The orientToBezier property should be an Array containing one Array for each set of these values. 
	For maximum flexibility, you can pass in any number of arrays inside the container array, one 
	for each rotational property. This can be convenient when working in 3D because you can rotate
	on multiple axis. If you're doing a standard 2D _x/_y tween on a bezier, you can simply pass 
	in a Boolean value of true and TweenLite/Max will use a typical setup, [["_x", "_y", "_rotation", 0]]. 
	Hint: Don't forget the container Array (notice the double outer brackets)
	
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([BezierPlugin]); //only do this once in your SWF to activate the plugin in TweenLite (it is already activated in TweenMax by default)
	
	TweenLite.to(my_mc, 3, {bezier:[{_x:250, _y:50}, {_x:500, _y:0}]}); //makes my_mc travel through 250,50 and end up at 500,0.
	
	
BYTES ADDED TO SWF: 1257 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.*;
import gs.plugins.*;

class gs.plugins.BezierPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private static var _RAD2DEG:Number = 180 / Math.PI; //precalculate for speed
		
		private var _target:Object;
		private var _orientData:Array;
		private var _orient:Boolean;
		private var _future:Object = {}; //used for orientToBezier projections
		private var _beziers:Object;
		
		public function BezierPlugin() {
			super();
			this.propName = "bezier"; //name of the special property that the plugin should intercept/manage
			this.overwriteProps = []; //will be populated in init()
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			if (!($value instanceof Array)) {
				return false;
			}
			var a = $value; //gets around data typing errors in the compiler
			init($tween, a, false);
			return true;
		}
		
		private function init($tween:TweenLite, $beziers:Array, $through:Boolean):Void {
			_target = $tween.target;
			var props:Object = {}, i:Number, p:String;
			if ($tween.vars.orientToBezier == true) {
				_orientData = [["_x", "_y", "_rotation", 0]];
				this.overwriteProps[this.overwriteProps.length] = "_rotation";
				_orient = true;
			} else if ($tween.vars.orientToBezier instanceof Array) {
				_orientData = $tween.vars.orientToBezier;
				for (i = _orientData.length - 1; i > -1; i--) {
					this.overwriteProps[this.overwriteProps.length] = _orientData[i][2];
				}
				this.overwriteProps[this.overwriteProps.length] = p;
				_orient = true;
			}
			for (i = 0; i < $beziers.length; i++) {
				for (p in $beziers[i]) {
					if (props[p] == undefined) {
						props[p] = [$tween.target[p]];
					}
					if (typeof($beziers[i][p]) == "number") {
						props[p].push($beziers[i][p]);
					} else {
						props[p].push($tween.target[p] + Number($beziers[i][p])); //relative value
					}
				}
			}
			for (p in props) {
				this.overwriteProps[this.overwriteProps.length] = p;
				if ($tween.vars[p] != undefined) {
					if (typeof($tween.vars[p]) == "number") {
						props[p].push($tween.vars[p]);
					} else {
						props[p].push($tween.target[p] + Number($tween.vars[p])); //relative value
					}
					delete $tween.vars[p]; //prevent TweenLite from creating normal tweens of the bezier properties.
					for (i = $tween.tweens.length - 1; i > -1; i--) {
						if ($tween.tweens[i].name == p) {
							$tween.tweens.splice(i, 1); //delete any normal tweens of the bezier properties. 
						}
					}
				}
			}
			_beziers = parseBeziers(props, $through);
		}
		
		public static function parseBeziers($props:Object, $through:Boolean):Object { //$props object should contain a property for each one you'd like bezier paths for. Each property should contain a single Array with the numeric point values (i.e. props.x = [12,50,80] and props.y = [50,97,158]). It'll return a new object with an array of values for each property. The first element in the array  is the start value, the second is the control point, and the 3rd is the end value. (i.e. returnObject.x = [[12, 32, 50}, [50, 65, 80]])
			var i:Number, a:Array, b:Object, p:String;
			var all:Object = {};
			if ($through == true) {
				for (p in $props) {
					a = $props[p];
					all[p] = b = [];
					if (a.length > 2) {
						b[b.length] = [a[0], a[1] - ((a[2] - a[0]) / 4), a[1]];
						for (i = 1; i < a.length - 1; i++) {
							b[b.length] = [a[i], a[i] + (a[i] - b[i - 1][1]), a[i + 1]];
						}
					} else {
						b[b.length] = [a[0], (a[0] + a[1]) / 2, a[1]];
					}
				}
			} else {
				for (p in $props) {
					a = $props[p];
					all[p] = b = [];
					if (a.length > 3) {
						b[b.length] = [a[0], a[1], (a[1] + a[2]) / 2];
						for (i = 2; i < a.length - 2; i++) {
							b[b.length] = [b[i - 2][2], a[i], (a[i] + a[i + 1]) / 2];
						}
						b[b.length] = [b[b.length - 1][2], a[a.length - 2], a[a.length - 1]];
					} else if (a.length == 3) {
						b[b.length] = [a[0], a[1], a[2]];
					} else if (a.length == 2) {
						b[b.length] = [a[0], (a[0] + a[1]) / 2, a[1]];
					}
				}
			}
			return all;
		}
		
		public function killProps($lookup:Object):Void {
			for (var p:String in _beziers) {
				if ($lookup[p] != undefined) {
					delete _beziers[p];
				}
			}
			if (_orient) {
				for (var i:Number = _orientData.length - 1; i > -1; i--) {
					if ($lookup[_orientData[i][2]] != undefined) {
						_orientData.splice(i, 1);
					}
				}
			}
			super.killProps($lookup);
		}	
		
		public function set changeFactor($n:Number):Void {
			var i:Number, p:String, b:Object, t:Number, segments:Number;
			if ($n == 1) { //to make sure the end values are EXACTLY what they need to be.
				for (p in _beziers) {
					i = _beziers[p].length - 1;
					_target[p] = _beziers[p][i][2];
				}
			} else {
				for (p in _beziers) {
					segments = _beziers[p].length;
					if ($n < 0) {
						i = 0;
					} else if ($n >= 1) {
						i = segments - 1;
					} else {
						i = (segments * $n) >> 0;
					}
					t = ($n - (i * (1 / segments))) * segments;
					b = _beziers[p][i];
					if (this.round) {
						_target[p] = Math.round(b[0] + t * (2 * (1 - t) * (b[1] - b[0]) + t * (b[2] - b[0])));
					} else {
						_target[p] = b[0] + t * (2 * (1 - t) * (b[1] - b[0]) + t * (b[2] - b[0]));
					}
				}				
			}
			
			if (_orient) {
				var oldTarget:Object = _target, oldRound:Boolean = this.round;
				_target = _future;
				this.round = false;
				_orient = false;
				this.changeFactor = $n + 0.01;
				_target = oldTarget;
				this.round = oldRound;
				_orient = true;
				var dx:Number, dy:Number, cotb:Array, toAdd:Number;
				for (i = 0; i < _orientData.length; i++) {
					cotb = _orientData[i]; //current orientToBezier Array
					toAdd = cotb[3] || 0;
					dx = _future[cotb[0]] - _target[cotb[0]];
					dy = _future[cotb[1]] - _target[cotb[1]];
					_target[cotb[2]] = Math.atan2(dy, dx) * _RAD2DEG + toAdd;
				}
			}
			
		}
		
}