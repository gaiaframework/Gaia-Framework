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

package com.gaiaframework.assets
{
	import com.gaiaframework.api.IText;
	import com.gaiaframework.utils.CacheBuster;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	
	public class TextAsset extends AbstractAsset implements IText
	{
		protected var loader:URLLoader;
		protected var isNoCache:Boolean = false;
		protected var _data:String;
		
		function TextAsset()
		{
			super();
		}
		public function get text():String 
		{ 
			return _data; 
		}
		override public function init():void
		{
			isActive = true;
			loader = new URLLoader();
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
			loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			var ext:String = String(src.split(".").pop()).toLowerCase();
			isNoCache = (ext == "xml" || ext == "css" || ext == "json");
			super.init();
		}
		override public function preload():void
		{
			request.url = isNoCache ? CacheBuster.create(src) : src;
			loader.load(request);
			super.load();
		}
		override protected function onComplete(event:Event):void
		{
			_data = String(event.target.data);
			loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
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
			try
			{
				loader.close();
			}
			catch (error:Error)
			{
				// it did not need to be closed so fail gracefully
			}
			_data = null;
			loader = null;
			super.destroy();
		}
		override public function retry():void
		{
			request.url = isNoCache ? CacheBuster.create(src) : src;
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
			return "[TextAsset] " + _id + " : " + _order + " ";
		}
	}
}