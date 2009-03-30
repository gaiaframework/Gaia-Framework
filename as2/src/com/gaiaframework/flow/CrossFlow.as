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

import com.gaiaframework.flow.FlowManager;

class com.gaiaframework.flow.CrossFlow
{		
	private static var isInDone:Boolean;
	private static var isOutDone:Boolean;
	
	public static function start():Void
	{
		isInDone = isOutDone = false;
		FlowManager.preload();
	}	
	public static function afterPreloadDone():Void
	{
		FlowManager.transitionOut();
		FlowManager.transitionIn();
	}
	public static function afterTransitionInDone():Void
	{
		isInDone = true;
		checkBothDone();
	}	
	public static function afterTransitionOutDone():Void
	{
		isOutDone = true;
		checkBothDone();
	}
	private static function checkBothDone():Void
	{
		if (isInDone && isOutDone)
		{
			isInDone = isOutDone = false;
			FlowManager.complete();
		}
	}
}