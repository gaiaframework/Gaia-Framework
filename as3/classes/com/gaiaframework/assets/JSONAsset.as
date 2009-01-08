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

package com.gaiaframework.assets
{
	import com.serialization.json.JSON;
	import com.gaiaframework.api.IJson;

	public class JSONAsset extends TextAsset implements IJson
	{
		function JSONAsset()
		{
			super();
		}
		public function get json():Object
		{			
			return JSON.deserialize(_data);
		}
		override public function toString():String
		{
			return "[JSONAsset] " + _id + " : " + _order + " ";
		}
	}
}