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

package com.gaiaframework.templates
{
	import com.gaiaframework.events.PageEvent;	
	import com.gaiaframework.api.IBase;
	import flash.display.MovieClip;
	
	[Event(name = "transitionIn", type = "com.gaiaflashframework.events.PageEvent")]
	[Event(name = "transitionOut", type = "com.gaiaflashframework.events.PageEvent")]
	[Event(name = "transitionInComplete", type = "com.gaiaflashframework.events.PageEvent")]
	[Event(name = "transitionOutComplete", type = "com.gaiaflashframework.events.PageEvent")]
	
	public class AbstractBase extends MovieClip implements IBase
	{
		function AbstractBase()
		{
			super();
		}
		public function transitionIn():void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_IN));
		}
		public function transitionOut():void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_OUT));
		}
		public function transitionInComplete():void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_IN_COMPLETE));
		}
		public function transitionOutComplete():void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_OUT_COMPLETE));
		}
	}
}
