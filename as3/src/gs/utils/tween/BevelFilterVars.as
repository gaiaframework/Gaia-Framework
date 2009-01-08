/*
VERSION: 0.9
DATE: 8/5/2008
ACTIONSCRIPT VERSION: 3.0
DESCRIPTION:
	This class works in conjunction with the TweenFilterLiteVars or TweenMaxVars class to grant
	strict data typing and code hinting (in most code editors) for filter tweens. See the documentation in
	the TweenFilterLiteVars, or TweenMaxVars for more information.

USAGE:
	
	Instead of TweenMax.to(my_mc, 1, {bevelFilter:{distance:5, blurX:10, blurY:10, strength:2}, onComplete:myFunction}), you could use this utility like:
	
		var myVars:TweenMaxVars = new TweenMaxVars();
		myVars.bevelFilter = new BevelFilterVars(5, 10, 10, 2);
		myVars.onComplete = myFunction;
		TweenMax.to(my_mc, 1, myVars);
		
		
NOTES:
	- This utility is completely optional. If you prefer the shorter synatax in the regular TweenFilterLite/TweenMax class, feel
	  free to use it. The purpose of this utility is simply to enable code hinting and to allow for strict data typing.
	- You cannot define relative tween values with this utility. If you need relative values, just use the shorter (non strictly 
	  data typed) syntax, like TweenMax.to(my_mc, 1, {bevelFilter:{blurX:"-5", blurY:"3"}});

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/


package gs.utils.tween {
	
	public class BevelFilterVars {
		public var distance:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var strength:Number; 
		public var angle:Number;
		public var highlightAlpha:Number;
		public var highlightColor:uint;
		public var shadowAlpha:Number;
		public var shadowColor:uint
		public var quality:uint;
		
		public function BevelFilterVars($distance:Number=4, $blurX:Number=4, $blurY:Number=4, $strength:Number=1, $angle:Number=45, $highlightAlpha:Number=1, $highlightColor:uint=0xFFFFFF, $shadowAlpha:Number=1, $shadowColor:uint=0x000000, $quality:uint=2) {
			this.distance = $distance;
			this.blurX = $blurX;
			this.blurY = $blurY;
			this.strength = $strength;
			this.angle = $angle;
			this.highlightAlpha = $highlightAlpha;
			this.highlightColor = $highlightColor;
			this.shadowAlpha = $shadowAlpha;
			this.shadowColor = $shadowColor;
			this.quality = $quality;
		}
		
		public static function createFromGeneric($vars:Object):BevelFilterVars { //for parsing values that are passed in as generic Objects, like blurFilter:{blurX:5, blurY:3} (typically via the constructor)
			if ($vars is BevelFilterVars) {
				return $vars as BevelFilterVars;
			}
			return new BevelFilterVars($vars.distance || 0,
									   $vars.blurX || 0,
									   $vars.blurY || 0,
									   ($vars.strength == null) ? 1 : $vars.strength,
									   ($vars.angle == null) ? 45 : $vars.angle,
									   ($vars.highlightAlpha == null) ? 1 : $vars.highlightAlpha,
									   ($vars.highlightColor == null) ? 0xFFFFFF : $vars.highlightColor,
									   ($vars.shadowAlpha == null) ? 1 : $vars.shadowAlpha,
									   ($vars.shadowColor == null) ? 0xFFFFFF : $vars.shadowColor,
									   $vars.quality || 2);
		}

	}
	
}