package js.puppeteer;

/** Defines the protocol type.  **/
enum abstract ProtocolType(String) from String to String {

	/** The Chrome DevTools protocol. **/
	var Cdp = "cdp";

	/** The BiDirectional WebDriver protocol. **/
	var WebDriverBiDi = "webDriverBiDi";
}
