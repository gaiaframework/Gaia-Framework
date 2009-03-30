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

// Borrowed from Ryan Taylor's RegisterClass
// http://www.boostworthy.com/blog/?p=123

class com.gaiaframework.utils.DocumentClass
{
	public static function init(document:MovieClip, docClass:Object):Void
	{
		document.__proto__ = Function(docClass).prototype;
		Function(docClass).apply(document, null);
	}
}
