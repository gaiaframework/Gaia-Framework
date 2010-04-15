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

package com.gaiaframework.utils
{
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	
	public class SoundUtils
	{
		private static var transform:SoundTransform = new SoundTransform(1);
		
		public static function fadeTo(target:*, value:Number, duration:Number, onComplete:Function = null):void
		{
			TweenMax.to(target, duration, {volume:value, ease:Linear.easeNone, onComplete:onComplete, overwrite:false});
		}
		public static function panTo(target:*, value:Number, duration:Number, onComplete:Function = null):void
		{
			TweenMax.to(target, duration, {pan:value, ease:Linear.easeNone, onComplete:onComplete, overwrite:false});
		}
		public static function set volume(value:Number):void
		{
			transform.volume = value;
			SoundMixer.soundTransform = transform;
		}
		public static function get volume():Number
		{
			return transform.volume;
		}
	}
}