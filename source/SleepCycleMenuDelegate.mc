using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;
using Toybox.Time.Gregorian;

class SleepCycleMenuDelegate extends WatchUi.MenuInputDelegate {
	var myPicker;
	var hours;
	var mins;
	var defaultValue;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
            System.println("item 1");
            //Setting up the number picker
            //If the App is started the first time we get the time we have now and set it as the default value
    		//Else we use the time that was set the last time
    		if(Storage.getValue("set_time") == null){
    			System.println("set_time is null");
    			hours = System.getClockTime().hour.toLong();
    			mins = System.getClockTime().min.toLong();
    			defaultValue = Gregorian.duration({:hours=>hours, :minutes=>mins, :seconds=>0});
    		} else {
    			System.println("set_time is set");
    			hours = Storage.getValue("timer_hoursOfDay");
        		mins = Storage.getValue("timer_minutesOfDay");
    			defaultValue = Gregorian.duration({:hours=>hours, :minutes=>mins, :seconds=>0});
    		}
    		//Starts the number picker
        	if (WatchUi has :NumberPicker) {
            	myPicker = new WatchUi.NumberPicker(WatchUi.NUMBER_PICKER_TIME_OF_DAY, defaultValue);
            	WatchUi.pushView(myPicker, new SleepCycleSetTimerNumberPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        	}
        } else if (item == :item_2) {
            System.println("item 2");
            //Watchui.pushView();
        }
    }

}