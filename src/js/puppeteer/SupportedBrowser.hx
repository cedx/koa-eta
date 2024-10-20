package js.puppeteer;

/** Defines the list of supported browsers. **/
enum abstract SupportedBrowser(String) from String to String {

	/** The browser is Google Chrome. **/
	var chrome = "chrome";

	/** The browser is Mozilla Firefox. **/
	var firefox = "firefox";
}
