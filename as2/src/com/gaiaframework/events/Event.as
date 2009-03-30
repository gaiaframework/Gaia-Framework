/*****************************************************************************************************
* Gaia Framework for Adobe Flash �2007-2009
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

class com.gaiaframework.events.Event
{	
	public static var COMPLETE:String = "complete";
	
	public var type:String;
	public var target:Object;
	
	function Event(type:String, target:Object)
	{
		this.type = type;
		this.target = target;
	}
	public function clone():Event
	{
		return new Event(type);
	}
	public function toString():String
	{
		return formatToString("Event", "type");
	}
	private function formatToString():String
	{
		var str:String = arguments.shift() + " | ";
		for (var i:Number = 0; i < arguments.length; i++)
		{
			str += this[arguments[i]] + " | ";
		}
		return str.substr(0, str.length - 3);
	}
}