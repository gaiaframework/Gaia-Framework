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
	import flash.media.SoundTransform;
	import flash.net.NetStream;
	
	/**
	 * This is the interface for the <code>NetStreamAsset</code>.  
	 * 
	 * @see http://www.gaiaflashframework.com/wiki/index.php?title=Assets#NetStreamAsset NetStreamAsset Documentation
	 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html flash.net.NetStream
	 * 
	 * @author Steven Sacks
	 */
	public interface INetStream extends IAsset
	{
		/**
		 * Returns the reference to the NetStream
		 */
		function get ns():NetStream;
		/**
		 * Specifies the volume of the NetStream.
		 */
		function get volume():Number;
		/**
		 * @private
		 */
		function set volume(value:Number):void;
		/**
		 * Specifies the pan of the NetStream.
		 */
		function get pan():Number;
		/**
		 * @private
		 */
		function set pan(value:Number):void;
		/**
		 * Adjust the volume over time to a particular value.
		 * 
		 * @param volume A value between 0 and 1.
		 * @param duration The duration of the fade in seconds.
		 * @param onComplete The callback function to call when the fade is complete
		 */
		function fadeTo(volume:Number, duration:Number, onComplete:Function = null):void;
		/**
		 * Adjust the pan over time to a particular value.
		 * 
		 * @param pan A value between -1 and 1.
		 * @param duration The duration of the pan in seconds.
		 * @param onComplete The callback function to call when the pan is complete
		 */
		function panTo(pan:Number, duration:Number, onComplete:Function = null):void;
		// PROXY FLV PROPS/FUNCS
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#bufferLength flash.net.NetStream.bufferLength
		 */
		function get bufferLength():Number;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#bufferTime flash.net.NetStream.bufferTime
		 */
		function get bufferTime():Number;
		/**
		 * @private
		 */
		function set bufferTime(bt:Number):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#bytesLoaded flash.net.NetStream.bytesLoaded
		 */
		function get bytesLoaded():int;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#bytesTotal flash.net.NetStream.bytesTotal
		 */
		function get bytesTotal():int;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#client flash.net.NetStream.client
		 */
		function get client():Object;
		/**
		 * @private
		 */
		function set client(value:Object):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#currentFPS flash.net.NetStream.currentFPS
		 */
		function get currentFPS():Number;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#close() flash.net.NetStream.close()
		 */
		function close():void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#pause() flash.net.NetStream.pause()
		 */
		function pause():void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#resume() flash.net.NetStream.resume()
		 */
		function resume():void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#play() flash.net.NetStream.play()
		 */
		function play(start:Number = -2, len:Number = -1):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#seek() flash.net.NetStream.seek()
		 */
		function seek(offset:Number):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#soundTransform flash.net.NetStream.soundTransform
		 */
		function get soundTransform():SoundTransform;
		/**
		 * @private
		 */
		function set soundTransform(value:SoundTransform):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/NetStream.html#time flash.net.NetStream.time
		 */
		function get time():Number;
		/**
		 * Returns the metaData of the NetStream. Available after the metaData is loaded.
		 */
		function get metaData():Object;
		/**
		 * Returns the duration of the NetStream. Available after the meteData is loaded.
		 */
		function get duration():Number;
	}
}