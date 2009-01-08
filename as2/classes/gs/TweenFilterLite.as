/*
VERSION: 9.3
DATE: 12/17/2008
ACTIONSCRIPT VERSION: 2.0 (AS3 version available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenFilterLite.com
DESCRIPTION:
	TweenFilterLite extends the extremely lightweight (3k), powerful TweenLite "core" class, adding the ability to tween filters (like blurs, 
	glows, drop shadows, bevels, etc.) as well as image effects like contrast, colorization, brightness, saturation, hue, and threshold (combined size: 6k). 
	The syntax is identical to the TweenLite class. If you're unfamiliar with TweenLite, I'd highly recommend that you check it out. 
	It provides easy way to tween multiple object properties over time including a MovieClip's position, alpha, volume, color, etc. 
	Just like the TweenLite class, TweenFilterLite allows you to build in a delay, call any function when the tween starts or has completed
	(even passing any number of parameters you define), automatically kill other tweens that are affecting the same object (to avoid conflicts),
	tween numeric arrays, etc. One of the big benefits of this class (and the reason "Lite" is in the name) is that it was carefully built to 
	minimize file size. There are several other Tweening engines out there, but in my experience, they required more than triple the 
	file size which was unacceptable when dealing with strict file size requirements (like banner ads). I haven't been able to find a 
	faster tween engine either. The syntax is simple and the class doesn't rely on complicated prototype alterations that can cause 
	problems with certain compilers. TweenFilterLite is simple, very fast, and extremely lightweight.
	
	If you're looking for more features, check out TweenFilterLite's big brother, TweenMax at www.TweenMax.com

ARGUMENTS:
	1) $target : Object - Target whose properties we're tweening
	2) $duration : Number - Duration (in seconds) of the effect
	3) $vars : Object - An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
					  TweenFilterLite.from() method, these variables would define the BEGINNING values). Pass in one object for each filter
					  (named appropriately, like blurFilter, glowFilter, colorMatrixFilter, etc.) Filter objects can contain any number of
					  properties specific to that filter, like blurX, blurY, contrast, color, distance, colorize, brightness, highlightAlpha, etc. 
		      
		   SPECIAL PROPERTIES: 
			  delay : Number - Amount of delay before the tween should begin (in seconds).
			  ease : Function - You can specify a function to use for the easing with this variable. For example, 
								gs.easing.Elastic.easeOut. The Default is Regular.easeOut.
			  easeParams : Array - An array of extra parameters to feed the easing equation. This can be useful when you 
								   use an equation like Elastic and want to control extra parameters like the amplitude and period.
								   Most easing equations, however, don't require extra parameters so you won't need to pass in any easeParams.
			  autoAlpha : Number - Use it instead of the alpha property to gain the additional feature of toggling 
								   the visible property to false when alpha reaches 0. It will also toggle visible 
								   to true before the tween starts if the value of autoAlpha is greater than zero.
			  _visible : Boolean - To set a MovieClip's _visible property at the end of the tween, use this special property.
			  volume : Number - To change a MovieClip's volume, just set this to the value you'd like the 
								MovieClip to end up at (or begin at if you're using TweenFilterLite.from()).
			  tint : Number - To change a MovieClip's tint/color, set this to the hex value of the tint you'd like
							  to end up at(or begin at if you're using TweenFilterLite.from()). An example hex value would be 0xFF0000. 
			  removeTint : Boolean - If you'd like to remove the tint that's applied to a MovieClip, pass true for this special property.
			  frame : Number - Use this to tween a MovieClip to a particular frame.
			  onStart : Function - If you'd like to call a function as soon as the tween begins, pass in a reference to it here.
								   This is useful for when there's a delay. 
			  onStartParams : Array - An array of parameters to pass the onStart function. (this is optional)
			  onStartScope : Object - Use this to define the scope of the onStart function.
			  onUpdate : Function - If you'd like to call a function every time the property values are updated (on every frame during
									the time the tween is active), pass a reference to it here.
			  onUpdateParams : Array - An array of parameters to pass the onUpdate function (this is optional)
			  onUpdateScope : Object - Use this to define the scope of the onUpdate function.
			  onComplete : Function - If you'd like to call a function when the tween has finished, use this. 
			  onCompleteParams : Array - An array of parameters to pass the onComplete function (this is optional)
			  onCompleteScope : Object - Use this to define the scope of the onComplete function.
			  persist : Boolean - if true, the TweenLite instance will NOT automatically be removed by the garbage collector when it is complete.
					  			  However, it is still eligible to be overwritten by new tweens even if persist is true. By default, it is false.
			  renderOnStart : Boolean - If you're using TweenFilterLite.from() with a delay and want to prevent the tween from rendering until it
										actually begins, set this to true. By default, it's false which causes TweenFilterLite.from() to render
										its values immediately, even before the delay has expired.
			  timeScale : Number - Multiplier that controls the speed of the tween (perceived duration) where 1 = normal speed, 0.5 = half speed, 2 = double speed, etc. 
			  					   NOTE: There is also a static TweenFilterLite.globalTimeScale property that affects ALL TweenMax and TweenFilterLite tweens (not TweenLite though)
			  roundProps : Array - If you'd like the inbetween values in a tween to always get rounded to the nearest integer, use the roundProps
			  					   special property. Just pass in an Array containing the property names that you'd like rounded. For example,
			  					   if you're tweening the _x, _y, and _alpha properties of mc and you want to round the _x and _y values (not _alpha)
			  					   every time the tween is rendered, you'd do: TweenFilterLite.to(mc, 2, {_x:300, _y:200, _alpha:50, roundProps:["_x","_y"]});
			  overwrite : Number - Controls how other tweens of the same object are handled when this tween is created. Here are the options:
				  					- 0 (NONE): No tweens are overwritten. This is the fastest mode, but you need to be careful not to create any 
				  								tweens with overlapping properties, otherwise they'll conflict with each other. 
												
									- 1 (ALL): (this is the default unless OverwriteManager.init() has been called) All tweens of the same object 
											   are completely overwritten immediately when the tween is created. 
											   		TweenLite.to(mc, 1, {_x:100, _y:200});
													TweenLite.to(mc, 1, {_x:300, delay:2, overwrite:1}); //immediately overwrites the previous tween
													
									- 2 (AUTO): (used by default if OverwriteManager.init() has been called) Searches for and overwrites only 
												individual overlapping properties in tweens that are active when the tween begins. 
													TweenLite.to(mc, 1, {_x:100, _y:200});
													TweenLite.to(mc, 1, {_x:300, overwrite:2}); //only overwrites the "x" property in the previous tween
													
									- 3 (CONCURRENT): Overwrites all tweens of the same object that are active when the tween begins.
													  TweenLite.to(mc, 1, {_x:100, _y:200});
													  TweenLite.to(mc, 1, {_x:300, delay:2, overwrite:3}); //does NOT overwrite the previous tween because the first tween will have finished by the time this one begins.
			  
			  blurFilter : Object - To apply a BlurFilter, pass an object with one or more of the following properties:
								    blurX, blurY, quality
			  glowFilter : Object - To apply a GlowFilter, pass an object with one or more of the following properties:
			  						alpha, blurX, blurY, color, strength, quality, inner, knockout
			  colorMatrixFilter : Object - To apply a ColorMatrixFilter, pass an object with one or more of the following properties:
										   colorize, amount, contrast, brightness, saturation, hue, threshold, relative, matrix
			  dropShadowFilter : Object - To apply a ColorMatrixFilter, pass an object with one or more of the following properties:
										  alpha, angle, blurX, blurY, color, distance, strength, quality
			  bevelFilter : Object - To apply a BevelFilter, pass an object with one or more of the following properties:
									 angle, blurX, blurY, distance, highlightAlpha, highlightColor, shadowAlpha, shadowColor, strength, quality
	

EXAMPLES: 
	As a simple example, you could tween the blur of clip_mc from where it's at now to 20 over the course of 1.5 seconds by:
	
		gs.TweenFilterLite.to(clip_mc, 1.5, {blurFilter:{blurX:20, blurY:20}});
		
	To set up a sequence where we colorize a MovieClip red over the course of 2 seconds, and then blur it over the course of 1 second,:
	
		import gs.TweenFilterLite;
		TweenFilterLite.to(clip_mc, 2, {colorMatrixFilter:{colorize:0xFF0000, amount:1}});
		TweenFilterLite.to(clip_mc, 1, {blurFilter:{blurX:20, blurY:20}, delay:2, overwrite:false});
	
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the saturation to 0, 
	delay starting the whole tween by 2 seconds, and then call a function named "onFinishTween" when it has 
	completed and pass in a few arguments to that function (a value of 5 and a reference to the clip_mc), you'd 
	do so like:
		
		import gs.TweenFilterLite;
		import gs.easing.Back;
		TweenFilterLite.to(clip_mc, 5, {colorMatrixFilter:{saturation:0}, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1:Number, argument2:MovieClip):Void {
			trace("The tween has finished! argument1 = " + argument1 + ", and argument2 = " + argument2);
		}
	
	If you have a MovieClip on the stage that already has the properties you'd like to end at, and you'd like to 
	start with a colorized version (red: 0xFF0000) and tween to the current properties, you could:
		
		import gs.TweenFilterLite;
		TweenFilterLite.from(clip_mc, 5, {colorMatrixFilter:{colorize:0xFF0000}});		
	

NOTES:
	- This class (along with the TweenLite class which it extends) will add about 6kb to your Flash file.
	- Requires that you target Flash 8 Player or later.
	- Quality defaults to a level of "2" for all filters, but you can pass in a value to override it.
	- The image filter (colorMatrixFilter) functions were built so that you can leverage this class to manipulate matrixes for the
	  ColorMatrixFilter by calling the static functions directly (so you don't necessarily have to be tweening 
	  anything). For example, you could colorize a matrix by:
	  var myNewMatrix:Array = TweenFilterLite.colorize(myOldMatrix, 0xFF0000, 100);
	  
	  
CHANGE LOG:
	9.3:
		- Added compatibility with TweenProxy
	9.291:
		- Adjusted how the timeScale special property is handled internally. It should be more flexible and slightly faster now.
	9.29:
		- Minor speed enhancement
	9.26:
		- Speed improvement and slight file size decrease
	9.24:
		- Fixed bug with autoAlpha tweens working with TweenGroups when they're reversed.
	9.2:
		- Added "roundProps" special property for rounding values
	9.11:
		- Fixed bug with timeScale
	9.1:
		- In AUTO or CONCURRENT mode, OverwriteManager doesn't handle overwriting until the tween actually begins which allows for immediate pause()-ing or re-ordering in TweenGroup, etc.
		- Re-architected some inner-workings to further optimize for speed and reduce file size
	9.03:
		- Fixed bug with from()
		- Fixed bug with timeScale
	9.0:
		- Made compatible with the new TweenGroup class (see http://blog.greensock.com/tweengroup/ for details) which allows for sequencing and much more
		- Added clear() method
		- Added a "clear" parameter to the removeTween() method
		- Exposed TweenLite.currentTime as well as several other TweenLite variables for compatibility with TweenGroup
	8.21:
		- Fixed issue with using TweenFilterLite or TweenMax to tween the timeScale of another TweenFilterLite/TweenMax instance
	8.2:
		- Added setGlobalTimeScale() function to control the speed of all TweenFilterLite and TweenMax instances
		- Added static "globalTimeScale" property to TweenMax and TweenFilterLite classes. You can even tween it like TweenLite.to(TweenFilterLite, 1, {globalTimeScale:0.5});
		- Changed timeScale so that it also affects the delay (if any)
	8.15:
		- Fixed bug in overwrite management
		- Fixed bug with tweens that have a zero-length duration
	8.12:
		- Fixed bug in timeScale
	8.1:
		- Added timeScale special property
	8.05:
		- Added the ability to overwrite only individual overlapping properties with the new OverwriteManager class and "autoOverwrite" special property
		- Added the killVars() method
	7.3:
		- Added "persist" special property.
		- Added "removeTint" special property
	7.2:
		- Added "_visible" special property.
	7.1:
		- Enhanced speed
	7.04:
		- Added ability to define a "matrix" property for colorMatrixFilters.
	7.02:
		- Worked around bug in Flash that caused problems when tweening two objects with the same filter simultaneously (one would "contaminate" the other)
	7.0:
		- SIGNIFICANT: Changed the syntax for defining filters. OLD: TweenFilterLite.to(mc, 2, {type:"blur", blurX:20, blurY:20}), NEW: TweenFilterLite.to(mc, 2, {blurFilter:{blurX:20, blurY:20}})

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

import flash.filters.*;

import gs.*;

class gs.TweenFilterLite extends TweenLite {
	public static var version:Number = 9.3;
	public static var delayedCall:Function = TweenLite.delayedCall; 
	public static var killTweensOf:Function = TweenLite.killTweensOf; 
	public static var killDelayedCallsTo:Function = TweenLite.killTweensOf; 
	private static var _globalTimeScale:Number = 1;
	private static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
	private static var _lumR:Number = 0.212671; //Red constant - used for a few color matrix filter functions
	private static var _lumG:Number = 0.715160; //Green constant - used for a few color matrix filter functions
	private static var _lumB:Number = 0.072169; //Blue constant - used for a few color matrix filter functions
	private var _matrix:Array;
	private var _endMatrix:Array;
	private var _cmf:ColorMatrixFilter;
	private var _clrsa:Array; //Array that pertains to any color properties (like "color", "highlightColor", "shadowColor", etc.)
	private var _hf:Boolean = false; //Has filters
	private var _filters:Array; //Contains objects, one for each filter that's being tweened. Each object contains the following properties: filter, type
	private var _timeScale:Number; //Allows you to speed up or slow down a tween. Default is 1 (normal speed) 0.5 would be half-speed
	private var _roundProps:Boolean;
	
	public function TweenFilterLite($target:Object, $duration:Number, $vars:Object) {
		super($target, $duration, $vars);
		if (this.combinedTimeScale != 1 && this.target instanceof TweenFilterLite) { //in case the user is trying to tween the timeScale of another TweenFilterLite/TweenMax instance
			_timeScale = 1;
			this.combinedTimeScale = _globalTimeScale;
		} else {
			_timeScale = this.combinedTimeScale;
			this.combinedTimeScale *= _globalTimeScale; //combining them speeds processing in important functions like render().
		}
		if (this.combinedTimeScale != 1 && this.delay != 0) {
			this.startTime = this.initTime + (this.delay * (1000 / this.combinedTimeScale));
		}
		if (TweenLite.version < 9.3) {
			trace("TweenFilterLite error: Please update your TweenLite class or try clearing your ASO files. TweenFilterLite requires a more recent version. Download updates at http://www.TweenLite.com.");
		}
	}
	
	public static function to($target:Object, $duration:Number, $vars:Object):TweenFilterLite {
		return new TweenFilterLite($target, $duration, $vars);
	}
	
	public static function from($target:Object, $duration:Number, $vars:Object):TweenFilterLite {
		$vars.runBackwards = true;
		return new TweenFilterLite($target, $duration, $vars);;
	}
	
	public function initTweenVals($hrp:Boolean, $reservedProps:String):Void {
		if ($hrp != true && TweenLite.overwriteManager.enabled) {
			TweenLite.overwriteManager.manageOverwrites(this, masterList[this.endTargetID].tweens);
		}
		_clrsa = [];
		_filters = [];
		_matrix = _idMatrix.slice();
		$reservedProps = $reservedProps || "";
		$reservedProps += " blurFilter glowFilter colorMatrixFilter dropShadowFilter bevelFilter roundProps timeScale ";
		if (this.vars.timeScale != undefined && this.target.timeScale != undefined) {
			this.tweens[this.tweens.length] = [this.target, "timeScale", this.target.timeScale, this.vars.timeScale - this.target.timeScale, "timeScale"]; //[object, property, start, change, name]
		}
		_roundProps = Boolean(this.vars.roundProps instanceof Array);
		var i:Number, fv:Object; //filter vars
		if (typeof(this.target) == "movieclip" || this.target instanceof TextField || this.target.isTweenProxy) {
			if (this.vars.blurFilter != undefined) {
				fv = this.vars.blurFilter;
				addFilter("blurFilter", fv, BlurFilter, ["blurX", "blurY", "quality"], new BlurFilter(0, 0, fv.quality || 2));
			}
			if (this.vars.glowFilter != undefined) {
				fv = this.vars.glowFilter;
				addFilter("glowFilter", fv, GlowFilter, ["alpha", "blurX", "blurY", "color", "quality", "strength", "inner", "knockout"], new GlowFilter(0xFFFFFF, 0, 0, 0, fv.strength || 1, fv.quality || 2, fv.inner, fv.knockout));
			}
			if (this.vars.colorMatrixFilter != undefined) {
				fv = this.vars.colorMatrixFilter;
				var cmf:Object = addFilter("colorMatrixFilter", fv, ColorMatrixFilter, [], new ColorMatrixFilter(_matrix));
				_cmf = cmf.filter;
				_matrix = _cmf.matrix;
				if (fv.matrix != undefined && fv.matrix instanceof Array) {
					_endMatrix = fv.matrix;
				} else {
					if (fv.relative == true) {
						_endMatrix = _matrix.slice();
					} else {
						_endMatrix = _idMatrix.slice();
					}
					_endMatrix = setBrightness(_endMatrix, fv.brightness);
					_endMatrix = setContrast(_endMatrix, fv.contrast);
					_endMatrix = setHue(_endMatrix, fv.hue);
					_endMatrix = setSaturation(_endMatrix, fv.saturation);
					_endMatrix = setThreshold(_endMatrix, fv.threshold);
					if (!isNaN(fv.colorize)) {
						_endMatrix = colorize(_endMatrix, fv.colorize, fv.amount);
					} else if (!isNaN(fv.color)) { //Just in case they define "color" instead of "colorize"
						_endMatrix = colorize(_endMatrix, fv.color, fv.amount);
					}
				}
				for (i = 0; i < _endMatrix.length; i++) {
					if (_matrix[i] != _endMatrix[i] && _matrix[i] != undefined) {
						this.tweens[this.tweens.length] = [_matrix, i.toString(), _matrix[i], _endMatrix[i] - _matrix[i], "colorMatrixFilter"]; //[object, property, start, change, name]
					}
				}
			}
			if (this.vars.dropShadowFilter != undefined) {
				fv = this.vars.dropShadowFilter;
				addFilter("dropShadowFilter", fv, DropShadowFilter, ["alpha", "angle", "blurX", "blurY", "color", "distance", "quality", "strength", "inner", "knockout", "hideObject"], new DropShadowFilter(0, 45, 0x000000, 0, 0, 0, 1, fv.quality || 2, fv.inner, fv.knockout, fv.hideObject));
			}
			if (this.vars.bevelFilter != undefined) {
				fv = this.vars.bevelFilter;
				addFilter("bevelFilter", fv, BevelFilter, ["angle", "blurX", "blurY", "distance", "highlightAlpha", "highlightColor", "quality", "shadowAlpha", "shadowColor", "strength"], new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0x000000, 0.5, 2, 2, 0, fv.quality || 2));
			}
			if (this.vars.runBackwards == true) {
				var tp:Object;
				for (i = 0; i < _clrsa.length; i++) {
					tp = _clrsa[i];
					tp.sr += tp.cr;
					tp.cr *= -1;
					tp.sg += tp.cg;
					tp.cg *= -1;
					tp.sb += tp.cb;
					tp.cb *= -1;
					tp.f[tp.p] = (tp.sr << 16 | tp.sg << 8 | tp.sb); //Translates RGB to HEX
				}
			}
			super.initTweenVals(true, $reservedProps);
		} else {
			super.initTweenVals($hrp, $reservedProps);
		}
		
		if (_roundProps) {
			var j:Number, prop:String;
			for (i = this.vars.roundProps.length - 1; i > -1; i--) {
				prop = this.vars.roundProps[i];
				for (j = this.tweens.length - 1; j > -1; j--) {
					if (this.tweens[j][1] == prop && this.tweens[j][0] == this.target) {
						this.tweens[j][5] = true; //flags it for rounding
						break;
					}
				}
			}
		}
	}
	
	private function addFilter($name:String, $fv:Object, $filterType:Object, $props:Array, $defaultFilter:Object):Object {
		var f:Object = {type:$filterType, name:$name}, fltrs:Array = this.target.filters, i:Number, prop:String, valChange:Number, begin:Object, end:Object;
		for (i = 0; i < fltrs.length; i++) {
			if (fltrs[i] instanceof $filterType) {
				f.filter = fltrs[i];
				break;
			}
		}
		if (f.filter == undefined) {
			f.filter = $defaultFilter;
			fltrs[fltrs.length] = f.filter;
			this.target.filters = fltrs;
		}
		for (i = 0; i < $props.length; i++) {
			prop = $props[i];
			if ($fv[prop] != undefined) {
				if (prop == "color" || prop == "highlightColor" || prop == "shadowColor") {
					begin = HEXtoRGB(f.filter[prop]);
					end = HEXtoRGB($fv[prop]);
					_clrsa[_clrsa.length] = {f:f.filter, p:prop, sr:begin.rb, cr:end.rb - begin.rb, sg:begin.gb, cg:end.gb - begin.gb, sb:begin.bb, cb:end.bb - begin.bb};
				} else if (prop == "quality" || prop == "inner" || prop == "knockout" || prop == "hideObject") {
					f.filter[prop] = $fv[prop];
				} else {
					if (typeof($fv[prop]) == "number") {
						valChange = $fv[prop] - f.filter[prop];
					} else {
						valChange = Number($fv[prop]);
					}
					this.tweens[this.tweens.length] = [f.filter, prop, f.filter[prop], valChange, $name];
				}
			}
		}
		_filters[_filters.length] = f;
		_hf = true;
		return f;
	}
	
	public function render($t:Number):Void {
		var time:Number = ($t - this.startTime) * 0.001 * this.combinedTimeScale, factor:Number, tp:Object, i:Number;
		if (time >= this.duration) {
			time = this.duration;
			factor = (this.ease == this.vars.ease || this.duration == 0.001) ? 1 : 0; //to accommodate TweenMax.reverse(). Without this, the last frame would render incorrectly
		} else {
			factor = this.ease(time, 0, 1, this.duration);
		}
		
		if (!_roundProps) {
			for (i = this.tweens.length - 1; i > -1; i--) {
				tp = this.tweens[i];
				tp[0][tp[1]] = tp[2] + (factor * tp[3]); //tween index values [object, property, start, change, name]
			}
		} else { //we could use this as the main loop, but in order to optimize for speed (and since most tweens don't require rounding), I separated a more streamlined rendering loop above for non-rounding.
			for (i = this.tweens.length - 1; i > -1; i--) {
				tp = this.tweens[i];
				if (tp[5]) { //round!
					tp[0][tp[1]] = Math.round(tp[2] + (factor * tp[3])); //tween index values [object, property, start, change, name]
				} else { //don't round
					tp[0][tp[1]] = tp[2] + (factor * tp[3]); //tween index values [object, property, start, change, name]
				}
			}
		}
		
		if (_hf) { //has filters
			var j:Number, r:Number, g:Number, b:Number;
			for (i = _clrsa.length - 1; i > -1; i--) {
				tp = _clrsa[i];
				r = tp.sr + (factor * tp.cr);
				g = tp.sg + (factor * tp.cg);
				b = tp.sb + (factor * tp.cb);
				tp.f[tp.p] = (r << 16 | g << 8 | b); //Translates RGB to HEX
			}
			if (_cmf) {
				_cmf.matrix = _matrix;
			}
			var f:Array = this.target.filters;
			for (i = 0; i < _filters.length; i++) {
				for (j = f.length - 1; j > -1; j--) {
					if (f[j] instanceof _filters[i].type) {
						f.splice(j, 1, _filters[i].filter);
						break;
					}
				}
			}
			this.target.filters = f;
		}
		if (_hst) { //has sub-tweens
			for (i = _subTweens.length - 1; i > -1; i--) {
				_subTweens[i].proxy(_subTweens[i], time);
			}
		}
		if (_hasUpdate) {
			this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
		}
		if (time == this.duration) { //Check to see if we're done
			complete(true);
		}
	}
	
	public function killVars($vars:Object):Void {
		if (TweenLite.overwriteManager.enabled) {
			TweenLite.overwriteManager.killVars($vars, this.vars, this.tweens, _subTweens, _filters || []);
		}
	}
	
		
//---- STATIC FUNCTIONS -----------------------------------------------------------------------------------------------------------------------------------

	public static function setGlobalTimeScale($scale:Number):Void {
		if ($scale < 0.00001) {
			$scale = 0.00001;
		}
		var ml:Object = masterList, p:String, i:Number, a:Array;
		_globalTimeScale = $scale;
		for (p in ml) {
			a = ml[p].tweens;
			for (i = a.length - 1; i > -1; i--) {
				if (a[i] instanceof TweenFilterLite) {
					a[i].timeScale *= 1; //just forces combining of the _timeScale and _globalTimeScale.
				}
			}
		}
	}
		
	public function HEXtoRGB($n:Number):Object {
		return {rb:$n >> 16, gb:($n >> 8) & 0xff, bb:$n & 0xff};
	}
	
	
//---- COLOR MATRIX FILTER FUNCTIONS ---------------------------------------------------------------------------
	
	public static function colorize($m:Array, $color:Number, $amount:Number):Array { //You can use 
		if ($color == undefined || isNaN($color)) {
			return $m;
		}
		if ($amount == undefined) {
			$amount = 1;
		}
		var r:Number = (($color >> 16) & 0xff) / 255;
		var g:Number = (($color >> 8)  & 0xff) / 255;
		var b:Number = ($color         & 0xff) / 255;
		var inv:Number = 1 - $amount;
		var temp:Array = [inv + $amount * r * _lumR, $amount * r * _lumG,       	$amount * r * _lumB,       0, 0,
						  $amount * g * _lumR,       inv + $amount * g * _lumG, 	$amount * g * _lumB,       0, 0,
						  $amount * b * _lumR,       $amount * b * _lumG,       	inv + $amount * b * _lumB, 0, 0,
						  0, 				         0, 					     	0, 					       1, 0];		
		return applyMatrix(temp, $m);
	}
	
	public static function setThreshold($m:Array, $n:Number):Array {
		if ($n == undefined || isNaN($n)) {
			return $m;
		}
		var temp:Array = [_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * $n, 
					_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * $n, 
					_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * $n, 
					0,           0,           0,           1,  0]; 
		return applyMatrix(temp, $m);
	}
	
	public static function setHue($m:Array, $n:Number):Array {
		if ($n == undefined || isNaN($n)) {
			return $m;
		}
		$n *= Math.PI / 180;
		var c:Number = Math.cos($n);
		var s:Number = Math.sin($n);
		var temp:Array = [(_lumR + (c * (1 - _lumR))) + (s * (-_lumR)), (_lumG + (c * (-_lumG))) + (s * (-_lumG)), (_lumB + (c * (-_lumB))) + (s * (1 - _lumB)), 0, 0, (_lumR + (c * (-_lumR))) + (s * 0.143), (_lumG + (c * (1 - _lumG))) + (s * 0.14), (_lumB + (c * (-_lumB))) + (s * -0.283), 0, 0, (_lumR + (c * (-_lumR))) + (s * (-(1 - _lumR))), (_lumG + (c * (-_lumG))) + (s * _lumG), (_lumB + (c * (1 - _lumB))) + (s * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
		return applyMatrix(temp, $m);
	}
	
	public static function setBrightness($m:Array, $n:Number):Array {
		if ($n == undefined || isNaN($n)) {
			return $m;
		}
		$n = ($n * 100) - 100;
		return applyMatrix([1,0,0,0,$n,
							0,1,0,0,$n,
							0,0,1,0,$n,
							0,0,0,1,0,
							0,0,0,0,1], $m);
	}
	
	public static function setSaturation($m:Array, $n:Number):Array {
		if ($n == undefined || isNaN($n)) {
			return $m;
		}
		var inv:Number = 1 - $n;
	    var r:Number = inv * _lumR;
		var g:Number = inv * _lumG;
		var b:Number = inv * _lumB;
		var temp:Array = [r + $n, g     , b     , 0, 0,
					r     , g + $n, b     , 0, 0,
					r     , g     , b + $n, 0, 0,
					0     , 0     , 0     , 1, 0];
		return applyMatrix(temp, $m);
	}
	
	public static function setContrast($m:Array, $n:Number):Array {
		if ($n == undefined || isNaN($n)) {
			return $m;
		}
		$n += 0.01;
		var temp:Array =  [$n,0,0,0,128 * (1 - $n),
					 	   0,$n,0,0,128 * (1 - $n),
					 	   0,0,$n,0,128 * (1 - $n),
						   0,0,0,1,0];
		return applyMatrix(temp, $m);
	}
	
	public static function applyMatrix($m:Array, $m2:Array):Array {
		if ($m == undefined || !($m instanceof Array) || $m2 == undefined || !($m2 instanceof Array)) {
			return $m2;
		}
		var temp:Array = [];
		var i:Number = 0;
		var z:Number = 0;
		var y:Number, x:Number;
		for (y = 0; y < 4; y++) {
			for (x = 0; x < 5; x++) {
				if (x == 4) {
					z = $m[i + 4];
				} else {
					z = 0;
				}
				temp[i + x] = $m[i]   * $m2[x]      + 
							  $m[i+1] * $m2[x + 5]  + 
							  $m[i+2] * $m2[x + 10] + 
							  $m[i+3] * $m2[x + 15] +
							  z;
			}
			i += 5;
		}
		return temp;
	}

	
//---- GETTERS / SETTERS ------------------------------------------------------------------------------------------------
	
	public function get timeScale():Number {
		return _timeScale;
	}
	public function set timeScale($n:Number):Void {
		if ($n < 0.00001) {
			$n = _timeScale = 0.00001;
		} else {
			_timeScale = $n;
			$n *= _globalTimeScale; //instead of doing _timeScale * _globalTimeScale in the render() and elsewhere, we improve performance by combining them here.
		}
		this.initTime = currentTime - ((currentTime - this.initTime - (this.delay * (1000 / this.combinedTimeScale))) * this.combinedTimeScale * (1 / $n)) - (this.delay * (1000 / $n));
		if (this.startTime != 999999999999999) { //required for OverwriteManager (indicates a TweenMax instance that has been paused)
			this.startTime = this.initTime + (this.delay * (1000 / $n));
		}
		this.combinedTimeScale = $n;
	}
	public function set enabled($b:Boolean):Void {
		super.enabled = $b;
		if ($b) {
			this.combinedTimeScale = _timeScale * _globalTimeScale;
		}
	}
	public static function set globalTimeScale($n:Number):Void {
		setGlobalTimeScale($n);
	}
	public static function get globalTimeScale():Number {
		return _globalTimeScale;
	}
	
}