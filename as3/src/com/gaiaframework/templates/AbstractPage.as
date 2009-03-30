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

package com.gaiaframework.templates
{
	import com.gaiaframework.events.GaiaSWFAddressEvent;
	import com.gaiaframework.api.IPageAsset;
	import com.gaiaframework.api.IPage;
	
	public class AbstractPage extends AbstractBase implements IPage
	{
		private var _page:IPageAsset;
		
		function AbstractPage()
		{
			super();
		}
		public function get page():IPageAsset
		{
			return _page;
		}
		public function set page(value:IPageAsset):void
		{
			if (_page == null) _page = value;
		}
		public function get assets():Object
		{
			return _page.assets;
		}
		public function get copy():Object
		{
			return _page.copy;
		}
		// IPage Compliance
		public function onDeeplink(event:GaiaSWFAddressEvent):void 
		{
			dispatchEvent(event);
		}
	}
}