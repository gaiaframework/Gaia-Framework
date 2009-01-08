/**
* Logging Flex and Flash projects using Firebug and ThunderBolt AS3
* 
* @version	2.0
* @date		08/03/08
*
* @author	Jens Krause [www.websector.de]
*
* @see		http://www.websector.de/blog/category/thunderbolt/
* @see		http://code.google.com/p/flash-thunderbolt/
* @source	http://flash-thunderbolt.googlecode.com/svn/trunk/as3/
* 
* ***********************
* HAPPY LOGGING ;-)
* ***********************
* 
*/

package org.osflash.thunderbolt
{
	import mx.logging.AbstractTarget;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.ILogger;	
	
	public class ThunderBoltTarget extends AbstractTarget
	{
		public var includeTime: Boolean = true;
		public var includeLevel: Boolean = true;   	    	
		public var includeCategory: Boolean = true;
		
		protected static const FIELD_SEPERATOR: String = " :: ";
		
		 
		public function ThunderBoltTarget ()
		{
			super();		
		}

 
	     /**
	     *  Listens to an log event based on Flex Logging Framework
	     * 	and calls ThunderBolt trace method
	     * 
		 * @param 	Event	LogEvent
		 * 
	     */
	    override public function logEvent(event: LogEvent):void
	    {		
			//
			// adds a timestamp
    		Logger.includeTime = includeTime;	    	
	    	//
	    	// logs level
	        var level: String;
	        if (includeLevel) level = getLogLevel(event.level);	
			//
			// logs category
	    	var message: String = "";
			if (includeCategory) message += ILogger(event.target).category + FIELD_SEPERATOR;
			//
			// logs message
			if (event.message.length) 
				message += event.message;
			else 
				message += "Log message has'nt defined...";
	    	//
	    	// calls ThunderBolt	
	    	Logger.log (level, message);

	    }   

		/**
		 * Translates Flex log levels to Firebugs log levels
		 * 
		 * @param 	int			log level as integer
		 * @return 	String		level description
		 * 
		 */		
		private static function getLogLevel (logLevel: int): String
		{
			var level: String;
			
			switch (logLevel) 
			{
				case LogEventLevel.INFO:
					level = Logger.INFO;
					break;
				case LogEventLevel.WARN:
					level = Logger.WARN;
					break;				
				case LogEventLevel.ERROR:
					level = Logger.ERROR;
					break;
				// Firebug doesn't support a fatal level
				case LogEventLevel.FATAL:
					level = Logger.ERROR;
					break;
				default:
					// LogLevel.DEBUG && LogLevel.ALL
					level = Logger.LOG;
			}

			return level;
		}        		
	}

}