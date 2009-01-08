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

package com.gaiaframework.core
{
	import com.gaiaframework.events.GaiaSWFAddressEvent;
	import com.gaiaframework.events.GaiaEvent;
	import com.gaiaframework.debug.GaiaDebug;
	import flash.events.EventDispatcher;

	import com.gaiaframework.assets.PageAsset;
	import com.asual.swfaddress.*;

	// This class uses SWFAddress 2.2 written by Rostislav Hristov
	// More info: http://www.asual.com/SWFAddress/

	public class GaiaSWFAddress extends EventDispatcher
	{
		private static var _deeplink:String = "";	
		private var _value:String = "/";	
		private var isInternal:Boolean = false;
		
		private static var rootBranch:String;
		public static var isSinglePage:Boolean = false;
		
		private var lastValidBranch:String;
		private var lastFullBranch:String;
		
		private static var _instance:GaiaSWFAddress;
		
		function GaiaSWFAddress() 
		{
			super();
		}
		public static function birth(s:String = null):void
		{
			rootBranch = s;
			if (_instance == null) _instance = new GaiaSWFAddress();
		}
		public static function get instance():GaiaSWFAddress
		{
			return _instance;
		}
		public static function get deeplink():String
		{
			return _deeplink;
		}	
		public function init():void 
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onChange);
			SWFAddress.setHistory(false);
			var v:String = SWFAddress.getValue();
			if (v == "/") v = insertStrictSlashes();
			if (v != "/") SWFAddress.setValue(v);
		}
		public function onGoto(event:GaiaEvent):void
		{
			if (!event.external && lastFullBranch != event.fullBranch)
			{
				isInternal = true;
				var strictString:String;
				if (SiteModel.routing)
				{
					_deeplink = event.fullBranch.substring(event.validBranch.length, event.fullBranch.length);
					strictString = insertStrictSlashes((!isSinglePage ? BranchTools.getPage(event.validBranch).route : "") + _deeplink);
				}
				else
				{
					strictString = insertStrictSlashes(event.fullBranch.split("/").slice(1).join("/"));
				}
				if (SiteModel.title.length > 0 && lastValidBranch != event.validBranch) SWFAddress.setTitle(SiteModel.title.split("%PAGE%").join(BranchTools.getPage(event.validBranch).title));
				lastValidBranch = event.validBranch;
				lastFullBranch = event.fullBranch;
				SWFAddress.setValue(strictString);
				isInternal = false;
			}
		}
		public function onChange(event:SWFAddressEvent):void 
		{
			_value = stripStrictSlashes(event.value);
			dispatchDeeplink();
			if (!isInternal)
			{
				if (_value.length > 1) 
				{
					if (SiteModel.routing)
					{
						var validRoute:String = validate(_value);
						if (validRoute.length > 0) dispatchGoto(SiteModel.routes[validRoute] + _deeplink);
						else if (isSinglePage) dispatchGoto(SiteModel.indexID + _deeplink);
					}
					else 
					{
						var validBranch:String = validate(_value);
						dispatchGoto(validBranch);
					}
				} 
				else 
				{
					if (rootBranch && rootBranch.length > 0)
					{
						dispatchGoto(rootBranch);
					}
					else
					{
						dispatchGoto(SiteModel.indexID);
					}
				}
			}
		}
		private function dispatchGoto(branch:String):void
		{
			dispatchEvent(new GaiaSWFAddressEvent(GaiaSWFAddressEvent.GOTO, false, false, _deeplink, branch));
		}
		private function dispatchDeeplink():void 
		{
			_deeplink = "";
			var validated:String = validate(_value);
			var validBranch:String = SiteModel.routes[validated] || "";
			if (validated.length > 0 || isSinglePage) _deeplink = _value.substring(validated.length, _value.length);
			if (isSinglePage && _deeplink.length > 0) _deeplink = "/" + _deeplink;
			//if (_deeplink.length > 0) GaiaDebug.log("deeplink = " + _deeplink);
			dispatchEvent(new GaiaSWFAddressEvent(GaiaSWFAddressEvent.DEEPLINK, false, false, _deeplink, validBranch));
		}
		private function validate(str:String):String
		{
			var val:String = stripStrictSlashes(str);
			if (SiteModel.routing)
			{
				return BranchTools.getValidRoute(val);
			}
			else
			{
				return BranchTools.getFullBranch(val).split("/").slice(1).join("/");
			}
		}
		private function stripStrictSlashes(str:String = null):String
		{
			if (str == null || str.length == 0) return "";
			if (str.charAt(0) == "/") str = str.substr(1);
			if (str.charAt(str.length - 1) == "/") str = str.substr(0, str.length - 1);
			return str;
		}
		private function insertStrictSlashes(str:String = null):String
		{
			if (str == null || str.length == 0) return "/";
			if (str.charAt(0) != "/") str = "/" + str;
			return str;
		}
	}
}