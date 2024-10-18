package js.puppeteer;

/** A value indicating when to consider the waiting succeeds. **/
enum abstract LifeCycleEvent(String) from String to String {

	/** Waits for the "DOMContentLoaded" event. **/
	var DomContentLoaded = "domcontentloaded";

	/** Waits for the "load" event. **/
	var Load = "load";

	/** Waits till there are no more than 0 network connections for at least 500 milliseconds. **/
	var NetworkIdle0 = "networkidle0";

	/** Waits till there are no more than 2 network connections for at least 500 milliseconds. **/
	var NetworkIdle2 = "networkidle2";
}
