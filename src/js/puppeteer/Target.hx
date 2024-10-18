package js.puppeteer;

/** Represents a CDP target. **/
extern abstract class Target {

	/** Identifies what kind of target this is. **/
	function type(): TargetType;
}

/** Defines the CDP target types. **/
enum abstract TargetType(String) from String to String {
	var BackgroundPage = "background_page";
	var Browser = "browser";
	var Other = "other";
	var Page = "page";
	var ServiceWorker = "service_worker";
	var SharedWorker = "shared_worker";
	var WebView = "webview";
}
