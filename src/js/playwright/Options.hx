package js.playwright;

import haxe.extern.EitherType;

/** TODO **/
typedef LaunchOptions = {}

/** TODO. **/
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
