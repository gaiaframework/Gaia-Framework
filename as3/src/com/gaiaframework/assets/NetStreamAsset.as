﻿/*****************************************************************************************************
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
	import com.gaiaframework.api.INetStream;
	import com.gaiaframework.utils.SoundUtils;
	import com.gaiaframework.events.AssetEvent;
	
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class NetStreamAsset extends AbstractAsset implements INetStream
	{
		private var _ns:NetStream;
		private var _nc:NetConnection;		
		private var _transform:SoundTransform;
		private var progressTimer:Timer;
		private var _metaData:Object;
		
		public function NetStreamAsset()
		{
			super();
			progressTimer = new Timer(10);
			progressTimer.addEventListener(TimerEvent.TIMER, updateStreamProgress);
		}
		public function get ns():NetStream
		{
			return _ns;
		}
		override public function init():void
		{
			isActive = true;
			_nc = new NetConnection();
			_nc.connect(null);
			_ns = new NetStream(_nc);
			_transform = _ns.soundTransform;
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStreamStatus);
			_ns.client = this;
		}
		override public function preload():void
		{
			_ns.play(src);
			_ns.pause();
			progressTimer.start();
			super.load();
		}
		override public function load(...args):void
		{
			_ns.play(src);
		}
		override public function destroy():void
		{
			progressTimer.reset();
			try
			{
				_ns.pause();
				_ns.close();
			}
			catch (e:Error)
			{
				// it did not need to be closed so fail gracefully
			}
			_ns = null;
			_nc = null;
			super.destroy();
		}
		override public function retry():void
		{
			_ns.play(src);
			_ns.pause();
		}
		override public function abort():void
		{
			destroy();
		}
		override protected function onComplete(event:Event):void
		{
			progressTimer.reset();
			super.onComplete(event);
		}
		override public function getBytesLoaded():int
		{
			return _ns.bytesLoaded;
		}
		override public function getBytesTotal():int
		{
			return _ns.bytesTotal;
		}
		private function updateStreamProgress(event:TimerEvent):void
		{
			onProgress(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _ns.bytesLoaded, _ns.bytesTotal));
			if (_ns.bytesLoaded == _ns.bytesTotal && _ns.bytesTotal > 4) onComplete(new Event(Event.COMPLETE));
		}

		// META DATA + STATUS
		public function onMetaData(info:Object):void
		{
			_metaData = info;
		}
		public function get metaData():Object
		{
			return _metaData;
		}
		public function get duration():Number
		{
			return Number(_metaData != null ? _metaData.duration || 0 : 0);
		}
		private function onNetStreamStatus(event:NetStatusEvent):void
		{
			dispatchEvent(event);
		}		
		// WRAPPER METHODS
		public function get volume():Number
		{
			return _transform.volume;
		}
		public function set volume(value:Number):void
		{
			_transform.volume = value;
			_ns.soundTransform = _transform;
		}
		public function get pan():Number
		{
			return _transform.pan;
		}
		public function set pan(value:Number):void
		{
			_transform.pan = value;
			_ns.soundTransform = _transform;
		}
		public function fadeTo(volume:Number, duration:Number, onComplete:Function = null):void
		{
			SoundUtils.fadeTo(this, volume, duration, onComplete);
		}
		public function panTo(pan:Number, duration:Number, onComplete:Function = null):void
		{
			SoundUtils.panTo(this, pan, duration, onComplete);
		}
		
		// PROXY FLV PROPS/FUNCS
		public function get bufferLength():Number
		{
			return _ns.bufferLength;
		}
		public function get bufferTime():Number
		{
			return _ns.bufferTime;
		}
		public function set bufferTime(value:Number):void
		{
			_ns.bufferTime = value;
		}
		public function get bytesLoaded():int
		{
			return _ns.bytesLoaded;
		}
		public function get bytesTotal():int
		{
			return _ns.bytesTotal;
		}
		public function get client():Object
		{
			return _ns.client;
		}
		public function set client(value:Object):void
		{
			_ns.client = value;
		}
		public function close():void
		{
			_ns.close();
		}
		public function get currentFPS():Number
		{
			return _ns.currentFPS;
		}
		public function pause():void
		{
			_ns.pause();
		}
		public function play(start:Number = -2, len:Number = -1):void
		{
			_ns.play(src, start, len);
		}
		public function resume():void
		{
			_ns.resume();
		}
		public function seek(offset:Number):void
		{
			_ns.seek(offset);
		}
		public function get soundTransform():SoundTransform
		{
			return _ns.soundTransform;
		}
		public function set soundTransform(value:SoundTransform):void
		{
			_transform = value;
			_ns.soundTransform = value;
		}
		public function get time():Number
		{
			return _ns.time;
		}
		
		// EVENT LISTENER OVERRIDES
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if (type != AssetEvent.ASSET_PROGRESS && type != AssetEvent.ASSET_COMPLETE && type != AssetEvent.ASSET_ERROR && type != IOErrorEvent.IO_ERROR) 
			{
				_ns.addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
			else
			{
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
		}
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (type != AssetEvent.ASSET_PROGRESS && type != AssetEvent.ASSET_COMPLETE && type != AssetEvent.ASSET_ERROR && type != IOErrorEvent.IO_ERROR) 
			{
				_ns.removeEventListener(type, listener, useCapture);
			}
			else
			{
				super.removeEventListener(type, listener, useCapture);
			}
		}
		override public function toString():String
		{
			return "[NetStreamAsset] " + _id;
		}
	}
}