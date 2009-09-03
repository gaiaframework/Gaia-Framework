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

package com.gaiaframework.utils
{
	import com.gaiaframework.core.SiteModel;
	
	public class CacheBuster
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
		public static function version(url:String):String
		{
			if (isOnline && SiteModel.version) 
			{
				var v:String = "gaiaSiteVersion=" + SiteModel.version;
				if (url.indexOf("?") > -1) return url + "&" + v;
				return url + "?" + v;
			}
			return url;
		}
	}
}