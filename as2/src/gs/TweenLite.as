/*
VERSION: 9.3
DATE: 12/17/2008
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenLite.com 
DESCRIPTION:
	Tweening. We all do it. Most of us have learned to avoid Adobe's Tween class in favor of a more powerful engine
	that requires less coding (Tweener, Fuse, MC Tween, etc.). Each has its own strengths & weaknesses. A few years back, 
	I created TweenLite because I needed a very compact tweening engine that was fast and efficient (I couldn't 
	afford the file size bloat that came with the other tweening engines). It quickly became integral to my work 
	flow. I figured others might be able to benefit from it, so I released it publicly. Over the past few years, 
	TweenLite has grown more popular than I could have imagined.

	Since then, I've added new capabilities while trying to keep file size way down (3K). TweenFilterLite extends 
	TweenLite and adds the ability to tween filters including ColorMatrixFilter effects like saturation, contrast, 
	brightness, hue, and even colorization but it only adds about 3k to the file size. Same syntax as TweenLite. 
	There are AS2 and AS3 versions of both of the classes ready for download. TweenMax adds even more features to 
	TweenFilterLite including bezier tweening, pause/resume, sequencing, and much more. (see www.TweenMax.com)

	I know what you're thinking - "if it's so 'lightweight', it's probably missing a lot of features which makes 
	me nervous about using it as my main tweening engine." It is true that it doesn't have the same feature set 
	as some other tweening engines, but I can honestly say that after using it on almost every project I've worked 
	on over the last few years (many award-winning flash apps for fortune-500 companies), it has never let me down. 
	I never found myself needing some other functionality. You can tween any property (including a MovieClip's 
	volume and color), use any easing function, build in delays, callback functions, pass arguments to that 
	callback function, and even tween arrays all with one line of code. If you need more features, you can always 
	step up to TweenFilterLite or TweenMax.

	I haven't been able to find a faster tween engine either. The syntax is simple and the class doesn't rely 
	on complicated prototype alterations that can cause problems with certain compilers. TweenLite is simple, 
	very fast, and more lightweight than any other popular tweening engine. See an interactive speed comparison 
	of various tweening engines at http://blog.greensock.com/tweening-speed-test/.


PARAMETERS:
	1) $target : Object - Target MovieClip (or other object) whose properties we're tweening
	2) $duration : Number - Duration (in seconds) of the tween
	3) $vars : Object - An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
	          			TweenLite.from() method, these variables would define the BEGINNING values). For example:
						  _alpha: The alpha (opacity level) that the target object should finish at (or begin at if you're 
								  using TweenLite.from()). For example, if the target._alpha is 100 when this script is 
								  called, and you specify this argument to be 50, it'll transition from 100 to 50.
						  _x: To change a MovieClip's x position, just set this to the value you'd like the MovieClip to 
							  end up at (or begin at if you're using TweenLite.from()). 
			  SPECIAL PROPERTIES (OPTIONAL):
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
				  				    MovieClip to end up at (or begin at if you're using TweenLite.from()).
				  tint : Number - To change a MovieClip's tint/color, set this to the hex value of the tint you'd like
								  to end up at(or begin at if you're using TweenLite.from()). An example hex value would be 0xFF0000. 
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
											actually begins, set this to true. By default, it's false which causes TweenLite.from() to render
											its values immediately, even before the delay has expired.
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


EXAMPLES: 
	As a simple example, you could tween the _alpha to 50% and move the _x position of a MovieClip named "clip_mc" 
	to 120 and fade the volume to 0 over the course of 1.5 seconds like so:
	
		import gs.TweenLite;
		TweenLite.to(clip_mc, 1.5, {_alpha:50, _x:120, volume:0});
		
	To set up a sequence where we fade a MovieClip to 50% opacity over the course of 2 seconds, and then slide it down
	to _y coordinate 300 over the course of 1 second:
	
		import gs.TweenLite;
		TweenLite.to(clip_mc, 2, {_alpha:50});
		TweenLite.to(clip_mc, 1, {_y:300, delay:2, overwrite:false});
	
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the _alpha to 50%, 
	the _x to 120 using the "easeOutBack" easing function, delay starting the whole tween by 2 seconds, and then call
	a function named "onFinishTween" when it has completed and pass in a few parameters to that function (a value of
	5 and a reference to the clip_mc), you'd do so like:
		
		import gs.TweenLite;
		import gs.easing.Back;
		TweenLite.to(clip_mc, 5, {_alpha:50, _x:120, ease:Back.easeOut, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1:Number, argument2:MovieClip):Void {
			trace("The tween has finished! argument1 = " + argument1 + ", and argument2 = " + argument2);
		}
	
	If you have a MovieClip on the stage that is already in it's end position and you just want to animate it into 
	place over 5 seconds (drop it into place by changing its _y property to 100 pixels higher on the screen and 
	dropping it from there), you could:
		
		import gs.TweenLite;
		import gs.easing.Elastic;
		TweenLite.from(clip_mc, 5, {_y:"-100", ease:Elastic.easeOut});		
	

NOTES:
	- This class will add about 3kb to your Flash file.
	- Putting quotes around values will make the tween relative to the current value. For example, if you do
	  TweenLite.to(mc, 2, {x:"-20"}); it'll move the mc.x to the left 20 pixels which is the same as doing
	  TweenLite.to(mc, 2, {x:mc.x - 20});
	- You can change the TweenLite.defaultEase if you prefer something other than Regular.easeOut.
	- You can tween the volume of any MovieClip using the tween property "volume", like:
	  TweenLite.to(myClip_mc, 1.5, {volume:0});
	- You can tween the color of a MovieClip using the tween property "tint", like:
	  TweenLite.to(myClip_mc, 1.5, {tint:0xFF0000});
	- To tween an array, just pass in an array as a property (it doesn't matter what you name it) like:
	  var myArray:Array = [1,2,3,4];
	  TweenLite.to(myArray, 1.5, {endArray:[10,20,30,40]});
	- You can kill all tweens for a particular object (usually a MovieClip) anytime with the 
	  TweenLite.killTweensOf(myClip_mc); function. If you want to have the tweens forced to completion, 
	  pass true as the second parameter, like TweenLite.killTweensOf(myClip_mc, true);
	- You can kill all delayedCalls to a particular function using TweenLite.killDelayedCallsTo(myFunction_func);
	  This can be helpful if you want to preempt a call.
	- Use the TweenLite.from() method to animate things into place. For example, if you have things set up on 
	  the stage in the spot where they should end up, and you just want to animate them into place, you can 
	  pass in the beginning _x and/or _y and/or _alpha (or whatever properties you want).
	  
	  
CHANGE LOG:
	9.3:
		- Added compatibility with TweenProxy
	9.291:
		- Adjusted how the timeScale special property is handled internally. It should be more flexible and slightly faster now.
	9.29:
		- Minor speed enhancement
	9.27:
		- Fixed easeParams
	9.26:
		- Speed improvement and slight file size decrease
	9.25:
		- Fixed bug with autoAlpha tweens working with TweenGroups when they're reversed.
	9.22:
		- Fixed bug with from() when used in a TweenGroup
	9.1:
		- In AUTO or CONCURRENT mode, OverwriteManager doesn't handle overwriting until the tween actually begins which allows for immediate pause()-ing or re-ordering in TweenGroup, etc.
		- Re-architected some inner-workings to further optimize for speed and reduce file size
	9.04:
		- Fixed bug with from()
		- Fixed bug with timeScale
	9.0:
		- Made compatible with the new TweenGroup class (see http://blog.greensock.com/tweengroup/ for details) which allows for sequencing and much more
		- Added clear() method
		- Added a "clear" parameter to the removeTween() method
		- Exposed TweenLite.currentTime as well as several other variables for compatibility with TweenGroup
	8.16:
		- Fixed bug that prevented using another tween to gradually change the timeScale of a tween
	8.15:
		- Fixed bug that caused from() delays not to function since version 8.14
	8.14:
		- Fixed bug in overwrite management
	8.1:
		- Added timeScale special property
	8.02: 
		- Added the ability to overwrite only individual overlapping properties with the new OverwriteManager class
		- Added the killVars() method
	7.01:
		- Speed optimizations
	7.0:
		- Added "persist" special property
		- Added "removeTint" special property (please use this instead of tint:null)
	6.34:
		- Fixed an issue where tweens could stop if the playhead on the main timeline backs up.
	6.3: 
		- Added "_visible" special property
	6.2:
		- Enhanced speed and changed the "tweens" property from an Object to an Array
	6.13:
		- Fixed potential problem with the complete() method that could prevent a tween from completing.
	6.1:
		- Ensured that even thousands of tweens are synced (uses an internally-controlled timer)
		- Removed support for mcColor (in favor of "tint")
	6.08:
		- Fixed potential problem with tweens not functioning if/when you go BACKWARDS on the timeline.
	6.07:
		- Fixed problem with tweening _alpha and tint at the same time.
	6.06:
		- Fixed problem that could prevent tweens from working properly when subloading SWFs across domains
	6.05:
		- Added the ability to change the TweenLite.defaultEase.
	6.04:
		- Fixed bug that caused calls to complete() to not render if the tween hadn't ever started (like if there was a delay that hadn't expired yet)
	6.03:
		- Added the "renderOnStart" property that can force TweenLite.from() to render only when the tween actually starts (by default, it renders immediately even if the tween has a delay.)
	6.02:
		- Fixed bug that could cause TweenLite.delayedCall() to get called twice.
	6.01:
		- Fixed bug that could cause TweenLite.from() to not render the values immediately.
		- Fixed bug that could prevent tweens with a duration of zero from rendering properly.
	6.0:
		- Added ability to tween a MovieClip's frame
		- Added onCompleteScope, onStartScope, and onUpdateScope
		- Reworked internal class routines for handling SubTweens

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

class gs.TweenLite {
	public static var version:Number = 9.3;
	public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
	public static var overwriteManager:Object; //makes it possible to integrate the gs.OverwriteManager for adding auto overwrite capabilities
	public static var masterList:Object = new Object(); //Holds references to all our tweens.
	public static var currentTime:Number; //For syncronizing tweens
	public static var timerClip:MovieClip; //A reference to the empty MovieClip that we use to drive all our onEnterFrame actions.
	private static var _cnt:Number = -16000;
	private static var _gcInterval:Number; //Interval id for garbage collection
	private static var _hrp:Boolean = false;
	private static var _classInitted:Boolean;
	private var _subTweens:Array; //Only used for associated sub-tweens like tint, volume, etc.
	private var _hst:Boolean; //Has SubTweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
	private var _hasUpdate:Boolean; //has onUpdate. Tracking this as a Boolean value is faster than checking this.vars.onUpdate == undefined.
	
	public var duration:Number; //Duration (in seconds)
	public var vars:Object; //Variables (holds things like _alpha or _y or whatever we're tweening)
	public var delay:Number; //Delay (in seconds)
	public var startTime:Number; 
	public var initTime:Number; //Time of initialization. Remember, we can build in delays so this property tells us when the frame action was born, not when it actually started doing anything.
	public var tweens:Array; //Contains parsed data for each property that's being tweened
	public var target:Object; //Target object (like a MovieClip)
	public var ease:Function; 
	public var initted:Boolean;
	public var active:Boolean; 
	public var gc:Boolean; //flagged for garbage collection
	public var started:Boolean;
	public var combinedTimeScale:Number;  //even though TweenLite doesn't use this variable, TweenFilterLite and TweenMax do and it optimized things to store it here, particularly for TweenGroup
	public var endTargetID:String; //Target ID (a way to identify each end target, i.e. "t1", "t2", "t3")
	
	public function TweenLite($target:Object, $duration:Number, $vars:Object) {
		if (TweenLite.timerClip._visible != false || !_classInitted) { //Only evaluates true when 1) the movie just started, or 2) the user hits CTRL-ENTER in the authoring environment.
			currentTime = getTimer();
			var l:Number = 999; //Don't just do getNextHighestDepth() because often developers will hard-code stuff that uses low levels which would overwrite the TweenLite clip. Start at level 999 and make sure nothing's there. If there is, move up until we find an empty level.
			while (_root.getInstanceAtDepth(l) != undefined) {
				l++;
			}
			TweenLite.timerClip = _root.createEmptyMovieClip("__tweenLite_mc", l);
			TweenLite.timerClip._visible = false;
			clearInterval(_gcInterval);
			_gcInterval = setInterval(killGarbage, 2000);
			TweenLite.timerClip.onEnterFrame = updateAll;
			if (overwriteManager == undefined) {
				overwriteManager = {mode:1, enabled:false};
			}
			_classInitted = true;
		}
		this.vars = $vars;
		this.duration = $duration || 0.001;//Easing equations don't work when the duration is zero.
		this.delay = $vars.delay || 0;
		this.combinedTimeScale = $vars.timeScale || 1;
		this.active = Boolean($duration == 0 && this.delay == 0);
		this.target = $target;
		if (typeof(this.vars.ease) != "function") {
			this.vars.ease = defaultEase;
		}
		if (this.vars.easeParams != undefined) {
			this.vars.proxiedEase = this.vars.ease;
			this.vars.ease = easeProxy;
		}
		this.ease = this.vars.ease;
		if (typeof(this.vars.autoAlpha) == "number") {
			this.vars._alpha = this.vars.autoAlpha;
			this.vars._visible = Boolean(this.vars._alpha > 0);
		}
		this.tweens = [];
		_subTweens = [];
		_hst = this.initted = false;
		this.initTime = currentTime;
		this.startTime = this.initTime + (this.delay * 1000);
		
		this.endTargetID = getID($target, true);
		var mode:Number = ($vars.overwrite == undefined || (!overwriteManager.enabled && $vars.overwrite > 1)) ? overwriteManager.mode : Number($vars.overwrite);
		if (mode == 1 && $target != undefined) { 
			delete masterList[endTargetID];
			masterList[endTargetID] = {target:$target, tweens:[]};
		}
		masterList[endTargetID].tweens.push(this);
		
		if (this.active || (this.vars.runBackwards == true && this.vars.renderOnStart != true)) {
			initTweenVals();
			if (this.active) { //Means duration is zero and delay is zero, so render it now, but add one to the startTime because this.duration is always forced to be at least 0.001 since easing equations can't handle zero.
				render(this.startTime + 1);
			} else {
				render(this.startTime);
			}
			if (this.vars._visible != undefined && this.vars.runBackwards == true) {
				this.target._visible = this.vars._visible;
			}
		}
	}
	
	public function initTweenVals($hrp:Boolean, $reservedProps:String):Void {
		var isMC:Boolean = (typeof(this.target) == "movieclip" || this.target.isTweenProxy), p:String, i:Number;
		if ($hrp != true && overwriteManager.enabled) {
			overwriteManager.manageOverwrites(this, masterList[this.endTargetID].tweens);
		}
		if (this.target instanceof Array) {
			var endArray:Array = this.vars.endArray || [];
			for (i = 0; i < endArray.length; i++) {
				if (this.target[i] != endArray[i] && this.target[i] != undefined) {
					this.tweens[this.tweens.length] = [this.target, i.toString(), this.target[i], endArray[i] - this.target[i], i.toString()];  //[object, property, start, change, name]
				}
			}
		} else {
			
			if ((this.vars.tint != undefined || this.vars.removeTint == true) && (isMC || this.target instanceof TextField)) { //If we're trying to change the color of a MovieClip or TextField, then set up a quasai proxy using an instance of a TweenLite to control the color.
				var clr:Color = new Color(this.target);
				var endA:Number = this.vars._alpha;
				if (endA != undefined) {
					delete this.vars._alpha;
				} else {
					endA = this.target._alpha;
				}
				if (this.vars.removeTint == true || this.vars.tint == null || this.vars.tint == "") { //In case they're actually trying to remove the colorization, they should pass in removeTint as true (for backwards compatibility, we need to check for tint:null or tint:"" too)
					addSubTween("tint", tintProxy, clr.getTransform(), {rb:0, gb:0, bb:0, ab:0, ra:endA, ga:endA, ba:endA, aa:endA}, {color:clr});
				} else {
					addSubTween("tint", tintProxy, clr.getTransform(), {rb:(this.vars.tint >> 16), gb:(this.vars.tint >> 8) & 0xff, bb:(this.vars.tint & 0xff), ra:0, ga:0, ba:0, aa:endA}, {color:clr});
				}
			}
			if (this.vars.frame != undefined && isMC) {
				addSubTween("frame", frameProxy, {frame:this.target._currentframe}, {frame:this.vars.frame}, {mc:this.target});
			}
			if (this.vars.volume != undefined && (isMC || this.target instanceof Sound)) { //If we're trying to change the volume of a MovieClip or Sound object, then set up a quasai proxy using an instance of a TweenLite to control the volume.
				var snd:Sound = (isMC) ? new Sound(this.target) : Sound(this.target);
				addSubTween("volume", volumeProxy, {volume:snd.getVolume()}, {volume:this.vars.volume}, {sound:snd});
			}
			if (this.vars._visible != undefined && (isMC || this.target instanceof TextField)) {
				addSubTween("_visible", visibleProxy, {}, {}, {tween:this});
			}
			
			for (p in this.vars) {
				if (p == "ease" || p == "delay" || p == "overwrite" || p == "onComplete" || p == "onCompleteParams" || p == "onCompleteScope" || p == "runBackwards" || p == "onUpdate" || p == "onUpdateParams" || p == "onUpdateScope" || p == "persist" || p == "volume" || p == "onStart" || p == "onStartParams" || p == "onStartScope" || p == "renderOnStart" || p == "proxiedEase" || p == "easeParams" || ($hrp && $reservedProps.indexOf(" " + p + " ") != -1)) { 
					//ignore
				} else if (!(isMC && (p == "_visible" || p == "autoAlpha" || p == "tint" || p == "removeTint" || p == "frame")) && this.target[p] != undefined) {
					if (typeof(this.vars[p]) == "number") {
						this.tweens[this.tweens.length] = [this.target, p, this.target[p], this.vars[p] - this.target[p], p];  //[object, property, start, change, name]
					} else {
						this.tweens[this.tweens.length] = [this.target, p, this.target[p], Number(this.vars[p]), p];  //[object, property, start, change, name]
					}
				}
			}
		}
		if (this.vars.runBackwards == true) {
			var tp:Object;
			for (i = this.tweens.length - 1; i > -1; i--) {
				tp = this.tweens[i];
				tp[2] += tp[3];
				tp[3] *= -1;
			}
		}
		if (this.vars.onUpdate != null) {
			_hasUpdate = true;
		}
		this.initted = true;
	}
	
	private function addSubTween($name:String, $proxy:Function, $target:Object, $props:Object, $info:Object):Void {
		_subTweens[_subTweens.length] = {name:$name, proxy:$proxy, target:$target, info:$info};
		for (var p:String in $props) {
			if (typeof($props[p]) == "number") {
				this.tweens[this.tweens.length] = [$target, p, $target[p], $props[p] - $target[p], $name]; //[object, property, start, change, name]
			} else {
				this.tweens[this.tweens.length] = [$target, p, $target[p], Number($props[p]), $name]; //[object, property, start, change, name]
			}
		}
		_hst = true; //has sub-tweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
	}
	
	public static function to($target:Object, $duration:Number, $vars:Object):TweenLite {
		return new TweenLite($target, $duration, $vars);
	}
	
	public static function from($target:Object, $duration:Number, $vars:Object):TweenLite {
		$vars.runBackwards = true;
		return new TweenLite($target, $duration, $vars);;
	}
	
	public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array, $onCompleteScope:Object):TweenLite {
		return new TweenLite($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:0});
	}
	
	public function render($t:Number):Void {
		var time:Number = ($t - this.startTime) * 0.001, factor:Number, tp:Object, i:Number;
		if (time >= this.duration) {
			time = this.duration;
			factor = (this.ease == this.vars.ease || this.duration == 0.001) ? 1 : 0; //to accommodate TweenLiteGroup.reverse(). Without this, the last frame would render incorrectly
		} else {
			factor = this.ease(time, 0, 1, this.duration);
		}		
		for (i = this.tweens.length - 1; i > -1; i--) {
			tp = this.tweens[i];
			tp[0][tp[1]] = tp[2] + (factor * tp[3]); //tween index values: [object, property, start, change, name]
		}
		if (_hst) { //has sub-tweens
			for (i = _subTweens.length - 1; i > -1; i--) {
				_subTweens[i].proxy(_subTweens[i], time);
			}
		}
		if (_hasUpdate) {
			this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
		}
		if (time == this.duration) {
			complete(true);
		}
	}
	
	public static function updateAll():Void {
		var t:Number = currentTime = getTimer(), ml:Object = masterList, p:String, a:Array, i:Number, tween:TweenLite;
		for (p in ml) {
			a = ml[p].tweens;
			for (i = a.length - 1; i > -1; i--) {
				tween = a[i];
				if (tween.active) {
					tween.render(t);
				} else if (tween.gc) {
					a.splice(i, 1);
				} else if (t >= tween.startTime) {
					tween.activate();
					tween.render(t);
				}
			}
		}
	}
	
	public function activate():Void {
		this.started = this.active = true;
		if (!this.initted) {
			initTweenVals();
		}
		if (this.vars.onStart != undefined) {
			this.vars.onStart.apply(this.vars.onStartScope, this.vars.onStartParams);
		}
		if (this.duration == 0.001) { //In the constructor, if the duration is zero, we shift it to 0.001 because the easing functions won't work otherwise. We need to offset the startTime to compensate too.
			this.startTime -= 1;
		}
	}
	
	public function complete($skipRender:Boolean):Void {
		if ($skipRender != true) {
			if (!this.initted) {
				initTweenVals();
			}
			this.startTime = currentTime - (this.duration * 1000) / this.combinedTimeScale;
			render(currentTime); //Just to force the final render
			return;
		}
		if (this.vars.persist != true) {
			this.enabled = false;
		}
		if (this.vars.onComplete) {
			this.vars.onComplete.apply(this.vars.onCompleteScope, this.vars.onCompleteParams);
		}
	}
	
	public static function removeTween($t:TweenLite, $clear:Boolean):Void {
		if ($clear != false) {
			$t.clear();
		}
		$t.enabled = false;
	}
	
	public function clear():Void {
		this.tweens = [];
		_subTweens = [];
		this.vars = {};
		_hst = _hasUpdate = false;
	}
	
	public static function killTweensOf($target:Object, $complete:Boolean):Void {
		var id:String = getID($target, true);
		var a:Array = masterList[id], i:Number, tween:TweenLite;
		if (a != undefined) {
			for (i = a.length - 1; i > -1; i--) {
				tween = a[i];
				if ($complete && !tween.gc) {
					tween.complete(false);
				}
				tween.clear(); //prevents situations where a tween is killed but is still referenced elsewhere and put back in the render queue, like if a TweenLiteGroup is paused, then the tween is removed, then the group is unpaused.
			}
			delete masterList[id];
		}
	}
	
	public function killVars($vars:Object):Void {
		if (overwriteManager.enabled) {
			overwriteManager.killVars($vars, this.vars, this.tweens, _subTweens, []);
		}
	}
	
	public static function getID($target:Object, $lookup:Boolean):String {
		var id:String;
		if ($lookup) {
			var ml:Object = masterList;
			if (typeof($target) == "movieclip") {
				if (ml[String($target)] != undefined) {
					return String($target);
				} else {
					id = String($target);
					masterList[id] = {target:$target, tweens:[]};
					return id;
				}
			} else {
				for (var p:String in ml) {
					if (ml[p].target == $target) {
						return p;
					}
				}
			}
		}
		_cnt++;
		id = "t" + _cnt;
		masterList[id] = {target:$target, tweens:[]};
		return id;
	}
	
	public static function killGarbage():Void {
		var ml:Object = masterList, p:String, a:Array;
		for (p in ml) {
			if (ml[p].tweens.length == 0) {
				delete ml[p];
			}
		}
	}
	
	public static function defaultEase($t:Number, $b:Number, $c:Number, $d:Number):Number {
		return -$c * ($t /= $d) * ($t - 2) + $b;
	}
	
//---- PROXY FUNCTIONS -----------------------------------------------------------------------------------------------------------

	private function easeProxy($t:Number, $b:Number, $c:Number, $d:Number):Number { //Just for when easeParams are passed in via the vars object.
		return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
	}
	public static function tintProxy($o:Object):Void {
		$o.info.color.setTransform($o.target);
	}
	public static function frameProxy($o:Object):Void {
		$o.info.mc.gotoAndStop(Math.round($o.target.frame));
	}
	public static function volumeProxy($o:Object):Void {
		$o.info.sound.setVolume($o.target.volume);
	}
	public static function visibleProxy($o:Object, $time:Number):Void {
		var t:TweenLite = $o.info.tween;
		if (t.duration == $time) {
			if (t.vars.runBackwards != true && t.ease == t.vars.ease) { //t.ease == t.vars.ease checks to make sure the tween wasn't reversed with a TweenGroup
				t.target._visible = t.vars._visible;
			}
		} else if (t.target._visible != true) {
			t.target._visible = true;
		}
	}
	
	
//---- GETTERS / SETTERS ----------------------------------------------------------------------------------------------------------
	
	
	public function get enabled():Boolean {
		return (this.gc) ? false : true;
	}
	
	public function set enabled($b:Boolean):Void {
		if ($b) {
			if (masterList[this.endTargetID] == undefined) {
				masterList[this.endTargetID] = {target:this.target, tweens:[this]};
			} else {
				var a:Array = masterList[this.endTargetID].tweens, found:Boolean, i:Number;
				for (i = a.length - 1; i > -1; i--) {
					if (a[i] == this) {
						found = true;
						break;
					}
				}
				if (!found) {
					masterList[this.endTargetID].tweens.push(this);
				}
			}
		}
		this.gc = ($b) ? false : true;
		if (this.gc) {
			this.active = false;
		} else {
			this.active = this.started;
		}
	}
	
}