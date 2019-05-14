using Toybox.Application.Storage;
using Toybox.Graphics;
using Toybox.WatchUi;

class SleepCycleSetTimerPickerDelegate extends WatchUi.PickerDelegate {

	var myValue;

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	System.println("Number was picked");
        myValue = values; // myValue has type Duration
        System.println("myValue: " + myValue[0]);
        System.println("myValue: " + myValue[2]);
        var seconds_total = myValue[0]*3600 + myValue[2]*60;
        Storage.setValue("set_time", seconds_total); //Stores number of seconds since the beginning of the day
        System.println("Time was stored");
        //Calculate time out of the amount of seconds we stored
        //Hour: 3600 s; Minute: 60 s;
		var alarmInMinutes = (seconds_total / 60);
		Storage.setValue("alarmInMinutes", alarmInMinutes);
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}