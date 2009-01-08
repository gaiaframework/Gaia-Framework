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

import com.gaiaframework.events.GaiaSWFAddressEvent;
import com.gaiaframework.templates.AbstractBase;
import com.gaiaframework.assets.PageAsset;
import com.gaiaframework.api.IPage;
	
class com.gaiaframework.templates.AbstractPage extends AbstractBase implements IPage
{
	private var _page:PageAsset;
	
	function AbstractPage()
	{
		super();
	}
	public function get page():PageAsset
	{
		return _page;
	}
	public function set page(value:PageAsset):Void
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
	public function onDeeplink(event:GaiaSWFAddressEvent):Void 
	{
		dispatchEvent(event);
	}
}