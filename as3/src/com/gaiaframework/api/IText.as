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
	/**
	 * This is the interface for the <code>TextAsset</code>.  XMLAsset, StyleSheetAsset and JSONAsset all inherit from TextAsset.
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Assets#TextAsset_.28AS3_only.29 TextAsset Documentation
	 * 
	 * @author Steven Sacks
	 */
	public interface IText extends IAsset
	{
		/**
		 * Returns the text string.
		 */
		function get text():String;
	}
}