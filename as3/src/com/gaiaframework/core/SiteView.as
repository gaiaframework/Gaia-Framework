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

package com.gaiaframework.core
{
	import com.gaiaframework.assets.BitmapAsset;
	import com.gaiaframework.assets.DisplayObjectAsset;
	import com.gaiaframework.assets.SpriteAsset;
	import com.gaiaframework.assets.BitmapSpriteAsset;
	import com.gaiaframework.assets.PageAsset;
	import com.gaiaframework.api.Gaia;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SiteView extends Sprite
	{
		private var PRELOADER:Sprite = new Sprite();
		private var BOTTOM:Sprite = new Sprite();
		private var MIDDLE:Sprite = new Sprite();
		private var TOP:Sprite = new Sprite();
		
		private var activePage:PageAsset;
		
		private static var depths:Object;
		
		private static var _instance:SiteView;
		
		public function SiteView()
		{
			super();
			depths = {};
			depths[Gaia.PRELOADER] = PRELOADER;
			depths[Gaia.BOTTOM] = BOTTOM;
			depths[Gaia.MIDDLE] = MIDDLE;
			depths[Gaia.TOP] = TOP;
			PRELOADER.name = "PRELOADER";
			BOTTOM.name = "BOTTOM";
			MIDDLE.name = "MIDDLE";
			TOP.name = "TOP";
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_instance = this;
		}
		public static function get instance():SiteView
		{
			return _instance;
		}
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(BOTTOM);
			addChild(MIDDLE);
			addChild(TOP);
			addChild(PRELOADER);
			if (SiteModel.preloaderDepth == Gaia.BOTTOM) setChildIndex(PRELOADER, 1);
			else if (SiteModel.preloaderDepth == Gaia.MIDDLE) setChildIndex(PRELOADER, 2);
		}
		public static function getDepthContainer(name:String):Sprite
		{
			return depths[name];
		}
		public function get preloader():Sprite
		{
			return PRELOADER;
		}
		internal function addPage(page:PageAsset):void
		{
			activePage = page;
			activePage.loader.name = activePage.branch.split("/").join("_");
			Sprite(depths[activePage.depth] || MIDDLE).addChild(activePage.loader);
		}
		public function addAsset(asset:DisplayObjectAsset):void
		{
			asset.loader.name = activePage.branch.split("/").join("_") + "_$" + asset.id;
			if (asset is BitmapSpriteAsset)
			{
				var spr:Sprite = new Sprite();
				spr.addChild(asset.loader);
				SpriteAsset(asset).container = spr;
				Sprite(depths[asset.depth] || MIDDLE).addChild(spr);
			}
			else
			{
				if (!(asset is BitmapAsset)) SpriteAsset(asset).container = asset.loader;
				Sprite(depths[asset.depth] || MIDDLE).addChild(asset.loader);
			}
		}
	}
}