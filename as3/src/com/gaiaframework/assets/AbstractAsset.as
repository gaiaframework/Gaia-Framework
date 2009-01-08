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
	import com.gaiaframework.events.AssetEvent;
	import com.gaiaframework.api.IAsset;
	
	import com.gaiaframework.debug.GaiaDebug;
	import com.gaiaframework.core.GaiaImpl;
	
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
		
	import flash.net.URLRequest;
	
	[Event(name = "assetComplete", type = "com.gaiaflashframework.events.AssetEvent")]
	[Event(name = "assetProgress", type = "com.gaiaflashframework.events.AssetEvent")]
	
	public class AbstractAsset extends EventDispatcher implements IAsset
	{
		protected var _id:String;
		protected var _src:String;
		protected var _title:String;
		protected var _preloadAsset:Boolean;
		protected var _showProgress:Boolean;
		protected var _bytes:int;
		protected var _node:XML;
		
		protected var isActive:Boolean;
		protected var request:URLRequest;
		
		protected var _order:int;
		
		function AbstractAsset()
		{
			super();
		}
		public function init():void 
		{
			request = new URLRequest(src);
		}
		public function load(...args):void
		{
			isActive = true;
		}
		public function destroy():void
		{
			isActive = false;
		}
		public function get percentLoaded():Number
		{
			var t:int = getBytesTotal();
			if (!t) return 0;
			return getBytesLoaded() / t;
		}
		// returns whether this asset is in the active tree 
		public function get active():Boolean
		{
			return isActive;
		}
		protected function onProgress(event:ProgressEvent):void
		{
			var l:int = int(event.bytesLoaded);
			var t:int = int(event.bytesTotal);
			dispatchEvent(new AssetEvent(AssetEvent.ASSET_PROGRESS, false, false, this, l, t, l / t));
		}
		protected function onComplete(event:Event):void
		{
			var t:int = getBytesTotal();
			if (_bytes > 0 && t > 0 && _bytes != t) _bytes = t;
			dispatchEvent(new AssetEvent(AssetEvent.ASSET_COMPLETE, false, false, this));
		}
		protected function onError(event:IOErrorEvent):void
		{
			GaiaDebug.warn(this + ' [IOErrorEvent text="' + event.text + '"]');
			dispatchEvent(new AssetEvent(AssetEvent.ASSET_ERROR, false, false, this));
		}
		internal function loadOnDemand():void {}
		// Interface Compliance
		public function preload():void {}
		public function retry():void {}
		public function abort():void {}
		public function getBytesLoaded():int {return 0;}
		public function getBytesTotal():int {return 0; }
		//
		public function get id():String
		{
			return _id;
		}
		public function set id(value:String):void
		{
			if (_id == null) _id = value;
		}
		public function get src():String
		{
			return GaiaImpl.instance.resolveBinding(_src);
		}
		public function set src(value:String):void
		{
			_src = value;
		}
		public function get title():String
		{
			return _title;
		}
		public function set title(value:String):void
		{
			_title = value;
		}
		public function get preloadAsset():Boolean
		{
			return _preloadAsset;
		}
		public function set preloadAsset(value:Boolean):void
		{
			_preloadAsset = value;
		}
		public function get showProgress():Boolean
		{
			return _showProgress;
		}
		public function set showProgress(value:Boolean):void
		{
			_showProgress = value;
		}
		public function get bytes():int
		{
			return _bytes;
		}
		public function set bytes(value:int):void
		{
			_bytes = value;
		}
		public function get order():int
		{
			return _order;
		}
		public function set order(value:int):void
		{
			if (_order == 0) _order = value;
		}
		public function get node():XML
		{
			return _node;
		}
		public function set node(value:XML):void
		{
			if (!_node) _node = value;
		}
	}
}