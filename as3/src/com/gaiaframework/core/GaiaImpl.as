/*****************************************************************************************************
* Gaia Framework for Adobe Flash �2007-2009
* Written by: Steven Sacks
* email: stevensacks@gmail.com
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is �2007-2009 Steven Sacks and is released under the MIT License:
* http://www.opensource.org/licenses/mit-license.php 
*****************************************************************************************************/

package com.gaiaframework.core
{
	import com.gaiaframework.debug.GaiaDebug;
	import com.gaiaframework.events.*;
	import com.gaiaframework.assets.*;
	import com.gaiaframework.api.*;
	
	import com.asual.swfaddress.SWFAddress;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.ui.ContextMenu;
	
	public class GaiaImpl implements IGaia
	{
		private static var _instance:GaiaImpl;
		
		public function GaiaImpl()
		{
			GaiaDebug.log("Gaia Framework (AS3) v3.0.0");
		}
		public static function birth():IGaia
		{
			if (_instance == null) return _instance = new GaiaImpl();
			return _instance;
		}
		public static function get instance():GaiaImpl
		{
			return _instance;
		}
		public function goto(branch:String, flow:String = null):void
		{
			GaiaHQ.instance.goto(branch, flow);
		}
		public function gotoRoute(route:String, flow:String = null):void
		{
			GaiaHQ.instance.goto(SiteModel.routes[route] || "index", flow);
		}
		public function getSiteTree():IPageAsset
		{
			return IPageAsset(SiteModel.tree);
		}
		public function getMenuArray():Array
		{
			return SiteModel.menuArray;
		}
		public function getSiteTitle():String
		{
			return SiteModel.title;
		}
		public function setSiteTitle(value:String):void
		{
			SiteModel.title = value;
			if (value.length > 0) setTitle(value.split("%PAGE%").join(BranchTools.getPage(getCurrentBranch()).title));
		}
		public function setDelimiter(value:String):void
		{
			SiteModel.delimiter = value;
		}
		public function getSiteXML():XML
		{
			return SiteModel.xml;
		}
		public function getPage(branch:String):IPageAsset
		{
			return IPageAsset(BranchTools.getPage(branch));
		}
		public function getDepthContainer(name:String):Sprite
		{
			return SiteView.getDepthContainer(name);
		}
		public function getValidBranch(branch:String):String
		{
			return BranchTools.getValidBranch(branch);
		}
		public function getCurrentBranch():String
		{
			return SiteController.getCurrentBranch();
		}
		public function getPreloader():IMovieClip
		{
			return SiteController.getPreloader().asset;
		}
		public function setPreloader(asset:IMovieClip = null):void
		{
			SiteController.getPreloader().asset = asset;
		}
		public function getAssetPreloader():IMovieClip
		{
			return AssetLoader.instance.asset;
		}
		public function setAssetPreloader(asset:IMovieClip = null):void
		{
			AssetLoader.instance.asset = asset;
		}
		public function getDeeplink():String
		{
			return GaiaSWFAddress.deeplink;
		}
		public function getDefaultFlow():String
		{
			return SiteModel.defaultFlow;
		}
		public function setDefaultFlow(flow:String):void
		{
			SiteModel.defaultFlow = flow;
		}
		public function getContextMenu():ContextMenu
		{
			return GaiaMain.instance.contextMenu;
		}
		public function refreshContextMenu():void
		{
			GaiaContextMenu.init(SiteModel.menu);
		}
		public function addAssets(nodes:XMLList, page:IPageAsset):void
		{
			AssetCreator.add(nodes, page);
		}
		public function getWidth():int
		{
			return GaiaMain.instance._$WIDTH;
		}
		public function getHeight():int
		{
			return GaiaMain.instance._$HEIGHT;
		}
		public function setLoadTimeout(value:int):void
		{
			BranchLoader.timeoutLength = value;
		}
		// SWFAddress Proxy
		public function back():void
		{
			SWFAddress.back();
		}
		public function forward():void
		{
			SWFAddress.forward();
		}
		public function getTitle():String
		{
			return SWFAddress.getTitle();
		}
		public function setTitle(title:String):void
		{
			SWFAddress.setTitle(title);
		}
		public function href(url:String, target:String = null):void
		{
			SWFAddress.href(url, target);
		}
		public function popup(url:String, name:String, options:String, handler:String = null):void
		{
			SWFAddress.popup(url, name, options, handler);
		}
		public function setHistory(value:Boolean):void
		{
			SWFAddress.setHistory(value);
		}
		public function getHistory():Boolean
		{
			return SWFAddress.getHistory();
		}
		public function setTracker(value:String):void
		{
			SWFAddress.setTracker(value);
		}
		public function getTracker():String
		{
			return SWFAddress.getTracker();
		}
		public function getBaseURL():String
		{
			return SWFAddress.getBaseURL();
		}

		// hijack Events
		public function beforeGoto(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.BEFORE_GOTO, target, hijack, onlyOnce);
		}
		public function afterGoto(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.AFTER_GOTO, target, hijack, onlyOnce);
		}
		
		public function beforeTransitionOut(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.BEFORE_TRANSITION_OUT, target, hijack, onlyOnce);
		}
		public function afterTransitionOut(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.AFTER_TRANSITION_OUT, target, hijack, onlyOnce);
		}
		
		public function beforePreload(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.BEFORE_PRELOAD, target, hijack, onlyOnce);
		}
		public function afterPreload(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.AFTER_PRELOAD, target, hijack, onlyOnce);
		}
		
		public function beforeTransitionIn(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.BEFORE_TRANSITION_IN, target, hijack, onlyOnce);
		}
		public function afterTransitionIn(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.AFTER_TRANSITION_IN, target, hijack, onlyOnce);
		}
		
		public function afterComplete(target:Function, hijack:Boolean = false, onlyOnce:Boolean = false):Function
		{
			return GaiaHQ.instance.addListener(GaiaEvent.AFTER_COMPLETE, target, false, onlyOnce);
		}
		
		// Remove hijack Events (just in case you need to manually)
		public function removeBeforeGoto(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.BEFORE_GOTO, target);
		}
		public function removeAfterGoto(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.AFTER_GOTO, target);
		}
		
		public function removeBeforeTransitionOut(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.BEFORE_TRANSITION_OUT, target);
		}
		public function removeAfterTransitionOut(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.AFTER_TRANSITION_OUT, target);
		}
		
		public function removeBeforePreload(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.BEFORE_PRELOAD, target);
		}
		public function removeAfterPreload(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.AFTER_PRELOAD, target);
		}
		
		public function removeBeforeTransitionIn(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.BEFORE_TRANSITION_IN, target);
		}
		public function removeAfterTransitionIn(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.AFTER_TRANSITION_IN, target);
		}
		
		public function removeAfterComplete(target:Function):void
		{
			GaiaHQ.instance.removeListener(GaiaEvent.AFTER_COMPLETE, target);
		}
		
		// Deeplink event
		public function addDeeplinkListener(target:Function):void
		{
			GaiaSWFAddress.instance.addEventListener(GaiaSWFAddressEvent.DEEPLINK, target, false, 0, true);
		}
		public function removeDeeplinkListener(target:Function):void
		{
			GaiaSWFAddress.instance.removeEventListener(GaiaSWFAddressEvent.DEEPLINK, target);
		}
		
		// Binding Resolution
		public function resolveBinding(value:String):String
		{
			// no expression to resolve
			if (value.indexOf("{") == -1) return value;
			// evaluate expression
			var start:int = value.indexOf("{");
			var end:int = value.indexOf("}");
			var expression:String = value.substring(start + 1, end);
			var before:String = value.substring(0, start);
			var after:String = value.substr(end + 1);
			// if expression contains flashvars syntax, look in flashvars
			if (expression.charAt(0) == "@") return resolveBinding(before + GaiaMain.instance.stage.loaderInfo.parameters[expression.substr(1)] + after);
			// if expression does not contain a branch, look in main
			if (expression.indexOf(".") == -1 && expression.indexOf("/") == -1) return resolveBinding(before + GaiaMain.instance[expression] + after);
			// if expression contains a branch, look in that page
			var page:PageAsset = BranchTools.getPage(expression.split(".")[0]);
			if (page != null)
			{
				if (page.active && page.percentLoaded == 1) return resolveBinding(before + page.content[expression.split(".")[1]] + after);
			}
			else
			{
				throw new Error("*Invalid Expression* Page '" + expression.split(".")[0] + "' does not exist in site.xml");
			}
			return value;
		}
	}
}