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

import com.gaiaframework.templates.AbstractPage;
import com.gaiaframework.utils.DocumentClass;
import com.gaiaframework.events.*;
import com.gaiaframework.assets.*;
import com.gaiaframework.debug.*;
import com.gaiaframework.api.*;
import mx.utils.Delegate;%TWEENLITE%
import PACKAGENAME.Scaffold;

class PACKAGENAME.CLASSNAME extends AbstractPage
{	
	public function CLASSNAME()
	{
		super();%ALPHA%
	}
	
	public function scaffold():Void
	{
		new Scaffold(this);
	}
	
	public function transitionIn():Void 
	{
		super.transitionIn();%TRANSITIONIN%
	}
	public function transitionOut():Void 
	{
		super.transitionOut();%TRANSITIONOUT%
	}
	
	///////////////////////////////////////////////////////////
	// AS2 DOCUMENT CLASS EQUIVALENT - DO NOT REMOVE!!!
	public static function initDocumentClass(document:MovieClip):Void
	{
		DocumentClass.init(document, CLASSNAME);
	}
	// AS2 DOCUMENT CLASS EQUIVALENT - DO NOT REMOVE!!!
	///////////////////////////////////////////////////////////
}