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

import com.gaiaframework.events.Event;

class com.gaiaframework.events.PageEvent extends Event
{
	public static var TRANSITION_OUT:String = "transitionOut";
	public static var TRANSITION_IN:String = "transitionIn";
	public static var TRANSITION_OUT_COMPLETE:String = "transitionOutComplete";
	public static var TRANSITION_IN_COMPLETE:String = "transitionInComplete";
	
	public function PageEvent(type:String, target:Object)
	{
		super(type, target);
	}
	public function clone():Event
	{
		return new PageEvent(type, target);
	}
	public function toString():String
	{
		return formatToString("PageEvent", "type");
	}
}