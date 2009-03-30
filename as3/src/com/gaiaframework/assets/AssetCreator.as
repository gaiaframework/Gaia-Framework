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
	import com.gaiaframework.debug.GaiaDebug;
	import com.gaiaframework.core.SiteModel;
	import com.gaiaframework.core.SiteView;
	import com.gaiaframework.api.IPageAsset;
	import com.gaiaframework.api.Gaia;
	
	public class AssetCreator
	{
		public static function create(node:XML, page:IPageAsset):AbstractAsset
		{
			var asset:AbstractAsset;
			var type:String = String(node.@type).toLowerCase();
			var ext:String = String(node.@src.split(".").pop()).toLowerCase();
			if (ext == "swf" || ext == "jpg" || ext == "jpeg" || ext == "png" || ext == "gif" || type =="bitmap" || type == "sprite" || type == "movieclip") 
			{
				var d:String;
				if (ext == "swf" || type == "movieclip")
				{
					asset = new MovieClipAsset();
					d = String(node.@domain).toLowerCase();
					if (d == Gaia.DOMAIN_NEW || d == Gaia.DOMAIN_CURRENT) SpriteAsset(asset).domain = d;
				}
				else if (type == "sprite")
				{
					asset = new BitmapSpriteAsset();
				}
				else
				{
					asset = new BitmapAsset();
				}
				d = String(node.@depth).toLowerCase();
				if (d == Gaia.TOP || d == Gaia.BOTTOM || d == Gaia.MIDDLE || d == Gaia.PRELOADER || d == Gaia.NESTED)
				{
					DisplayObjectAsset(asset).depth = d;
				}
				else 
				{
					DisplayObjectAsset(asset).depth = page.depth;
				}
			}
			else if (ext == "xml" || type == "xml")
			{
				asset = new XMLAsset();
			}
			else if (ext == "mp3" || ext == "wav" || type == "sound")
			{
				asset = new SoundAsset();
			}
			else if (ext == "flv" || ext == "m4a" || ext == "f4v" || type == "netstream")
			{
				asset = new NetStreamAsset();
			}
			else if (ext == "css" || type == "stylesheet")
			{
				asset = new StyleSheetAsset();
			}
			else if (ext == "json" || type == "json")
			{
				asset = new JSONAsset();
			}
			else if (ext == "txt" || type == "text")
			{
				asset = new TextAsset();
			}
			else
			{
				throw new Error("Unknown asset type " + ext + " | " + type);
				return null;
			}
			asset.node = node;
			asset.id = node.@id;
			if (String(node.@src).indexOf("http") == 0) asset.src = node.@src;
			else asset.src = page.assetPath + node.@src;
			asset.title = node.@title;
			asset.preloadAsset = (node.@preload != "false");
			asset.showProgress = (node.@progress != "false");
			asset.bytes = int(node.@bytes);
			return asset;
		}
		public static function add(nodes:XMLList, page:IPageAsset):void
		{
			var len:int = nodes.length();
			if (len > 0)
			{
				var order:int = 0;
				var asset:AbstractAsset;
				if (page.assets != null)
				{
					for each (asset in page.assets)
					{
						if (asset.order > order) order = asset.order;
					}
				}
				else
				{
					page.assets = {};
				}
				for (var i:int = 0; i < len; i++) 
				{
					var node:XML = nodes[i];
					SiteModel.validateNode(node);
					if (!page.assets.hasOwnProperty(node.@id))
					{
						page.assets[node.@id] = create(node, page);
						AbstractAsset(page.assets[node.@id]).order = ++order;
						if (AbstractAsset(page).active) 
						{
							AbstractAsset(page.assets[node.@id]).init();
							if (page.assets[node.@id] is DisplayObjectAsset)
							{
								SiteView.instance.addAsset(page.assets[node.@id]);
								if (page.assets[node.@id].depth == Gaia.NESTED)
								{
									if (page.assets[node.@id] is BitmapSpriteAsset) page.content.addChild(BitmapSpriteAsset(page.assets[node.@id]).container);
									else page.content.addChild(DisplayObjectAsset(page.assets[node.@id]).loader);
								}
							}
						}
					}
					else
					{
						GaiaDebug.warn("*Add Asset Warning* Page '" + page.id + "' already has Asset '" + node.@id + "'");
					}
				}
			}
		}
	}
}