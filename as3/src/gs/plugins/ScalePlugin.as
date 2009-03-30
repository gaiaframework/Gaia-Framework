/*
VERSION: 1.0
DATE: 2/23/2009
ACTIONSCRIPT VERSION: 3.0
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
   ScalePlugin combines scaleX and scaleY into one "scale" property.
   
USAGE:
   import gs.*;
   import gs.plugins.*;
   TweenPlugin.activate([ScalePlugin]); //only do this once in your SWF to activate the plugin
   
   TweenLite.to(mc, 1, {scale:2});  //tweens horizontal and vertical scale simultaneously
   

Greensock Tweening Platform
AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
package gs.plugins {
	import flash.display.*;
	
	import gs.*;
   
	public class ScalePlugin extends TweenPlugin {
		public static const VERSION:Number = 1.0;
		public static const API:Number = 1.0;

		protected var _target:DisplayObject;
		protected var _start:Number;
		protected var _change:Number;
  
		public function ScalePlugin() {
			super();
			this.propName = "scale";
			this.overwriteProps = ["scaleX", "scaleY", "width", "height"];
		}
  
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			if (!($target is DisplayObject)) {
				return false;
			}
 			_target = $target as DisplayObject;
 			_start = _target.scaleX;
 			_change = (typeof($value) == "number") ? $value - _start : Number($value);
			return true;
		}
		
		override public function killProps($lookup:Object):void {
			trace("overwrite: "+$lookup);
			for (var i:int = this.overwriteProps.length - 1; i > -1; i--) {
				if (this.overwriteProps[i] in $lookup) { //if any of the properties are found in the lookup, this whole plugin instance should be essentially deactivated. To do that, we must empty the overwriteProps Array.
					this.overwriteProps = [];
					return;
				}
			}
		}
  
		override public function set changeFactor($n:Number):void {
			_target.scaleX = _target.scaleY = _start + ($n * _change);
		}
	}
}