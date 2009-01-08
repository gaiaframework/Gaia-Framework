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
	import com.gaiaframework.assets.PageAsset;
	import com.asual.swfaddress.SWFAddress;
	
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenu;

	public class GaiaContextMenu
	{
		private static var menu:ContextMenu = new ContextMenu();
		private static var customItems:Array = [];
		private static var gotoHash:Object = {};
		private static var separator:Boolean = false;
		
		public static function init(enable:Boolean):ContextMenu
		{
			menu.hideBuiltInItems();
			customItems = [];
			if (enable)
			{
				gotoHash = {};
				separator = true;
				var title:String = SiteModel.title.split("%PAGE%").join("").split(SiteModel.delimiter).join("");
				var projectName:ContextMenuItem = new ContextMenuItem(title);
				//projectName.enabled = false;
				customItems.push(projectName);
				addCustomMenuItems(SiteModel.menuArray);
			}
			var gaiaLink:ContextMenuItem = new ContextMenuItem("Built with Gaia Framework", true);
			gaiaLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onGaiaClick);
			customItems.push(gaiaLink);
			menu.customItems = customItems;
			return menu;
		}
		private static function addCustomMenuItems(pages:Array):void
		{
			for (var i:int = 0; i < pages.length; i++)
			{
				addPageToMenu(PageAsset(pages[i]));
			}
		}
		private static function addPageToMenu(page:PageAsset):void
		{
			gotoHash[page.title] = page.branch;
			var cmi:ContextMenuItem = new ContextMenuItem(page.title, separator);
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onGoto);
			separator = false;
			customItems.push(cmi);
		}
		private static function onGoto(event:ContextMenuEvent):void
		{
			GaiaHQ.instance.goto(gotoHash[ContextMenuItem(event.target).caption]);
		}
		private static function onGaiaClick(event:ContextMenuEvent):void
		{
			SWFAddress.href("http://www.gaiaflashframework.com/", "_blank");
		}
	}
}