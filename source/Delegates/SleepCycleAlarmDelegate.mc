using Toybox.WatchUi;

class SleepCycleAlarmDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {	
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}