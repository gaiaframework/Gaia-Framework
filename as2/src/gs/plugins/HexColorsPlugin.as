/*
VERSION: 1.01
DATE: 2/5/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Although hex colors are technically numbers, if you try to tween them conventionally, 
	you'll notice that they don't tween smoothly. To tween them properly, the red, green, and 
	blue components must be extracted and tweened independently. The HexColorsPlugin makes it easy. 
	To tween a property of your object that's a hex color to another hex color, just pass a hexColors 
	Object with properties named the same as your object's hex color properties. For example, 
	if myObject has a "myHexColor" property that you'd like to tween to red (0xFF0000) over the 
	course of 2 seconds, you'd do:
		
		TweenMax.to(myObject, 2, {hexColors:{myHexColor:0xFF0000}});
		
	You can pass in any number of hexColor properties.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([HexColorsPlugin]); //only do this once in your SWF to activate the plugin in TweenLite (it is already activated in TweenMax by default)
	
	TweenLite.to(myObject, 2, {hexColors:{myHexColor:0xFF0000}});
	
	or if you just want to tween a color and apply it somewhere on every frame, you could do:
	
	var myColor:Object = {hex:0xFF0000};
	TweenLite.to(myColor, 2, {hexColors:{hex:0x0000FF}, onUpdate:applyColor});
	function applyColor():Void {
		mc.clear();
		mc.moveTo(0, 0);
		mc.beginFill(myColor.hex, 1);
		mc.lineTo(100, 0);
		mc.lineTo(100, 100);
		mc.lineTo(0, 100);
		mc.lineTo(0, 0);
		mc.endFill();		
	}
	
	
BYTES ADDED TO SWF: 441 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;

class gs.plugins.HexColorsPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.01;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _colors:Array;
		
		public function HexColorsPlugin() {
			super();
			this.propName = "hexColors";
			this.overwriteProps = [];
			_colors = [];
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			for (var p:String in $value) {
				initColor($target, p, Number($target[p]), Number($value[p]));
			}
			return true;
		}
		
		public function initColor($target:Object, $propName:String, $start:Number, $end:Number):Void {
			if ($start != $end) {
				var r:Number = $start >> 16;
				var g:Number = ($start >> 8) & 0xff;
				var b:Number = $start & 0xff;
				_colors[_colors.length] = [$target, 
										   $propName, 
										   r,
										   ($end >> 16) - r,
										   g,
										   (($end >> 8) & 0xff) - g,
										   b,
										   ($end & 0xff) - b];
				this.overwriteProps[this.overwriteProps.length] = $propName;
			}
		}
		
		public function killProps($lookup:Object):Void {
			for (var i:Number = _colors.length - 1; i > -1; i--) {
				if ($lookup[_colors[i][1]] != undefined) {
					_colors.splice(i, 1);
				}
			}
			super.killProps($lookup);
		}	
		
		public function set changeFactor($n:Number):Void {
			var i:Number, a:Array;
			for (i = _colors.length - 1; i > -1; i--) {
				a = _colors[i];
				a[0][a[1]] = ((a[2] + ($n * a[3])) << 16 | (a[4] + ($n * a[5])) << 8 | (a[6] + ($n * a[7])));
			}
		}
	
}