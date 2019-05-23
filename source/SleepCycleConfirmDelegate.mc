using Toybox.WatchUi;

class SleepCycleConfirmDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        System.exit();
    }
}