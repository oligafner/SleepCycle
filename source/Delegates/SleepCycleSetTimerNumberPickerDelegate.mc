using Toybox.WatchUi;
using Toybox.Application.Storage;
using Toybox.Time.Gregorian;

class SleepCycleSetTimerNumberPickerDelegate extends WatchUi.NumberPickerDelegate {
	var myValue;

    function initialize() {
        NumberPickerDelegate.initialize();
        System.println("Set timer NumberPickerDelegate initialized");
    }

    function onNumberPicked(value) {
    	System.println("Number was picked");
        myValue = value; // myValue has type Duration
        System.println("myValue: " + myValue.value());
        Storage.setValue("set_time", myValue.value()); //Stores number of seconds since the beginning of the day
        System.println("Time was stored");
        //Calculate time out of the amount of seconds we stored
        //Hour: 3600 s; Minute: 60 s;
        var seconds_total = myValue.value();
        var hours = (seconds_total / 3600);
		var mins = (seconds_total / 60 % 60);
		Storage.setValue("timer_hoursOfDay", hours);
		Storage.setValue("timer_minutesOfDay", mins);
    }
}