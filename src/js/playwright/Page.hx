package js.playwright;

import haxe.extern.EitherType;
import js.lib.Promise;
import js.node.Buffer;

/** Provides methods to interact with a single tab in a browser instance. **/
extern interface Page {

	/** Generates a PDF document of the page. **/
	function pdf(?options: PdfOptions): Promise<Buffer>;

	/** Calls the [`document.write()`](https://developer.mozilla.org/docs/Web/API/Document/write) method. **/
	function setContent(html: String, ?options: ContentOptions): Promise<Void>;
}

/** Defines the options of the `Page.setContent()` method. **/
typedef ContentOptions = {

	/** The maximum operation time in milliseconds. **/
	var ?timeout: Int;

	/** Value indicating when to consider the operation succeeded. **/
	var ?waitUntil: WaitUntil;
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

	/** The paper width. **/
	var ?width: EitherType<Int, String>;
}

/** A value indicating when to consider an operation succeeded. **/
enum abstract WaitUntil(String) from String to String {

	/** Considers the operation to be finished when network response is received and the document started loading. **/
	var Commit = "commit";

	/** Considers the operation to be finished when the `DOMContentLoaded` event is fired. **/
	var DomContentLoaded = "domcontentloaded";

	/** Considers the operation to be finished when the `load` event is fired. **/
	var Load = "load";

	/** Considers the operation to be finished when there are no network connections for at least 500 milliseconds. **/
	var NetworkIdle = "networkidle";
}
