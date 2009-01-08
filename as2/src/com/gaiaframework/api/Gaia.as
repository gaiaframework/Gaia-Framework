/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Written by: Steven Sacks
* email: stevensacks@gmail.com
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is ©2007-2009 Steven Sacks and is released under the MIT License:
* http://www.opensource.org/licenses/mit-license.php 
*****************************************************************************************************/

import com.gaiaframework.api.IGaia;

class com.gaiaframework.api.Gaia
{	
	private static var impl:IGaia;
	
	public static var TOP:String = "top";
	public static var MIDDLE:String = "middle";
	public static var BOTTOM:String = "bottom";
	public static var PRELOADER:String = "preloader";
	
	public static var NORMAL:String = "normal";
	public static var PRELOAD:String = "preload";
	public static var REVERSE:String = "reverse";
	public static var CROSS:String = "cross";
	
	public static function get api():IGaia
	{
		return impl;
	}
	public static function set api(value:IGaia):Void
	{
		if (impl == undefined) impl = value;
	}
}