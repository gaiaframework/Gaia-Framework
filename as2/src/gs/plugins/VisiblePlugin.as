/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Toggles the visibility at the end of a tween. For example, if you want to set visible to false
	at the end of the tween, do TweenLite.to(mc, 1, {_x:100, _visible:false});
	
	The visible property is forced to true during the course of the tween.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([VisiblePlugin]); //only do this once in your SWF to activate the plugin (it is already activated in TeenLite and TweenMax by default)
	
	TweenLite.to(mc, 1, {_x:100, _visible:false});
	
	
BYTES ADDED TO SWF: 285 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;

class gs.plugins.VisiblePlugin extends TweenPlugin {
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _target:Object;
		private var _tween:TweenLite;
		private var _visible:Boolean;
		
		public function VisiblePlugin() {
			super();
			this.propName = "_visible";
			this.overwriteProps = ["_visible"];
			this.onComplete = onCompleteTween;
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			_target = $target;
			_tween = $tween;
			_visible = Boolean($value);
			return true;
		}
		
		public function onCompleteTween():Void {
			if (_tween.vars.runBackwards != true && _tween.ease == _tween.vars.ease) { //_tween.ease == _tween.vars.ease checks to make sure the tween wasn't reversed with a TweenGroup
				_target._visible = _visible;
			}
		}
		
		public function set changeFactor($n:Number):Void {
			if (_target._visible != true) {
				_target._visible = true;
			}
		}
	
}