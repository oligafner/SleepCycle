using Toybox.Application.Storage;
using Toybox.WatchUi;

class SleepCycleRangePickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var rangeInMinutes = values[0];
        Storage.setValue("rangeInMinutes", rangeInMinutes);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}