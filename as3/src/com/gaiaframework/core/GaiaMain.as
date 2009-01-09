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

//Main initializes the framework.  It sets up the primary event broadcast/listener chains.

package com.gaiaframework.core
{
	import com.gaiaframework.events.GaiaSWFAddressEvent;
	import com.gaiaframework.events.GaiaEvent;
	
	import com.gaiaframework.assets.AssetLoader;
	import com.gaiaframework.utils.CacheBuster;
	
	import com.gaiaframework.api.Gaia;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class GaiaMain extends Sprite
	{
		protected var model:SiteModel;
		protected var controller:SiteController;
		protected var view:SiteView;
		
		public var alignCount:int = 0;
		public var _$WIDTH:int = 0;
		public var _$HEIGHT:int = 0;
		
		protected var siteXML:String;
		
		protected static var _instance:GaiaMain;
		
		public function GaiaMain()
		{
			super();
			_instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_$WIDTH = stage.stageWidth;
			_$HEIGHT = stage.stageHeight;
			CacheBuster.isOnline = (stage.loaderInfo.url.indexOf("http") == 0);
			use namespace gaia_internal;
			Gaia.impl = GaiaImpl.birth();
			model = new SiteModel(stage.loaderInfo.url);
			model.addEventListener(Event.COMPLETE, onSiteModelComplete);
			model.load(stage.loaderInfo.parameters.siteXML || siteXML);
			view = new SiteView();
		}
		public static function get instance():GaiaMain
		{
			return _instance;
		}
		private function onSiteModelComplete(event:Event):void
		{	
			addChild(view);
			controller = new SiteController(view);
			SiteController.getPreloader().addEventListener(PreloadController.READY, onPreloaderReady);
			GaiaHQ.birth();
			GaiaSWFAddress.birth(stage.loaderInfo.parameters.branch);
			GaiaHQ.instance.addEventListener(GaiaEvent.GOTO, controller.onGoto);
			GaiaHQ.instance.addEventListener(GaiaHQ.TRANSITION_OUT, controller.onTransitionOut);
			GaiaHQ.instance.addEventListener(GaiaHQ.TRANSITION_IN, controller.onTransitionIn);
			GaiaHQ.instance.addEventListener(GaiaHQ.PRELOAD, controller.onPreload);
			GaiaHQ.instance.addEventListener(GaiaHQ.COMPLETE, controller.onComplete);
			contextMenu = GaiaContextMenu.init(false);
		}
		private function onPreloaderReady(event:Event):void
		{
			AssetLoader.birth(PreloadController(event.target).asset);
			init();
		}
		protected function initComplete():void
		{
			if (SiteModel.indexFirst) 
			{
				GaiaHQ.instance.addListener(GaiaEvent.AFTER_COMPLETE, initSWFAddress, false, true);
				GaiaHQ.instance.goto(SiteModel.indexID);
			}
			else
			{
				GaiaHQ.instance.addListener(GaiaEvent.AFTER_PRELOAD, initHistory, false, true);
				contextMenu = GaiaContextMenu.init(SiteModel.menu);
				initSWFAddress(new Event(Event.COMPLETE));
			}
		}
		private function initSWFAddress(event:Event):void
		{
			GaiaHQ.instance.addEventListener(GaiaEvent.GOTO, GaiaSWFAddress.instance.onGoto);
			GaiaSWFAddress.instance.addEventListener(GaiaSWFAddressEvent.GOTO, GaiaHQ.instance.onGoto);
			if (SiteModel.indexFirst)
			{
				GaiaHQ.instance.addListener(GaiaEvent.AFTER_PRELOAD, initHistory, false, true);
				contextMenu = GaiaContextMenu.init(SiteModel.menu);
			}
			GaiaSWFAddress.instance.init();
		}
		private function initHistory(event:Event):void
		{
			GaiaImpl.instance.setHistory(SiteModel.history);
		}
		// override for custom initialization
		protected function init():void
		{
			initComplete();
		}
		// site centering code
		protected function centerSite(w:int, h:int):void
		{
			_$WIDTH = w;
			_$HEIGHT = h;
			stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(Event.ENTER_FRAME, alignEnterFrame, false, 0, true);
		}
		protected function alignEnterFrame(event:Event):void
		{
			onResize(new Event(Event.RESIZE));
			if (alignCount++ > 2)
			{
				removeEventListener(Event.ENTER_FRAME, alignEnterFrame);
			}
		}
		protected function onResize(event:Event):void {}
	}
}