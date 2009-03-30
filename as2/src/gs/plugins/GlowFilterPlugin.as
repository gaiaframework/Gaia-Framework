/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Tweens a GlowFilter. The following properties are available (you only need to define the ones you want to tween):
		- color : Number [0x000000]
		- alpha :Number [0]
		- blurX : Number [0]
		- blurY : Number [0]
		- strength : Number [1]
		- quality : Number [2]
		- inner : Boolean [false]
		- knockout : Boolean [false]
		- index : Number
		- addFilter : Boolean [false]
		- remove : Boolean [false]
		
	Set remove to true if you want the filter to be removed when the tween completes.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([GlowFilterPlugin]); //only do this once in your SWF to activate the plugin in TweenLite (it is already activated in TweenMax by default)
	
	TweenLite.to(mc, 1, {glowFilter:{color:0x00FF00, blurX:10, blurY:10, strength:1, strength:1}});
	
	
BYTES ADDED TO SWF: 206 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;
import flash.filters.*;

class gs.plugins.GlowFilterPlugin extends FilterPlugin {		
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		public function GlowFilterPlugin() {
			super();
			this.propName = "glowFilter";
			this.overwriteProps = ["glowFilter"];
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			_target = $target;
			_type = GlowFilter;
			initFilter($value, new GlowFilter(0xFFFFFF, 0, 0, 0, $value.strength || 1, $value.quality || 2, $value.inner, $value.knockout));
			return true;
		}
		
}