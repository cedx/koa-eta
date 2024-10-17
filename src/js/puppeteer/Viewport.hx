package js.puppeteer;

/** Represents a viewport. **/
typedef Viewport = {

	/** The device scale factor. **/
	var ?deviceScaleFactor: Float;

	/** Value indicating whether the viewport supports touch events. **/
	var ?hasTouch: Bool;

	/** The page height in CSS pixels. **/
	var ?height: Int;

	/** Value indicating whether the viewport is in landscape mode. **/
	var ?isLandscape: Bool;

	/** Value indicating whether the `meta viewport` tag is taken into account. **/
	var ?isMobile: Bool;

	/** The page width in CSS pixels. **/
	var ?width: Int;
}
