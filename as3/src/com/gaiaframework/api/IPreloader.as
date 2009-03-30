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

package com.gaiaframework.api
{
	import com.gaiaframework.events.AssetEvent;
	
	/**
	 * This is the interface implemented by Preloaders in Gaia.
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Preloader Preloader Documentation
	 *  
	 * @author Steven Sacks
	 */
	public interface IPreloader extends IBase
	{
		/**
		 * This event listener receives the <code>AssetEvent</code> dispatched from Gaia when a branch or on-demand assets are loaded.
		 * 
		 * @param event AssetEvent contains progress information.
		 * @see com.gaiaframework.events.AssetEvent AssetEvent
		 */
		function onProgress(event:AssetEvent):void;
	}
}