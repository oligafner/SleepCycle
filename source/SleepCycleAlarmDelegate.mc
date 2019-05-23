using Toybox.WatchUi;

class SleepCycleAlarmDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
	
	//close app if user presses select
    function onSelect() {	
    	System.exit();
    }
    
    //close app if user presses back
    function onBack() {	
    	System.exit();
    }
}