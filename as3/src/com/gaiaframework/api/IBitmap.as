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
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	/**
	 * This is the interface for the <code>BitmapAsset</code>.  
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Assets#BitmapAsset_.28AS3_only.29 BitmapAsset Documentation
	 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html flash.display.Bitmap
	 * 
	 * @author Steven Sacks
	 */
	public interface IBitmap extends IDisplayObject
	{
		/**
		 * Returns the loader.content Bitmap.
		 */
		function get content():Bitmap;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#bitmapData flash.display.Bitmap.bitmapData
		 */
		function get bitmapData():BitmapData;
		/**
		 * @private
		 */
		function set bitmapData(value:BitmapData):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#pixelSnapping flash.display.Bitmap.pixelSnapping
		 */
		function get pixelSnapping():String;
		/**
		 * @private
		 */
		function set pixelSnapping(value:String):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#smoothing flash.display.Bitmap.smoothing
		 */
		function get smoothing():Boolean;
		/**
		 * @private
		 */
		function set smoothing(value:Boolean):void;
	}
}