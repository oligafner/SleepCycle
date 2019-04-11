using Toybox.WatchUi;

class SleepCycleMainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SleepCycleMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}