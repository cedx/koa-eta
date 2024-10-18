package js.puppeteer;

/** Defines the Chrome release channels. **/
enum abstract ChromeReleaseChannel(String) from String to String {
	var Chrome = "chrome";
	var ChromeBeta = "chrome-beta";
	var ChromeCanary = "chrome-canary";
	var ChromeDev = "chrome-dev";
}
