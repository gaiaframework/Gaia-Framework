import net.stevensacks.utils.ObservableClass;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

class net.stevensacks.net.RemotingConnection extends ObservableClass
{
	var theResponder:RelayResponder;
	var theService:Service;
	var theCall:PendingCall;
	//
	function RemotingConnection(gateway:String, service:String) 
	{
		super();
		theResponder = new RelayResponder(this, "onResult", "onFault");
		theService = new Service(gateway, null, service, null, theResponder);
	}
	public function request():Void
	{
		var method:String = String(arguments.shift());
		theCall = theService[method].apply(theService, arguments);
		theCall.responder = theResponder;
	}
	private function onResult(re:ResultEvent) 
	{
		dispatchEvent({type:"onResult", result:re.result});
	}
	private function onFault(fe:FaultEvent) 
	{
		dispatchEvent({type:"onFault", result:fe.fault});
	}
	
}