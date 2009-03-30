/*
VERSION: 1.01
DATE: 2/23/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Some components require resizing with setSize() instead of standard tweens of width/height in
	order to scale properly. The SetSizePlugin accommodates this easily. You can define the width, 
	height, or both.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([SetSizePlugin]); //only do this once in your SWF to activate the plugin
	
	TweenLite.to(myComponent, 1, {setSize:{width:200, height:30}});
	
	
BYTES ADDED TO SWF: 365 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.*;
import gs.plugins.*;

class gs.plugins.SetSizePlugin extends TweenPlugin {
	public static var VERSION:Number = 1.01;
	public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility	
	
	public var width:Number;
	public var height:Number;
	
	private var _target:Object;
	private var _setWidth:Boolean;
	private var _setHeight:Boolean;
	private var _hasSetSize:Boolean;
		
	public function SetSizePlugin() {
		super();
		this.propName = "setSize";
		this.overwriteProps = ["setSize","_width","_height", "_xscale", "_yscale"];
		this.round = true;
	}
	
	public function onInitTween($target:Object, $value:Object, $tween:TweenLite):Boolean {
		if (typeof($target) != "movieclip") { return false; }
		
		_target = $target;
		_hasSetSize = Boolean(_target.setSize != undefined);
		
		if ( ($value.width != undefined ) && _target._width != $value.width) {
			addTween(this, "width", _target._width, $value.width, "_width");
			_setWidth = _hasSetSize;
		}
		if ( ($value.height != undefined ) && _target._height != $value.height) {
			addTween(this, "height", _target._height, $value.height, "_height");
			_setHeight = _hasSetSize;
		}			
		return true;
	}
	
	public function killProps( $lookup:Object ):Void {
		super.killProps($lookup);
		if (_tweens.length == 0 || $lookup.setSize != undefined ) {
			this.overwriteProps = [];
		}
	}
	
	public function set changeFactor($n:Number):Void {
		updateTweens($n);
		_target.setSize((_setWidth) ? this.width : _target._width, (_setHeight) ? this.height : _target._height);
	}
}