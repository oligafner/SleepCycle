using Toybox.Application.Storage;
using Toybox.WatchUi;

class SleepCycleSensitivityPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var sens = values[0];
        Storage.setValue("sensitivity", sens);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}