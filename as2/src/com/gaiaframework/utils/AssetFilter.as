﻿/*****************************************************************************************************
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

import com.gaiaframework.assets.*;

class com.gaiaframework.utils.AssetFilter
{
	public static function getSWF(assets:Object):Object
	{
		var obj:Object = {};
		for (var a:String in assets)
		{
			if (assets[a] instanceof MovieClipAsset && String(assets[a].src.split(".").pop()).toLowerCase() == "swf") obj[a] = assets[a];
		}
		return obj;
	}
	public static function getImage(assets:Object):Object
	{
		var obj:Object = {};
		for (var a:String in assets)
		{
			if (assets[a] instanceof MovieClipAsset && String(assets[a].src.split(".").pop()).toLowerCase() != "swf") obj[a] = assets[a];
		}
		return obj;
	}
	public static function getSound(assets:Object):Object
	{
		var obj:Object = {};
		for (var a:String in assets)
		{
			if (assets[a] instanceof SoundAsset || assets[a] instanceof SoundClipAsset) obj[a] = assets[a];
		}
		return obj;
	}
	public static function getXML(assets:Object):Object
	{
		var obj:Object = {};
		for (var a:String in assets)
		{
			if (assets[a] instanceof XMLAsset) obj[a] = assets[a];
		}
		return obj;
	}
	public static function getNetStream(assets:Object):Object
	{
		var obj:Object = {};
		for (var a:String in assets)
		{
			if (assets[a] instanceof NetStreamAsset) obj[a] = assets[a];
		}
		return obj;
	}
}