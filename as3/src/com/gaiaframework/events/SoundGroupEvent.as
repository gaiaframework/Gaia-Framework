/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Author: Steven Sacks
*
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is released under the GPL License:
* http://www.opensource.org/licenses/gpl-2.0.php 
*****************************************************************************************************/

package com.gaiaframework.events
{
	import flash.events.Event;
	
	public class SoundGroupEvent extends Event
	{
		public static const ALL_SOUNDS_LOADED:String = "allSoundsLoaded";
		
		public function SoundGroupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new SoundGroupEvent(type, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("SoundGroupEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}