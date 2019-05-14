using Toybox.WatchUi;

class SleepCycleMainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SleepCycleMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    
    function onBack() {
    	WatchUi.pushView(new SleepCycleConfirmView(), new SleepCycleConfirmDelegate(), WatchUi.SLIDE_UP);
    	return true;
    }

}