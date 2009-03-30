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

class com.gaiaframework.flow.NormalFlow
{		
	public static function start():Void
	{
		FlowManager.transitionOut();
	}	
	public static function afterTransitionOutDone():Void
	{
		FlowManager.preload();
	}	
	public static function afterPreloadDone():Void
	{
		FlowManager.transitionIn();
	}	
	public static function afterTransitionInDone():Void
	{
		FlowManager.complete();
	}
}