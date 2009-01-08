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

import com.gaiaframework.api.IPreloader;
import com.gaiaframework.templates.AbstractBase;
import com.gaiaframework.events.AssetEvent;

class com.gaiaframework.templates.AbstractPreloader extends AbstractBase implements IPreloader
{
	public function AbstractPreloader()
	{
		super();
	}
	public function onProgress(event:AssetEvent):Void 
	{
		dispatchEvent(event);
	}
}