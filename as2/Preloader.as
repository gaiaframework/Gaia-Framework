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

import com.gaiaframework.templates.AbstractPreloader;
import com.gaiaframework.utils.DocumentClass;
import com.gaiaframework.events.AssetEvent;

import PACKAGENAME.PreloaderScaffold;

class PACKAGENAME.Preloader extends AbstractPreloader
{	
	public var scaffold:PreloaderScaffold;
	
	public function Preloader()
	{
		super();
	}
	public function transitionIn():Void
	{
		scaffold.transitionIn();
		transitionInComplete();
	}		
	public function transitionOut():Void
	{
		scaffold.transitionOut();
		transitionOutComplete();
	}
	public function onProgress(event:AssetEvent):Void
	{
		scaffold.onProgress(event);
	}
	
	
	///////////////////////////////////////////////////////////
	// AS2 DOCUMENT CLASS EQUIVALENT - DO NOT REMOVE!!!
	public static function initDocumentClass(document:MovieClip):Void
	{
		DocumentClass.init(document, Preloader);
	}	
	// AS2 DOCUMENT CLASS EQUIVALENT - DO NOT REMOVE!!!
	///////////////////////////////////////////////////////////
}