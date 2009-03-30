/*
VERSION: 1.0
DATE: 1/23/2009
ACTIONSCRIPT VERSION: 2.0
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenLite.com
DESCRIPTION:
	Stores basic info about Array tweens in TweenLite/Max.
	
AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

class gs.utils.tween.ArrayTweenInfo {
		public var index:Number;
		public var start:Number;
		public var change:Number;
		
		public function ArrayTweenInfo($index:Number, $start:Number, $change:Number) {
			this.index = $index;
			this.start = $start;
			this.change = $change;
		}
}