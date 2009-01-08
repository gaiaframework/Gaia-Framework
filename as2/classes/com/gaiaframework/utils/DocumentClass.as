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
