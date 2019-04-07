using Toybox.Application;
using Toybox.WatchUi;

class SleepCycleApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	//Storage.clearValues();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new SleepCycleMainView(), new SleepCycleMainDelegate() ];
    }

}
