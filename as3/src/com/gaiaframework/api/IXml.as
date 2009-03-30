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
	 * This is the interface for the <code>XMLAsset</code>.
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Assets#XMLAsset XMLAsset Documentation
	 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html XML
	 * 
	 * @author Steven Sacks
	 */
	public interface IXml extends IAsset
	{
		/**
		 * Returns the XML.
		 */
		function get xml():XML;
	}
}