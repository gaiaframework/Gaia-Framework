/*
VERSION: 1.03
DATE: 1/24/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Base class for all filter plugins (like BlurFilter, colorMatrixFilter, etc.). Handles common routines.
	
USAGE:
	filter plugins extend this class.

	
BYTES ADDED TO SWF: 601 (1kb) (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/
import gs.*;
import gs.plugins.*;
import gs.utils.tween.*;
import flash.filters.*;

class gs.plugins.FilterPlugin extends TweenPlugin {
		public static var VERSION:Number = 1.03;
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		private var _target:Object;
		private var _type:Object;
		private var _filter:BitmapFilter;
		private var _index:Number;
		private var _remove:Boolean;
		
		public function FilterPlugin() {
			super();
		}
		
		private function initFilter($props:Object, $default:BitmapFilter):Void {
			var filters:Array = _target.filters, p:String, i:Number, colorTween:HexColorsPlugin;
			_index = -1;
			if ($props.index != undefined) {
				_index = $props.index;
			} else {
				for (i = filters.length - 1; i > -1; i--) {
					if (filters[i] instanceof _type) {
						_index = i;
						break;
					}
				}
			}
			if (_index == -1 || filters[_index] == undefined || $props.addFilter == true) {
				_index = ($props.index != undefined) ? $props.index : filters.length;
				filters[_index] = $default;
				_target.filters = filters;
			}
			_filter = filters[_index];
			
			_remove = Boolean($props.remove == true);
			if (_remove) {
				this.onComplete = onCompleteTween;
			}
			var props:Object = ($props.isTV == true) ? $props.exposedVars : $props; //accommodates TweenLiteVars and TweenMaxVars
			for (p in props) {
				if (_filter[p] == undefined || _filter[p] == props[p] || p == "remove" || p == "index" || p == "addFilter") {
					//ignore
				} else {
					if (p == "color" || p == "highlightColor" || p == "shadowColor") {
						colorTween = new HexColorsPlugin();
						colorTween.initColor(_filter, p, _filter[p], props[p]);
						_tweens[_tweens.length] = new TweenInfo(colorTween, "changeFactor", 0, 1, this.propName);
					} else if (p == "quality" || p == "inner" || p == "knockout" || p == "hideObject") {
						_filter[p] = props[p];
					} else {
						addTween(_filter, p, _filter[p], props[p], this.propName);
					}
				}
			}
		}
		
		public function onCompleteTween():Void {
			if (_remove) {
				var i:Number, filters:Array = _target.filters;
				if (!(filters[_index] instanceof _type)) { //a filter may have been added or removed since the tween began, changing the index.
					for (i = filters.length - 1; i > -1; i--) {
						if (filters[i] instanceof _type) {
							filters.splice(i, 1);
							break;
						}
					}
				} else {
					filters.splice(_index, 1);
				}
				_target.filters = filters;
			}
		}
		
		public function set changeFactor($n:Number):Void {
			var i:Number, ti:TweenInfo, filters:Array = _target.filters;
			for (i = _tweens.length - 1; i > -1; i--) {
				ti = _tweens[i];
				ti.target[ti.property] = ti.start + (ti.change * $n);
			}
			
			if (!(filters[_index] instanceof _type)) { //a filter may have been added or removed since the tween began, changing the index.
				_index = filters.length - 1; //default (in case it was removed)
				for (i = filters.length - 1; i > -1; i--) {
					if (filters[i] instanceof _type) {
						_index = i;
						break;
					}
				}
			}
			filters[_index] = _filter;
			_target.filters = filters;
		}
		
}