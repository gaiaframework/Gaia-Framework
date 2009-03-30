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

package com.gaiaframework.flow
{
	import com.gaiaframework.core.SiteModel;
	import com.gaiaframework.core.GaiaHQ;
	import com.gaiaframework.api.Gaia;

	public class FlowManager
	{
		private static var flow:Object;
		
		public static function init(type:String):void
		{
			if (type == Gaia.NORMAL)
			{
				flow = NormalFlow;
			}
			else if (type == Gaia.PRELOAD)
			{
				flow = PreloadFlow;
			}
			else if (type == Gaia.REVERSE)
			{
				flow = ReverseFlow;
			}
			else if (type == Gaia.CROSS)
			{
				flow = CrossFlow;
			}
			else
			{
				init(SiteModel.defaultFlow || Gaia.NORMAL);
			}
		}
		
		// from SiteController
		public static function start():void
		{
			GaiaHQ.instance.afterGoto();
		}
		public static function transitionOutComplete():void
		{
			GaiaHQ.instance.afterTransitionOut();
		}
		public static function preloadComplete():void
		{
			GaiaHQ.instance.afterPreload();
		}
		public static function transitionInComplete():void
		{
			GaiaHQ.instance.afterTransitionIn();
		}
		
		// from GaiaHQ
		public static function afterGoto():void
		{
			flow.start();
		}
		public static function afterTransitionOutDone():void
		{
			flow.afterTransitionOutDone();
		}
		public static function afterPreloadDone():void
		{
			flow.afterPreloadDone();
		}
		public static function afterTransitionInDone():void
		{
			flow.afterTransitionInDone();
		}
		
		// from flow
		internal static function transitionOut():void
		{
			GaiaHQ.instance.beforeTransitionOut();
		}
		internal static function preload():void
		{
			GaiaHQ.instance.beforePreload();
		}
		internal static function transitionIn():void
		{
			GaiaHQ.instance.beforeTransitionIn();
		}
		internal static function complete():void
		{
			GaiaHQ.instance.afterComplete();
		}
	}
}