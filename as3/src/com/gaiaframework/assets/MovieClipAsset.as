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

package com.gaiaframework.assets
{
	import com.gaiaframework.api.IMovieClip;
	import flash.display.MovieClip;	
	
	public class MovieClipAsset extends SpriteAsset implements IMovieClip
	{
		public function MovieClipAsset()
		{
			super();
		}		
		public function get content():MovieClip
		{
			return MovieClip(_loader.content);
		}
		// PROXY PROPERTIES
		public function get currentFrame():int
		{
			return MovieClip(_loader.content).currentFrame;
		}
		public function get currentLabel():String
		{
			return MovieClip(_loader.content).currentLabel;
		}
		public function get currentLabels():Array
		{
			return MovieClip(_loader.content).currentLabels;
		}
		public function get enabled():Boolean
		{
			return MovieClip(_loader.content).enabled;
		}
		public function set enabled(value:Boolean):void
		{
			MovieClip(_loader.content).enabled = value;
		}
		public function get framesLoaded():int
		{
			return MovieClip(_loader.content).framesLoaded;
		}
		public function get totalFrames():int
		{
			return MovieClip(_loader.content).totalFrames;
		}
		public function get trackAsMenu():Boolean
		{
			return MovieClip(_loader.content).trackAsMenu;
		}
		public function set trackAsMenu(value:Boolean):void
		{
			MovieClip(_loader.content).trackAsMenu = value;
		}
		// PROXY FUNCTIONS
		public function gotoAndPlay(value:Object):void
		{
			MovieClip(_loader.content).gotoAndPlay(value);
		}
		public function gotoAndStop(value:Object):void
		{
			MovieClip(_loader.content).gotoAndStop(value);
		}
		public function play():void
		{
			MovieClip(_loader.content).play();
		}
		public function stop():void
		{
			MovieClip(_loader.content).stop();
		}
		public function nextFrame():void
		{
			MovieClip(_loader.content).nextFrame();
		}
		public function prevFrame():void
		{
			MovieClip(_loader.content).prevFrame();
		}
		override public function toString():String
		{
			return "[MovieClipAsset] " + _id;
		}
	}
}