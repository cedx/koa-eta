package js.puppeteer;

import haxe.extern.EitherType;
import js.html.AbortSignal;
import js.lib.Promise;
import js.lib.Uint8Array;
import js.node.events.EventEmitter;

/** Provides methods to interact with a single tab in a browser instance. **/
extern abstract class Page extends EventEmitter<Page> {

	/** Generates a PDF document of the page. **/
	function pdf(?options: PdfOptions): Promise<Uint8Array>;

	/** Sets the content of the page. **/
	function setContent(html: String, ?options: WaitForOptions): Promise<Void>;
}

/** Defines the options of the `Page.pdf()` method. **/
typedef PdfOptions = {

	/** Value indicating whether to display the header and footer. **/
	var ?displayHeaderFooter: Bool;

	/** The HTML template for the print footer. **/
	var ?footerTemplate: String;

	/** The paper format. **/
	var ?format: String;

	/** The HTML template for the print header. **/
	var ?headerTemplate: String;

	/** The paper height. **/
	var ?height: EitherType<Int, String>;

	/** Value indicating the landscape orientation. **/
	var ?landscape: Bool;

	/** The paper margins. **/
	var ?margin: {
		?bottom: EitherType<Int, String>,
		?left: EitherType<Int, String>,
		?right: EitherType<Int, String>,
		?top: EitherType<Int, String>
	};

	/** Value indicating wether to hide the default white background and allow generating PDFs with transparency. **/
	var ?omitBackground: Bool;

	/** Value indicating wether to embed the document outline into the PDF. **/
	var ?outline: Bool;

	/** The paper ranges to print. **/
	var ?pageRanges: String;

	/** The file path to save the PDF to. **/
	var ?path: String;

	/** Value indicating whether to give prority to any CSS `@page` size declared in the page. **/
	var ?preferCSSPageSize: Bool;

	/** Value indicating whether to print the background graphics. **/
	var ?printBackground: Bool;

	/** The scale of the webpage rendering. **/
	var ?scale: Float;

	/** Value indicating whether to generate tagged (accessible) PDF. **/
	var ?tagged: Bool;

	/** The timeout in milliseconds. **/
	var ?timeout: Int;

	/** Value indicating whether to wait for `document.fonts.ready` to resolve. **/
	var ?waitForFonts: Bool;

	/** The paper width. **/
	var ?width: EitherType<Int, String>;
}

/** Defines the options of the `Page.setContent()` method. **/
typedef WaitForOptions = {

	/** A signal object that allows you to cancel the call. **/
	var ?signal: AbortSignal;

	/** The maximum wait time in milliseconds. **/
	var ?timeout: Int;

	/** Value indicating when to consider the waiting succeeds. **/
	var ?waitUntil: EitherType<LifeCycleEvent, Array<LifeCycleEvent>>;
}
