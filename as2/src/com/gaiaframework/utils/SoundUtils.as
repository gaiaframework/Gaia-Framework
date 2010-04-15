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

import com.greensock.easing.Linear;
import com.greensock.TweenMax;

class com.gaiaframework.utils.SoundUtils
{
	private static var globalSound:Sound = new Sound();
	
	public static function fadeTo(target:Object, volume:Number, duration:Number, onComplete:Function):Void
	{
		TweenMax.to(target, duration, {volume:volume, ease:Linear.easeNone, onComplete:onComplete, overwrite:false});
	}
	public static function panTo(target:Object, pan:Number, duration:Number, onComplete:Function):Void
	{
		TweenMax.to(target, duration, {pan:pan, ease:Linear.easeNone, onComplete:onComplete, overwrite:false});
	}
	public static function set volume(value:Number):Void
	{
		globalSound.setVolume(value);
	}
	public static function get volume():Number
	{
		return globalSound.getVolume();
	}
}