using Toybox.WatchUi;

class SleepCycleAlarmDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {	
    	System.exit();
    }

}