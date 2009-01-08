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

import com.gaiaframework.assets.AbstractAsset;
import mx.utils.Delegate;

class com.gaiaframework.assets.NetStreamAsset extends AbstractAsset
{
	private var _ns:NetStream;
	private var _nc:NetConnection;
	private var _metaData:Object;
	
	function NetStreamAsset()
	{
		super();
	}
	public function get ns():NetStream
	{
		return _ns;
	}
	public function init():Void
	{
		isActive = true;
		_nc = new NetConnection();
		_nc.connect(null);
		_ns = new NetStream(_nc);
		_ns.onMetaData = Delegate.create(this, onMetaDataEvent);
	}
	public function preload():Void
	{
		_ns.play(src);
		_ns.pause(true);
		super.load();
	}
	public function load():Void
	{
		_ns.play(src);
	}
	public function destroy():Void
	{
		_ns.close();
		_nc.connect(null);
		delete _ns;
		delete _nc;
		super.destroy();
	}
	public function retry():Void
	{
		_ns.play(src);
		_ns.pause(true);
	}
	public function getBytesLoaded():Number
	{
		return _ns.bytesLoaded || 0;
	}
	public function getBytesTotal():Number
	{
		return _ns.bytesTotal || 0;
	}
	private function onProgress():Void
	{
		super.onProgress();
		if (_ns.bytesLoaded == _ns.bytesTotal && _ns.bytesTotal > 4) onComplete();
	}
	
	// META DATA
	private function onMetaDataEvent(obj:Object):Void 
	{
		_metaData = obj;
	}
	public function get metaData():Object 
	{
		return _metaData;
	}
	public function get duration():Number 
	{
		return _metaData.totalduration || _metaData.duration || 0;
	}
	
	// PROXY FLV PROPS/FUNCS
	public function get bufferLength():Number
	{
		return _ns.bufferLength;
	}
	public function get bufferTime():Number
	{
		return _ns.bufferTime;
	}
	public function get bytesLoaded():Number
	{
		return _ns.bytesLoaded;
	}
	public function get bytesTotal():Number
	{
		return _ns.bytesTotal;
	}
	public function close():Void
	{
		_ns.close();
	}
	public function get currentFps():Number
	{
		return _ns.currentFps;
	}
	public function onMetaData(func:Function):Void
	{
		_ns.onMetaData = func;
	}
	public function onStatus(func:Function):Void
	{
		_ns.onStatus = func;
	}
	public function pause(flag:Boolean):Void
	{
		_ns.pause(flag);
	}
	public function play(start:Number, len:Number):Void
	{
		_ns.play(src, start, len);
	}
	public function seek(offset:Number):Void
	{
		_ns.seek(offset);
	}
	public function setBufferTime(bufferTime:Number):Void
	{
		_ns.setBufferTime(bufferTime);
	}
	public function get time():Number
	{
		return _ns.time;
	}
	public function toString():String
	{
		return "[NetStreamAsset] " + _id;
	}
}