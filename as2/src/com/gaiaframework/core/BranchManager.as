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

import com.gaiaframework.assets.PageAsset;

class com.gaiaframework.core.BranchManager
{	
	private static var activePages:Object = {};
	
	public static function addPage(page:PageAsset):Void
	{
		activePages[page.branch] = page;
	}
	public static function getTransitionOutArray(newBranch:String):Array
	{
		cleanup();
		newBranch += "/";
		var transitionOutArray:Array = [];
		for (var a:String in activePages)
		{
			if (newBranch.indexOf(a + "/") == -1) transitionOutArray.push(activePages[a]);
		}
		transitionOutArray.sort(sortByBranchDepth);
		return transitionOutArray;
	}
	public static function cleanup():Void
	{
		for (var a:String in activePages)
		{
			if (!activePages[a].active) delete activePages[a];
		}
	}
	private static function sortByBranchDepth(a:PageAsset, b:PageAsset):Number
	{
		var aLen:Number = a.branch.split("/").length;
		var bLen:Number = b.branch.split("/").length;
		if (aLen < bLen)return -1;
		else if (aLen > bLen) return 1;
		else return 0;
	}
}