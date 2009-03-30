/*
VERSION: 1.0
DATE: 12/30/2008
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Removes the tint of a DisplayObject over time. 
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([RemoveTintPlugin]); //only do this once in your SWF to activate the plugin (it is already activated in TweenLite and TweenMax by default)
	
	TweenLite.to(mc, 1, {removeTint:true});
	
	
BYTES ADDED TO SWF: 94 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.*;
import gs.plugins.TintPlugin;

class gs.plugins.RemoveTintPlugin extends TintPlugin {
		public static var VERSION:Number = 1.0;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		public function RemoveTintPlugin() {
			super();
			this.propName = "removeTint";
		}
		
}