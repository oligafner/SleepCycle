using Toybox.WatchUi;

class SleepCycleMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
            WatchUi.pushView(new SleepCycleSetTimerPicker(), new SleepCycleSetTimerPickerDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_2) {
            WatchUi.pushView(new SleepCycleRangePicker(), new SleepCycleRangePickerDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_3){
        	WatchUi.pushView(new SleepCycleSensitivityPicker(), new SleepCycleSensitivityPickerDelegate(), WatchUi.SLIDE_UP);
        }
    }
}