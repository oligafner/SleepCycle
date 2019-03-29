using Toybox.Application.Storage;
using Toybox.Graphics;
using Toybox.WatchUi;

class SleepCycleRangePickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
        System.println("PickerDelegate Initialized");
    }

    function onCancel() {
    	System.println("Picker onCancel");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	System.println("Picker onAccept");
        var range = values[0];
        System.println("data: " + range);
        Storage.setValue("range", range);
        System.println("Picker setProberty");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}