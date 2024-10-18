package js.puppeteer;

/** Defines the list of supported browsers. **/
enum abstract SupportedBrowser(String) from String to String {

	/** Google Chrome. **/
	var chrome = "chrome";

	/** Mozilla Firefox. **/
	var firefox = "firefox";
}
