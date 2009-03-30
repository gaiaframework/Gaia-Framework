/*
VERSION: 3.12
DATE: 2/9/2009
ACTIONSCRIPT VERSION: 2.0 (AS3 version is available)
UPDATES & DOCUMENTATION AT: http://blog.greensock.com/overwritemanager/
DESCRIPTION:
	OverwriteManager is included in all TweenLite/TweenMax downloads and allows you to control how tweens with 
	overlapping properties are handled. Without OverwriteManager, tweens of the same object are always completely overwritten 
	unless you set overwrite:0 (previously overwrite:false which still works by the way).
		
		TweenLite.to(mc, 1, {_x:100, _y:200});
		TweenLite.to(mc, 1, {_alpha:0.5, delay:2}); //Without OverwriteManager, this tween immediately overwrites the previous one
		
	So even though there are no overlapping properties in the previous example, the 2nd tween would overwrite the first. 
	The primary reason for this has to do with speed and file size. But if you're willing to sacrifice	a little speed and file size, 
	OverwriteManager can work with the tweening classes to automatically sense when there are overlapping properties and then only 
	overwrite the individual properties in the other tween(s). Don't worry, you'd probably never notice even a slight speed decrease 
	unless hundreds of tweens are beginning simultaneously with overlapping properties.
		
	I kept OverwriteManager as a separate, optional class primarily because of file size concerns. I know, you're probably thinking 
	"what the heck? It's not even 1Kb! What's the big deal?". Well, there are thousands of developers using TweenLite because of its
	extremely small footprint and blistering speed. Even 1Kb would represent a 33% increase in file size, and some developers have no 
	use for the capabilities of this class. 
	
	So OverwriteManager is an optional enhancement to TweenLite, but it is automatically included with TweenMax
	without any additional steps required on your part. That also means that if you use TweenMax anywhere in your project, 
	OverwriteManager will automatically get initted and will therefore affect TweenLite, making its
	default mode "AUTO" instead of "ALL". 
	

USAGE:
	OverwriteManager has three modes: NONE, ALL, and AUTO. By default, it uses AUTO. Here's what they do:
		
		- NONE (0): No tweens are overwritten. This is the fastest mode, but you need to be careful not to create any tweens with
					overlapping properties, otherwise they'll conflict with each other.
						
		- ALL (1): Similar to the default behavior of TweenLite/TweenMax where all tweens of the same object are completely
				   overwritten immediately when the tween is created. 
						
						TweenLite.to(mc, 1, {_x:100, _y:200});
						TweenLite.to(mc, 1, {_x:300, delay:2}); //immediately overwrites the previous tween
							
		- AUTO (2): Searches for and overwrites only individual overlapping properties in tweens that are running at the time the tween begins. 
						
						TweenLite.to(mc, 1, {_x:100, _y:200});
						TweenLite.to(mc, 1, {_x:300}); //only overwrites the "x" property in the previous tween
							
		- CONCURRENT (3): Overwrites all tweens of the same object that are active at the time the tween begins.
						
						TweenLite.to(mc, 1, {_x:100, _y:200});
						TweenLite.to(mc, 1, {_x:300, delay:2}); //does NOT overwrite the previous tween because the first tween will have finished by the time this one begins.
		
		
	To add OverwriteManager's capabilities to TweenLite, you must init() the class once (typically on the first frame of your file) like so:
			
		OverwriteManager.init();
		
	You do NOT need to add this line if you're using TweenMax because it automatically does it internally.
	

EXAMPLES: 

	To start OverwriteManager in AUTO mode (the default) and then do a simple TweenLite tween, simply do:
		
		import gs.*;
		
		OverwriteManager.init();
		TweenLite.to(mc, 2, {_x:"300"});
		
	You can also define overwrite behavior in individual tweens, like so:
	
		import gs.*;
		
		OverwriteManager.init();
		TweenLite.to(mc, 2, {_x:"300", _y:"100"});
		TweenLite.to(mc, 1, {_alpha:0.5, overwrite:1}); //or simply the constant OverwriteManager.ALL
		TweenLite.to(mc, 3, {_x:200, _rotation:30, overwrite:2}); //or simply the constant OverwriteManager.AUTO
		
	But normally, you'll just control the overwriting directly through the OverwriteManager with its mode property, like this:
		
		import gs.*;
		
		OverwriteManager.init(OverwriteManager.ALL);
		
		//-OR-//
		
		OverwriteManager.init();
		OverwriteManager.mode = OverwriteManager.ALL;
		
	The mode can be changed anytime.
		
	

NOTES:
	- This class adds about 1Kb to your SWF.

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

import gs.*;
import gs.utils.tween.*;

class gs.OverwriteManager {	
	public static var version:Number = 3.12;
	public static var NONE:Number = 0;
	public static var ALL:Number = 1;
	public static var AUTO:Number = 2;
	public static var CONCURRENT:Number = 3;
	public static var mode:Number;
	public static var enabled:Boolean;
	
	public static function init($mode:Number):Number {
		if (TweenLite.version < 10.09) {
			trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
		}
		TweenLite.overwriteManager = OverwriteManager;
		mode = ($mode == undefined) ? 2 : $mode;
		enabled = true;
		return mode;
	}
	
	public static function manageOverwrites($tween:TweenLite, $targetTweens:Array):Void {
		var vars:Object = $tween.vars;
		var m:Number = (vars.overwrite == undefined) ? mode : Number(vars.overwrite);
		if (m < 2 || $targetTweens == undefined) {
			return;
		}
		
		var startTime:Number = $tween.startTime, a:Array = [], i:Number, p:String, tween:TweenLite, index:Number = -1;
		for (i = $targetTweens.length - 1; i > -1; i--) {
			tween = $targetTweens[i];
			if (tween == $tween) {
				index = i;
			} else if (i < index && tween.startTime <= startTime && tween.startTime + (tween.duration * 1000 / tween.combinedTimeScale) > startTime) {
				a[a.length] = tween;
			}
		}
		if (a.length == 0 || $tween.tweens.length == 0) {
			return;
		}
		
		if (m == AUTO) {
			var tweens:Array = $tween.tweens, v:Object = {}, j:Number, ti:TweenInfo, overwriteProps:Array;
			for (i = tweens.length - 1; i > -1; i--) {
				ti = tweens[i];
				if (ti.isPlugin) {
					if (ti.name == "_MULTIPLE_") {
						overwriteProps = ti.target.overwriteProps;
						for (j = overwriteProps.length - 1; j > -1; j--) {
							v[overwriteProps[j]] = true;
						}
					} else {
						v[ti.name] = true;
					}
					v[ti.target.propName] = true;
				} else {
					v[ti.name] = true;
				}
			}
			
			for (i = a.length - 1; i > -1; i--) {
				killVars(v, a[i].vars, a[i].tweens);
			}
		} else {
			for (i = a.length - 1; i > -1; i--) {
				a[i].enabled = false; //flags for garbage collection
			}
		}
	}
	
	public static function killVars($killVars:Object, $vars:Object, $tweens:Array, $subTweens:Array, $filters:Array):Void {
		var i:Number, p:String, ti:TweenInfo;
		for (i = $tweens.length - 1; i > -1; i--) {
			ti = $tweens[i];
			if ($killVars[ti.name] != undefined) {
				$tweens.splice(i, 1);
			} else if (ti.isPlugin && ti.name == "_MULTIPLE_") { //is a plugin with multiple overwritable properties
				ti.target.killProps($killVars);
				if (ti.target.overwriteProps.length == 0) {
					$tweens.splice(i, 1);
				}
			}
		}
		for (p in $killVars) {
			delete $vars[p];
		}
	}

}