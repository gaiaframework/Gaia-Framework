/*
VERSION: 1.0
DATE: 2/23/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Tweens a MovieClip to a particular frame label
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([FrameLabelPlugin]); //only do this once in your SWF to activate the plugin
	
	TweenLite.to(mc, 1, {frameLabel:"myLabel"});

	
BYTES ADDED TO SWF: 280 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;

class gs.plugins.FrameLabelPlugin extends FramePlugin {
		public static var VERSION:Number = 1.01;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		public function FrameLabelPlugin() {
			super();
			this.propName = "frameLabel";
		}
		
		public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
			if (typeof($tween.target) != "movieclip") {
				return false;
			}
			
			_target = MovieClip($target);
			this.frame = _target._currentframe;
			var mc:MovieClip = _target.duplicateMovieClip("tempMC"+Math.round(Math.random() * 999999), _target._parent.getNextHighestDepth()); //we don't want to gotAndStop() on the original MovieClip because it would interfere with playback if it's currently playing. We wouldn't know whether or not to gotoAndStop() or gotoAndPlay() back to the original frame afterwards. So we duplicate it and then remove the duplicate when we're done.
			mc.gotoAndStop($value);
			var endFrame:Number = mc._currentframe;
			mc.removeMovieClip();
			
			if (this.frame != endFrame) {
				addTween(this, "frame", this.frame, endFrame, "frame");
			}
			return true;
		}
		
}