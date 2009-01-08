/*
VERSION: 0.9
DATE: 8/5/2008
ACTIONSCRIPT VERSION: 3.0
DESCRIPTION:
	This class works in conjunction with the TweenFilterLiteVars or TweenMaxVars class to grant
	strict data typing and code hinting (in most code editors) for filter tweens. See the documentation in
	the TweenFilterLiteVars, or TweenMaxVars for more information.

USAGE:
	
	Instead of TweenMax.to(my_mc, 1, {dropShadowFilter:{distance:5, blurX:10, blurY:10, color:0xFF0000}, onComplete:myFunction}), you could use this utility like:
	
		var myVars:TweenMaxVars = new TweenMaxVars();
		myVars.dropShadowFilter = new DropShadowFilterVars(5, 10, 10, 1, 45, 0xFF0000);
		myVars.onComplete = myFunction;
		TweenMax.to(my_mc, 1, myVars);
		
		
NOTES:
	- This utility is completely optional. If you prefer the shorter synatax in the regular TweenFilterLite/TweenMax class, feel
	  free to use it. The purpose of this utility is simply to enable code hinting and to allow for strict data typing.
	- You cannot define relative tween values with this utility. If you need relative values, just use the shorter (non strictly 
	  data typed) syntax, like TweenMax.to(my_mc, 1, {dropShadowFilter:{blurX:"-5", blurY:"3"}});

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/


package gs.utils.tween {
	
	public class DropShadowFilterVars {
		public var distance:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var alpha:Number;
		public var angle:Number;
		public var color:uint;
		public var strength:Number; 
		public var inner:Boolean;
		public var knockout:Boolean;
		public var hideObject:Boolean;
		public var quality:uint;
		
		public function DropShadowFilterVars($distance:Number=4, $blurX:Number=4, $blurY:Number=4, $alpha:Number=1, $angle:Number=45, $color:uint=0x000000, $strength:Number=2, $inner:Boolean=false, $knockout:Boolean=false, $hideObject:Boolean=false, $quality:uint=2) {
			this.distance = $distance;
			this.blurX = $blurX;
			this.blurY = $blurY;
			this.alpha = $alpha;
			this.angle = $angle;
			this.color = $color;
			this.strength = $strength;
			this.inner = $inner;
			this.knockout = $knockout;
			this.hideObject = $hideObject;
			this.quality = $quality;
		}
		
		public static function createFromGeneric($vars:Object):DropShadowFilterVars { //for parsing values that are passed in as generic Objects, like blurFilter:{blurX:5, blurY:3} (typically via the constructor)
			if ($vars is DropShadowFilterVars) {
				return $vars as DropShadowFilterVars;
			}
			return new DropShadowFilterVars($vars.distance || 0,
											$vars.blurX || 0,
											$vars.blurY || 0,
											$vars.alpha || 0,
											($vars.angle == null) ? 45 : $vars.angle,
											($vars.color == null) ? 0x000000 : $vars.color,
											($vars.strength == null) ? 2 : $vars.strength,
											Boolean($vars.inner),
											Boolean($vars.knockout),
											Boolean($vars.hideObject),
											$vars.quality || 2);
		}

	}
	
}