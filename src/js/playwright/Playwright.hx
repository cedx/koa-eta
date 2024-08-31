package js.playwright;

import js.playwright.Browser.BrowserType;

/** Launches a browser instance. **/
@:jsRequire("playwright")
extern class Playwright {

	/** An object that can be used to launch or connect to Chromium. **/
	static final chromium: BrowserType;

	/** An object that can be used to launch or connect to Firefox. **/
	static final firefox: BrowserType;

	/** An object that can be used to launch or connect to WebKit. **/
	static final webkit: BrowserType;
}
