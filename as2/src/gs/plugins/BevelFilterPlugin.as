/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Tweens a BevelFilter. The following properties are available (you only need to define the ones you want to tween):
		- distance : Number [0]
		- angle : Number [0]
		- highlightColor : Number [0xFFFFFF]
		- highlightAlpha : Number [0.5]
		- shadowColor : Number [0x000000]
		- shadowAlpha :Number [0.5]
		- blurX : Number [2]
		- blurY : Number [2]
		- strength : Number [0]
		- quality : Number [2]
		- index : Number
		- addFilter : Boolean 
		- remove : Boolean [false]
		
	Set remove to true if you want the filter to be removed when the tween completes.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([BevelFilterPlugin]); //only do this once in your SWF to activate the plugin in TweenLite (it is already activated in TweenMax by default)
	
	TweenLite.to(mc, 1, {bevelFilter:{blurX:10, blurY:10, distance:6, angle:45, strength:1}});
	

BYTES ADDED TO SWF: 174 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;
import flash.filters.*;

class gs.plugins.BevelFilterPlugin extends FilterPlugin {
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		public function BevelFilterPlugin() {
			super();
			this.propName = "bevelFilter";
			this.overwriteProps = ["bevelFilter"];
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			_target = $target;
			_type = BevelFilter;
			initFilter($value, new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0x000000, 0.5, 2, 2, 0, $value.quality || 2));
			return true;
		}
		
}