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
        var alarmInMinutes = values[0]*60 + values[2];
		Storage.setValue("alarmInMinutes", alarmInMinutes);
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}