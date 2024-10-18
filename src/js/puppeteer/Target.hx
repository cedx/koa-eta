package js.puppeteer;

/** Represents a CDP target. **/
extern abstract class Target {

	/** Identifies what kind of target this is. **/
	function type(): TargetType;
}

/** Defines the CDP target types. **/
enum abstract TargetType(String) from String to String {

	/** The target is a backgroudn page. **/
	var BackgroundPage = "background_page";

	/** The target is a browser. **/
	var Browser = "browser";

	/** The target is something else. **/
	var Other = "other";

	/** The target is a page. **/
	var Page = "page";

	/** The target is a service worker. **/
	var ServiceWorker = "service_worker";

	/** The target is a shared worker. **/
	var SharedWorker = "shared_worker";

	/** The target is a web view. **/
	var WebView = "webview";
}
