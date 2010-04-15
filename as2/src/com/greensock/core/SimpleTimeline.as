/**
 * VERSION: 1.133
 * DATE: 2010-01-18
 * ACTIONSCRIPT VERSION: 3.0 (AS2 version is also available)
 * UPDATES AND DOCUMENTATION AT: http://www.TweenLite.com
 **/
import com.greensock.core.TweenCore; 
 
/**
 * SimpleTimeline is the base class for the TimelineLite and TimelineMax classes. It provides the
 * most basic timeline functionality and is used for the root timelines in TweenLite. It is meant
 * to be very fast and lightweight. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
class com.greensock.core.SimpleTimeline extends TweenCore {
		/** @private **/
		private var _firstChild:TweenCore;
		/** @private **/
		private var _lastChild:TweenCore;
		/**If a timeline's autoRemoveChildren is true, its children will be removed and made eligible for garbage collection as soon as they complete. This is the default behavior for the main/root timeline. **/
		public var autoRemoveChildren:Boolean; 
		
		public function SimpleTimeline(vars:Object) {
			super(0, vars);
		}
		
		/** @private **/
		public function addChild(node:TweenCore):Void {
			if (!node.gc && node.timeline != undefined) {
				node.timeline.remove(node, true); //removes from existing timeline so that it can be properly added to this one.
			}
			node.timeline = this;
			if (node.gc) {
				node.setEnabled(true, true);
			}
			if (_firstChild) {
				_firstChild.prevNode = node;	
			}
			node.nextNode = _firstChild;
			_firstChild = node;
			node.prevNode = undefined;
		}
		
		/** @private **/
		public function remove(tween:TweenCore, skipDisable:Boolean):Void {
			if (tween.gc) {
				return; //already removed!
			} else if (skipDisable != true) {
				tween.setEnabled(false, true);
			}
			if (tween.nextNode) {
				tween.nextNode.prevNode = tween.prevNode;
			} else if (_lastChild == tween) {
				_lastChild = tween.prevNode;
			}
			if (tween.prevNode) {
				tween.prevNode.nextNode = tween.nextNode;
			} else if (_firstChild == tween) {
				_firstChild = tween.nextNode;
			}
			//don't null nextNode and prevNode, otherwise the chain could break in rendering loops.
		}
		
		/** @inheritDoc **/
		public function renderTime(time:Number, suppressEvents:Boolean, force:Boolean):Void {
			var tween:TweenCore = _firstChild, dur:Number, next:TweenCore;
			this.cachedTotalTime = time;
			this.cachedTime = time;
			while (tween) {
				next = tween.nextNode; //record it here because the value could change after rendering...
				if (tween.active || (time >= tween.cachedStartTime && !tween.cachedPaused && !tween.gc)) {
					if (!tween.cachedReversed) {
						tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
					} else {
						dur = (tween.cacheIsDirty) ? tween.totalDuration : tween.cachedTotalDuration;
						tween.renderTime(dur - ((time - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
					}
				}
				tween = next;
			}
		}
		
//---- GETTERS / SETTERS ------------------------------------------------------------------------------
		
		/**
		 * @private
		 * Reports the totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum) which can be useful when
		 * unpausing tweens/timelines. Imagine a case where a paused tween is in a timeline that has already reached the end, but then
		 * the tween gets unpaused - it needs a way to place itself accurately in time AFTER what was previously the timeline's end time.
		 * In a SimpleTimeline, rawTime is always the same as cachedTotalTime, but in TimelineLite and TimelineMax, it can be different.
		 * 
		 * @return The totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum)
		 */
		public function get rawTime():Number {
			return this.cachedTotalTime;			
		}
}