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

import com.gaiaframework.core.SiteModel;
import com.gaiaframework.core.GaiaHQ;
import com.gaiaframework.flow.NormalFlow;
import com.gaiaframework.flow.PreloadFlow;
import com.gaiaframework.flow.ReverseFlow;
import com.gaiaframework.flow.CrossFlow;
import com.gaiaframework.api.Gaia;

class com.gaiaframework.flow.FlowManager
{
	private static var flow:Object;
	
	public static function init(type:String):Void
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
	public static function start():Void
	{
		GaiaHQ.instance.afterGoto();
	}
	public static function transitionOutComplete():Void
	{
		GaiaHQ.instance.afterTransitionOut();
	}
	public static function preloadComplete():Void
	{
		GaiaHQ.instance.afterPreload();
	}
	public static function transitionInComplete():Void
	{
		GaiaHQ.instance.afterTransitionIn();
	}
	
	// from GaiaHQ
	public static function afterGoto():Void
	{
		flow.start();
	}
	public static function afterTransitionOutDone():Void
	{
		flow.afterTransitionOutDone();
	}
	public static function afterPreloadDone():Void
	{
		flow.afterPreloadDone();
	}
	public static function afterTransitionInDone():Void
	{
		flow.afterTransitionInDone();
	}
	
	// from flow
	public static function transitionOut():Void
	{
		GaiaHQ.instance.beforeTransitionOut();
	}
	public static function preload():Void
	{
		GaiaHQ.instance.beforePreload();
	}
	public static function transitionIn():Void
	{
		GaiaHQ.instance.beforeTransitionIn();
	}
	public static function complete():Void
	{
		GaiaHQ.instance.afterComplete();
	}
}