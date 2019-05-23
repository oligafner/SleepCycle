using Toybox.Application.Storage;
using Toybox.WatchUi;

class SleepCycleSetTimerPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var seconds_total = values[0]*3600 + values[2]*60;
        Storage.setValue("set_time", seconds_total); //Stores number of seconds since the beginning of the day
        //Calculate time out of the amount of seconds we stored
		var alarmInMinutes = (seconds_total / 60);
		Storage.setValue("alarmInMinutes", alarmInMinutes);
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}