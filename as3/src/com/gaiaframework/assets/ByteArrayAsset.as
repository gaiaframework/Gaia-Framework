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

package com.gaiaframework.assets
{
	import com.gaiaframework.api.IByteArray;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	
	public class ByteArrayAsset extends AbstractAsset implements IByteArray
	{
		protected var loader:URLLoader;
		private var _data:ByteArray;
		
		function ByteArrayAsset()
		{
			super();
		}
		public function get data():ByteArray 
		{ 
			return _data; 
		}
		override public function init():void
		{
			isActive = true;
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			addListeners(loader);
			super.init();
		}
		override public function preload():void
		{
			request.url = src;
			loader.load(request);
			super.load();
		}
		override protected function onComplete(event:Event):void
		{
			_data = loader.data as ByteArray;
			removeListeners(loader);
			super.onComplete(event);
		}
		override public function load(...args):void
		{
			AssetLoader.instance.load(this);
		}
		override internal function loadOnDemand():void 
		{
			preload();
		}
		override public function destroy():void 
		{
			removeListeners(loader);
			try
			{
				loader.close();
			}
			catch (error:Error)
			{
				// it did not need to be closed so fail gracefully
			}
			loader = null;
			_data = null;
			super.destroy();
		}
		override public function retry():void
		{
			request.url = src;
			loader.load(request);
		}
		override public function abort():void
		{
			AssetLoader.instance.abort(this);
			destroy();
		}
		override public function getBytesLoaded():int
		{
			return loader.bytesLoaded;
		}
		override public function getBytesTotal():int
		{
			return loader.bytesTotal;
		}
		override public function toString():String
		{
			return "[ByteArrayAsset] " + _id + " : " + _order + " ";
		}
	}
}