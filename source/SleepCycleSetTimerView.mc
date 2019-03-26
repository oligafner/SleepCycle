using Toybox.WatchUi;
using Toybox.Application.Storage;

class SleepCycleSetTimerView extends WatchUi.View {
	var set_time;
	var set_time_string;
	var debug_string;

    function initialize() {
        View.initialize();
        System.println("Set timer View initialized");
        debug_string = "Set a timer";
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	set_time = Storage.getValue("set_time");
        if(set_time == null){
        	set_time_string = "No Timer Set";
        } else {
        	var hours = Storage.getValue("timer_hoursOfDay");
        	System.println("hours: " + hours);
        	var mins = Storage.getValue("timer_minutesOfDay");
        	System.println("mins: " + mins);
			set_time_string = hours.format("%02d") + ":" + mins.format("%02d");
        }
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        //Draw the debug_string in the center of the screen
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, debug_string, Graphics.TEXT_JUSTIFY_CENTER);
        //Draw the set time below the center of the screen
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + 50, Graphics.FONT_LARGE, set_time_string, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}
