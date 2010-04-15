/**
 * VERSION: 1.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
import com.greensock.*;
import com.greensock.plugins.*;
/**
 * If you'd like the inbetween values in a tween to always get rounded to the nearest integer, use the roundProps
 * special property. Just pass in an Array containing the property names that you'd like rounded. For example,
 * if you're tweening the _x, _y, and _alpha properties of mc and you want to round the _x and _y values (not _alpha)
 * every time the tween is rendered, you'd do: <br /><br /><code>
 * 	
 * 	TweenMax.to(mc, 2, {_x:300, _y:200, _alpha:50, roundProps:["_x","_y"]});<br /><br /></code>
 * 
 * <b>IMPORTANT:</b> roundProps requires TweenMax! TweenLite tweens will not round properties. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import com.greensock.TweenMax; <br /><br />
 * 
 * 		TweenMax.to(mc, 2, {_x:300, _y:200, _alpha:50, roundProps:["_x","_y"]}); <br /><br />
 * </code>
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
class com.greensock.plugins.RoundPropsPlugin extends TweenPlugin {
		/** @private **/
		public static var API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		public function RoundPropsPlugin() {
			super();
			this.propName = "roundProps";
			this.overwriteProps = [];
			this.round = true;
		}
		
		/** @private **/
		public function add(object:Object, propName:String, start:Number, change:Number):Void {
			addTween(object, propName, start, start + change, propName);
			this.overwriteProps[this.overwriteProps.length] = propName;
		}
	
}