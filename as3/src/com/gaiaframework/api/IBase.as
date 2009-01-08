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

package com.gaiaframework.api
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Dispatched when a page's <code>transitionIn</code> is called by Gaia.
	 * @eventType com.gaiaflashframework.events.TRANSITION_IN
	 */
	[Event(name = "transitionIn", type = "com.gaiaflashframework.events.PageEvent")]
	/**
	 * Dispatched when a page's <code>transitionOut</code> is called by Gaia.
	 * @eventType com.gaiaflashframework.events.TRANSITION_OUT
	 */
	[Event(name = "transitionOut", type = "com.gaiaflashframework.events.PageEvent")]
	/**
	 * Dispatched to Gaia when a page is finished transitioning in.
	 * @eventType com.gaiaflashframework.events.TRANSITION_IN_COMPLETE
	 */
	[Event(name = "transitionInComplete", type = "com.gaiaflashframework.events.PageEvent")]
	/**
	 * Dispatched to Gaia when a page is finished transitioning out.
	 * @eventType com.gaiaflashframework.events.TRANSITION_OUT_COMPLETE
	 */
	[Event(name = "transitionOutComplete", type = "com.gaiaflashframework.events.PageEvent")]
	
	/**
	 * This is the interface of the base for <code>IPage</code> and <code>IPreloader</code>.  It contains Gaia's four method conventions.
	 * 
	 * @author Steven Sacks
	 */
	public interface IBase extends IEventDispatcher
	{
		/**
		 * Gaia calls this method on a page or preloader when it needs to transition in.
		 */
		function transitionIn():void;
		/**
		 * Gaia calls this method on a page or preloader when it needs to transition out.
		 */
		function transitionOut():void;
		/**
		 * Pages call this method to let Gaia know when they are finished transitioning in.
		 */
		function transitionInComplete():void;
		/**
		 * Pages and preloaders call this method to let Gaia know when they are finished transitioning out.
		 */
		function transitionOutComplete():void;
	}
}