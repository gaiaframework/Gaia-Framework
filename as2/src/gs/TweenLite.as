/*
VERSION: 10.09
DATE: 2/9/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenLite.com
DESCRIPTION:
	TweenLite is an extremely lightweight, FAST, and flexible tweening engine that serves as the core of 
	the GreenSock tweening platform. There are plenty of other tweening engines out there to choose from,
	so here's why you might want to consider TweenLite:
	
		- SPEED - I'm not aware of any popular tweening engine with a similar feature set that's as fast
		  as TweenLite. See some speed comparisons yourself at http://blog.greensock.com/tweening-speed-test/
		  
		- Feature set - In addition to tweening ANY numeric property of ANY object, TweenLite can tween filters, 
		  hex colors, volume, tint, and frames, and even do bezier tweening, plus LOTS more. TweenMax extends 
		  TweenLite and adds even more capabilities like pause/resume, rounding, and more. 
		  Overwrite management is an important consideration for a tweening engine as well which is another 
		  area where the GreenSock tweening platform shines. You have options for AUTO overwriting or you can
		  manually define how each tween will handle overlapping tweens of the same object.
		  
		- Expandability - With its new plugin architecture, you can activate as many (or as few) features as your 
		  project requires. Or write your own plugin if you need a feature that's unavailable. Minimize bloat, and
		  maximize performance.
		  
		- Management features - TweenGroup makes it surprisingly simple to create complex sequences and groups
		  of TweenLite/Max tweens that you can pause(), resume(), restart(), or reverse(). You can even tween a TweenGroup's 
		  progress property to fastforward or rewind the entire group/sequence. 
		  
		- Ease of use - Designers and Developers alike rave about how intuitive the GreenSock tweening platform is.
		
		- Updates - Frequent updates and feature additions make the GreenSock tweening platform reliable and robust.
		
		- AS2 and AS3 - Most other engines are only developed for AS2 or AS3 but not both.
	

PARAMETERS:
	1) $target : Object - Target object whose properties we're tweening
	2) $duration : Number - Duration (in seconds) of the tween
	3) $vars : Object - An object containing the end values of all the properties you'd like tweened (or if you're using 
	         			TweenLite.from(), these variables would define the BEGINNING values). For example, to tween
	         			myClip's _alpha to 50 over the course of 1 second, you'd do: TweenLite.to(myClip, 1, {_alpha:50}).
	         			
SPECIAL PROPERTIES (no plugins required):
	Any of the following special properties can optionally be passed in through the $vars object (the third parameter):

	delay : Number - Amount of delay before the tween should begin (in seconds).
	
	ease : Function - Use any standard easing equation to control the rate of change. For example, 
					  gs.easing.Elastic.easeOut. The Default is Regular.easeOut.
	
	easeParams : Array - An Array of extra parameters to feed the easing equation. This can be useful when 
						 using an ease like Elastic and want to control extra parameters like the amplitude and period.
						 Most easing equations, however, don't require extra parameters so you won't need to pass in any easeParams.
	
	onStart : Function - If you'd like to call a function as soon as the tween begins, reference it here.
	
	onStartParams : Array - An Array of parameters to pass the onStart function.
	
	onStartScope : Object - Use this to define the scope of the onStart function.
	
	onUpdate : Function - If you'd like to call a function every time the property values are updated (on every frame during
						  the course of the tween), reference it here.
	
	onUpdateParams : Array - An Array of parameters to pass the onUpdate function
	
	onUpdateScope : Object - Use this to define the scope of the onUpdate function.
	
	onComplete : Function - If you'd like to call a function when the tween has finished, reference it here. 
	
	onCompleteParams : Array - An Array of parameters to pass the onComplete function
	
	onCompleteScope : Object - Use this to define the scope of the onComplete function.
	
	persist : Boolean - if true, the TweenLite instance will NOT automatically be removed by the garbage collector when it is complete.
  					    However, it is still eligible to be overwritten by new tweens even if persist is true. By default, it is false.
	
	renderOnStart : Boolean - If you're using TweenLite.from() with a delay and want to prevent the tween from rendering until it
							  actually begins, set this to true. By default, it's false which causes TweenLite.from() to render
							  its values immediately, even before the delay has expired.
	
	overwrite : int - Controls how other tweens of the same object are handled when this tween is created. Here are the options:
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


PLUGINS:
	There are many plugins that add capabilities through other special properties. Some examples are "tint", 
	"volume", "frame", "frameLabel", "bezier", "blurFilter", "colorMatrixFilter", "hexColors", and many more.
	Adding the capabilities is as simple as activating the plugin with a single line of code, like TintPlugin.activate();
	Get information about all the plugins at http://blog.greensock.com/plugins/


EXAMPLES: 
	Tween the alpha to 50% and move the _x position of a MovieClip named "clip_mc" 
	to 120 and fade the volume to 0 over the course of 1.5 seconds like so:
	
		import gs.*;
		TweenLite.to(clip_mc, 1.5, {_alpha:50, _x:120, volume:0});
	
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the _alpha to 50, 
	the _x to 120 using the "Back.easeOut" easing function, delay starting the whole tween by 2 seconds, and then call
	a function named "onFinishTween" when it has completed and pass a few parameters to that function (a value of
	5 and a reference to the clip_mc), you'd do so like:
		
		import gs.*;
		import gs.easing.*;
		TweenLite.to(clip_mc, 5, {_alpha:50, _x:120, ease:Back.easeOut, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1:Number, argument2:MovieClip):Void {
			trace("The tween has finished! argument1 = " + argument1 + ", and argument2 = " + argument2);
		}
	
	If you have a MovieClip on the stage that is already in it's end position and you just want to animate it into 
	place over 5 seconds (drop it into place by changing its _y property to 100 pixels higher on the screen and 
	dropping it from there), you could:
		
		import gs.*;
		import gs.easing.*;
		TweenLite.from(clip_mc, 5, {_y:"-100", ease:Elastic.easeOut});		
	

NOTES:

	- The base TweenLite class adds about 2.7kb to your Flash file, but if you activate the extra features
	  that were available in versions prior to 10.0 (tint, removeTint, frame, endArray, _visible, and autoAlpha), 
	  it totals about 5k. You can easily activate those plugins by uncommenting out the associated lines of 
	  code in the constructor.
	  
	- Passing values as Strings will make the tween relative to the current value. For example, if you do
	  TweenLite.to(mc, 2, {_x:"-20"}); it'll move the mc.x to the left 20 pixels which is the same as doing
	  TweenLite.to(mc, 2, {_x:mc._x - 20}); You could also cast it like: TweenLite.to(mc, 2, {_x:String(myVariable)});
	  
	- You can change the TweenLite.defaultEase function if you prefer something other than Regular.easeOut.
	
	- Kill all tweens for a particular object anytime with the TweenLite.killTweensOf(myClip_mc); 
	  function. If you want to have the tweens forced to completion, pass true as the second parameter, 
	  like TweenLite.killTweensOf(myClip_mc, true);
	  
	- You can kill all delayedCalls to a particular function using TweenLite.killDelayedCallsTo(myFunction);
	  This can be helpful if you want to preempt a call.
	  
	- Use the TweenLite.from() method to animate things into place. For example, if you have things set up on 
	  the stage in the spot where they should end up, and you just want to animate them into place, you can 
	  pass in the beginning _x and/or _y and/or _alpha (or whatever properties you want).
	  
	- If you find this class useful, please consider joining Club GreenSock which not only contributes
	  to ongoing development, but also gets you bonus classes (and other benefits) that are ONLY available 
	  to members. Learn more at http://blog.greensock.com/club/
	  
	  
CHANGE LOG:
	10.09:
		- Fixed bug with timeScale
	10.06:
		- Speed improvements
		- Integrated a new gs.utils.tween.TweenInfo class
		- Minor internal changes
	10.0:
		- Major update, shifting to a "plugin" architecture for handling special properties. 
		- Added "remove" property to all filter tweens to accommodate removing the filter at the end of the tween
		- Added "frameLabel" plugin
		- Speed enhancements
		- Fixed minor overwrite bugs
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


AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.plugins.*;
import gs.utils.tween.*;

class gs.TweenLite {
	public static var version:Number = 10.09;
	public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
	public static var overwriteManager:Object; //makes it possible to integrate the gs.OverwriteManager for adding auto overwrite capabilities
	public static var masterList:Object = {}; //Holds references to all our tweens.
	public static var currentTime:Number; //For syncronizing tweens
	public static var timerClip:MovieClip; //A reference to the empty MovieClip that we use to drive all our onEnterFrame actions.
	public static var plugins:Object = {};
	private static var _cnt:Number = -16000;
	private static var _gcInterval:Number; //Interval id for garbage collection
	private static var _tlInitted:Boolean;
	private static var _reservedProps:Object = {ease:1, delay:1, overwrite:1, onComplete:1, onCompleteParams:1, runBackwards:1, startAt:1, onUpdate:1, onUpdateParams:1, roundProps:1, onStart:1, onStartParams:1, persist:1, renderOnStart:1, proxiedEase:1, easeParams:1, yoyo:1, loop:1, onCompleteListener:1, onUpdateListener:1, onStartListener:1, orientToBezier:1, timeScale:1};
	
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
	public var combinedTimeScale:Number;  //even though TweenLite doesn't use this variable, TweenMax does and it optimized things to store it here, particularly for TweenGroup
	public var endTargetID:String; //Target ID (a way to identify each end target, i.e. "t1", "t2", "t3")
	
	private var _hasPlugins:Boolean; //if there are TweenPlugins in the tweens Array, we set this to true - it helps speed things up in onComplete
	private var _hasUpdate:Boolean; //has onUpdate. Tracking this as a Boolean value is faster than checking this.vars.onUpdate == undefined.
	
	public function TweenLite($target:Object, $duration:Number, $vars:Object) {
		if (TweenLite.timerClip._visible != false || !_tlInitted) { //Only evaluates true when 1) the movie just started, or 2) the user hits CTRL-ENTER in the authoring environment.
			
			TweenPlugin.activate([
		
		
				//ACTIVATE (OR DEACTIVATE) PLUGINS HERE...
				
				TintPlugin,					//tweens tints
				RemoveTintPlugin,			//allows you to remove a tint
				FramePlugin,				//tweens MovieClip frames
				AutoAlphaPlugin,			//tweens alpha and then toggles "visible" to false if/when alpha is zero
				VisiblePlugin,				//tweens a target's "visible" property
				VolumePlugin,				//tweens the volume of a MovieClip or SoundChannel or anything with a "soundTransform" property
				EndArrayPlugin				//tweens numbers in an Array		
				
				
				]);
			
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
			_tlInitted = true;
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
		this.tweens = [];
		this.initted = false;
		this.initTime = currentTime;
		this.startTime = this.initTime + (this.delay * 1000);
		
		this.endTargetID = getID($target, true);
		var mode:Number = ($vars.overwrite == undefined || (!overwriteManager.enabled && $vars.overwrite > 1)) ? overwriteManager.mode : Number($vars.overwrite);
		if (mode == 1 && $target != undefined) { 
			delete masterList[endTargetID];
			masterList[endTargetID] = {target:$target, tweens:[this]};
		} else {
			masterList[endTargetID].tweens.push(this);
		}
		
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
	
	public function initTweenVals():Void {
		var p:String, i:Number, plugin:Object;
		if (this.vars.timeScale != undefined && (this.target instanceof TweenLite)) {
			this.tweens[this.tweens.length] = new TweenInfo(this.target, "timeScale", this.target.timeScale, this.vars.timeScale - this.target.timeScale, "timeScale", false); //[object, property, start, change, name, isPlugin]
		}
		for (p in this.vars) {
			if (_reservedProps[p] != undefined) { 
				//ignore
				
			} else if (plugins[p] != undefined) {
				plugin = new plugins[p]();
				if (plugin.onInitTween(this.target, this.vars[p], this) == false) {
					this.tweens[this.tweens.length] = new TweenInfo(this.target, p, this.target[p], (typeof(this.vars[p]) == "number") ? this.vars[p] - this.target[p] : Number(this.vars[p]), p, false); //[object, property, start, change, name, isPlugin]
				} else {
					this.tweens[this.tweens.length] = new TweenInfo(plugin, "changeFactor", 0, 1, (plugin.overwriteProps.length == 1) ? plugin.overwriteProps[0] : "_MULTIPLE_", true); //[object, property, start, change, name, isPlugin]
					_hasPlugins = true;
				}
				
			} else {
				this.tweens[this.tweens.length] = new TweenInfo(this.target, p, this.target[p], (typeof(this.vars[p]) == "number") ? this.vars[p] - this.target[p] : Number(this.vars[p]), p, false); //[object, property, start, change, name, isPlugin]
			}
		}
		if (this.vars.runBackwards == true) {
			var ti:TweenInfo;
			for (i = this.tweens.length - 1; i > -1; i--) {
				ti = this.tweens[i];
				ti.start += ti.change;
				ti.change = -ti.change;
			}
		}
		if (this.vars.onUpdate != null) {
			_hasUpdate = true;
		}
		if (overwriteManager.enabled && masterList[this.endTargetID] != undefined) {
			overwriteManager.manageOverwrites(this, masterList[this.endTargetID].tweens);
		}
		this.initted = true;
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
	
	public function render($t:Number):Void {
		var time:Number = ($t - this.startTime) * 0.001, factor:Number, ti:TweenInfo, i:Number;
		if (time >= this.duration) {
			time = this.duration;
			factor = (this.ease == this.vars.ease || this.duration == 0.001) ? 1 : 0; //to accommodate TweenLiteGroup.reverse(). Without this, the last frame would render incorrectly
		} else {
			factor = this.ease(time, 0, 1, this.duration);
		}		
		for (i = this.tweens.length - 1; i > -1; i--) {
			ti = this.tweens[i];
			ti.target[ti.property] = ti.start + (factor * ti.change); //tween index values: [object, property, start, change, name, isPlugin]
		}
		if (_hasUpdate) {
			this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
		}
		if (time == this.duration) {
			complete(true);
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
		if (_hasPlugins) {
			for (var i:Number = this.tweens.length - 1; i > -1; i--) {
				if (this.tweens[i].isPlugin == true && this.tweens[i].target.onComplete != undefined) { //function calls are expensive performance-wise, so don't call the plugin's onComplete() unless necessary. Most plugins don't require them.
					this.tweens[i].target.onComplete();
				}
			}
		}
		if (this.vars.persist != true) {
			this.enabled = false;
		}
		if (this.vars.onComplete) {
			this.vars.onComplete.apply(this.vars.onCompleteScope, this.vars.onCompleteParams);
		}
	}
	
	public function clear():Void {
		this.tweens = [];
		this.vars = {ease:this.vars.ease}; //just to avoid potential errors if someone tries to set the progress on a reversed tween that has been killed (unlikely, I know)
		_hasUpdate = false;
	}
	
	public function killVars($vars:Object):Void {
		if (overwriteManager.enabled) {
			overwriteManager.killVars($vars, this.vars, this.tweens);
		}
	}
	
	
//---- STATIC FUNCTIONS ----------------------------------------------------------------------------------------
	
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
	
	public static function removeTween($t:TweenLite, $clear:Boolean):Void {
		if ($clear != false) {
			$t.clear();
		}
		$t.enabled = false;
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
					a[a.length] = this;
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