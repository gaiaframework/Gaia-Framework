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