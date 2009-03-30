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

import com.gaiaframework.debug.GaiaDebug;
import com.gaiaframework.core.SiteModel;
import com.gaiaframework.core.SiteView;
import com.gaiaframework.api.Gaia;
import com.gaiaframework.assets.*;

class com.gaiaframework.assets.AssetCreator
{	
	public static function create(node:Object, page:PageAsset):AbstractAsset
	{
		var asset:AbstractAsset;
		var type:String = node.attributes.type.toLowerCase();
		var ext:String = String(node.attributes.src.split(".").pop()).toLowerCase();
		if (type == "sound" && ext == "swf")
		{
			asset = new SoundClipAsset();
		}
		else
		{
			if (ext == "swf" || ext == "jpg" || ext == "jpeg" || ext == "png" || ext == "gif" || type == "sprite" || type =="bitmap" || type == "movieclip") 
			{
				asset = new MovieClipAsset();
				var d:String = String(node.attributes.depth).toLowerCase();
				if (d == Gaia.TOP || d == Gaia.BOTTOM|| d == Gaia.MIDDLE || d == Gaia.PRELOADER)
				{
					MovieClipAsset(asset).depth = d;
				}
				else
				{
					MovieClipAsset(asset).depth = page.depth;
				}
			}
			else if (ext == "xml" || type == "xml")
			{
				asset = new XMLAsset();
			}
			else if (ext == "mp3" || ext == "wav" || type == "sound")
			{
				asset = new SoundAsset();
				SoundAsset(asset).streaming = (node.attributes.streaming == "true");
			}
			else if (ext == "flv" || type == "netstream")
			{
				asset = new NetStreamAsset();
			}
			else if (ext == "css" || type == "stylesheet")
			{
				asset = new StyleSheetAsset();
			}
			else
			{
				throw new Error("Unknown Asset Type :: " + ext);
				return null;
			}
		}
		asset.node = node;
		asset.id = node.attributes.id;
		if (String(node.attributes.src).indexOf("http") == 0) asset.setSrc(node.attributes.src);
		else asset.setSrc(page.assetPath + node.attributes.src);		
		asset.title = node.attributes.title;
		asset.preloadAsset = (node.attributes.preload != "false");
		asset.showProgress = (node.attributes.progress != "false");
		asset.bytes = Number(node.attributes.bytes || 0);
		return asset;
	}
	public static function add(nodes:Array, page:PageAsset):Void
	{
		var len:Number = nodes.length;
		if (len > 0)
		{
			if (page.assets == null) page.assets = {};
			for (var i:Number = 0; i < len; i++) 
			{
				var node:XML = nodes[i];
				SiteModel.validateNode(node);
				if (page.assets[node.attributes.id] == undefined) 
				{
					page.assets[node.attributes.id] = create(node, page);
					if (page.active) 
					{
						page.assets[node.attributes.id].init();
						if (page.assets[node.attributes.id] instanceof MovieClipAsset)
						{
							SiteView.instance.addAsset(page.assets[node.attributes.id]);
						}
					}
				}
				else
				{
					GaiaDebug.warn("*Add Asset Warning* Page '" + page.id + "' already has Asset '" + node.attributes.id + "'");
				}
			}
		}
	}
}