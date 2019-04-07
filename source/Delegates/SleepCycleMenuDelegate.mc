using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;
using Toybox.Time.Gregorian;
using Toybox.Communications;

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
            WatchUi.pushView(new SleepCycleRangePicker(), new SleepCycleRangePickerDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_3) {
            System.println("item 3");
            makeRequest();
        } else if (item == :item_4) {
            System.println("item 4");
            if (Attention has :playTone) {
   				Attention.playTone(Attention.TONE_TIME_ALERT);
			}
        }
        
    }
    
    function makeRequest() {
    	var url = "https://api.lifx.com/v1/lights/d073d5010de1/toggle";
       	var params = {};
		var options = {           
			:method => Communications.HTTP_REQUEST_METHOD_POST,
			:headers => {"Authorization" => "Bearer c6c6347d1e0c152cb5e765093831af9e6c2fcd840d5400915d9a75e65810abe8"}
		};
		var responseCallback = method(:onReceive);

		Communications.makeWebRequest(url, params, options, method(:onReceive));
	}
	
	
	function onReceive(responseCode, data) {
        if (responseCode == 207) {
            System.println("Sucessful enlightment!");
        } else {
            System.println(responseCode.toString());
        }
    }

}