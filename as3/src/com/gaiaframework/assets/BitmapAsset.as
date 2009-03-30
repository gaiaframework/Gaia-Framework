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
	import com.gaiaframework.api.IBitmap;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class BitmapAsset extends DisplayObjectAsset implements IBitmap
	{
		public function BitmapAsset()
		{
			super();
		}
		public function get content():Bitmap
		{
			return Bitmap(_loader.content);
		}
		public function get pixelSnapping():String
		{
			return Bitmap(_loader.content).pixelSnapping;
		}
		public function set pixelSnapping(value:String):void
		{
			Bitmap(_loader.content).pixelSnapping = value;
		}
		public function get bitmapData():BitmapData
		{
			return Bitmap(_loader.content).bitmapData;
		}
		public function set bitmapData(value:BitmapData):void
		{
			Bitmap(_loader.content).bitmapData = value;
		}		
		public function get smoothing():Boolean
		{
			return Bitmap(_loader.content).smoothing;
		}
		public function set smoothing(value:Boolean):void
		{
			Bitmap(_loader.content).smoothing = value;
		}
		override public function toString():String
		{
			return "[BitmapAsset] " + _id;
		}
	}
}