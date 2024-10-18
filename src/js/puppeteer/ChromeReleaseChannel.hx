package js.puppeteer;

/** Defines the Chrome release channels. **/
enum abstract ChromeReleaseChannel(String) from String to String {

	/** The release channel is Chrome Stable. **/
	var Chrome = "chrome";

	/** The release channel is Chrome Beta. **/
	var ChromeBeta = "chrome-beta";

	/** The release channel is Chrome Canary. **/
	var ChromeCanary = "chrome-canary";

	/** The release channel is Chrome Dev. **/
	var ChromeDev = "chrome-dev";
}
