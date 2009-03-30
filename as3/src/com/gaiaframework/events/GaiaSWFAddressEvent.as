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

package com.gaiaframework.events
{
	import flash.events.Event;
	
	/**
	 * The GaiaSWFAddressEvent is dispatched to Pages in their onDeeplink listener.
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Events_Package#GaiaSWFAddressEvent GaiaSWFAddressEvent Documentation
	 *  
	 * @author Steven Sacks
	 */
	public class GaiaSWFAddressEvent extends Event
	{
		/**
		 * @private
		 */
		public static const DEEPLINK:String = "deeplink";
		/**
		 * @private
		 */
		public static const GOTO:String = "goto";
		
		/**
		 * The deeplink beyond the valid branch is available in this property in the onDeeplink event.
		 */
		public var deeplink:String;
		/**
		 * The valid branch before the deeplink is available in this property in the onDeeplink event.
		 * 
		 * @see com.gaiaframework.api.IPage
		 */
		public var branch:String;
		/**
		 * @private
		 */
		public function GaiaSWFAddressEvent(type:String, bubbles:Boolean, cancelable:Boolean, deeplink:String, branch:String = null)
		{
			super(type, bubbles, cancelable);
			this.deeplink = deeplink;
			this.branch = branch;
		}
		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new GaiaSWFAddressEvent(type, bubbles, cancelable, deeplink, branch);
		}
		/**
		 * @private
		 */
		public override function toString():String
		{
			return formatToString("GaiaSWFAddressEvent", "type", "bubbles", "cancelable", "eventPhase", "deeplink", "branch");
		}
	}
}