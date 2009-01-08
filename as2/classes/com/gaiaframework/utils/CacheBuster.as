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

class com.gaiaframework.utils.CacheBuster
{
	public static var isOnline:Boolean = false;
	
	public static function create(url:String):String
	{
		if (isOnline) 
		{
			var d:Date = new Date();
			var nc:String = "nocache=" + d.getTime();
			if (url.indexOf("?") > -1) return url + "&" + nc;
			return url + "?" + nc;
		}
		return url;
	}
}