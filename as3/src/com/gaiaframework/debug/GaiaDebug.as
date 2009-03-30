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

package com.gaiaframework.debug
{
	import org.osflash.thunderbolt.Logger;
	import flash.system.Capabilities;
	
	public class GaiaDebug
	{		
		private static var isBrowser:Boolean = (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
		
		public static function log(...args):void
		{
			if (!isBrowser)
			{
				trace.apply(null, args);
			}
			else
			{
				try
				{
					Logger.debug.apply(Logger, args);
				}
				catch (error:Error)
				{
					trace.apply(null, args);
				}
			}
		}
		public static function error(...args):void
		{
			if (!isBrowser)
			{
				trace.apply(null, args);
			}
			else
			{
				try
				{
					Logger.error.apply(Logger, args);
				}
				catch (error:Error)
				{
					trace.apply(null, args);
				}
			}
		}
		public static function warn(...args):void
		{
			if (!isBrowser)
			{
				trace.apply(null, args);
			}
			else
			{
				try
				{
					Logger.warn.apply(Logger, args);
				}
				catch (error:Error)
				{
					trace.apply(null, args);
				}
			}
		}
	}
}