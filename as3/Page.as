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

package PACKAGENAME
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;%IMPORTS%
	
	public class CLASSNAME extends AbstractPage
	{	
		public function CLASSNAME()
		{
			super();%ALPHA%
			new Scaffold(this);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();%TRANSITIONIN%
		}
		override public function transitionOut():void 
		{
			super.transitionOut();%TRANSITIONOUT%
		}
	}
}