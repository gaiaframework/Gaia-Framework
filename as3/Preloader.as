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

package PACKAGENAME
{
	import com.gaiaframework.templates.AbstractPreloader;
	import com.gaiaframework.events.AssetEvent;
	
	public class Preloader extends AbstractPreloader
	{	
		public var scaffold:PreloaderScaffold;
		
		public function Preloader()
		{
			super();
		}
		override public function transitionIn():void
		{
			scaffold.transitionIn();
			transitionInComplete();
		}		
		override public function transitionOut():void
		{
			scaffold.transitionOut();
			transitionOutComplete();
		}
		override public function onProgress(event:AssetEvent):void
		{
			scaffold.onProgress(event);
		}
	}
}