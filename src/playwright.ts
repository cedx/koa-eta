import {Buffer} from "node:buffer";
import {chromium} from "playwright";
import type {LaunchOptions} from "playwright-core";

/**
 * Converts the specified HTML code into a PDF document.
 * @param html The HTML code to convert.
 * @param options The rendering options.
 * @returns The PDF document corresponding to the specified HTML code.
 */
export async function htmlToPdf(html: string, options: {browser?: LaunchOptions, pdf?: PdfOptions} = {}): Promise<Buffer> {
	const browser = await chromium.launch(options.browser);
	const page = await browser.newPage();
	await page.setContent(html, {waitUntil: "load"});
	const pdf = await page.pdf(options.pdf);
	await browser.close();
	return Buffer.from(pdf);
}

/**
 * Defines the PDF rendering options.
 */
export type PdfOptions = Partial<{

	/**
	 * Value indicating whether to display the header and footer.
	 */
	displayHeaderFooter: boolean;

	/**
	 * The HTML template for the print footer.
	 */
	footerTemplate: string;

	/**
	 * The paper format.
	 */
	format: string;

	/**
	 * The HTML template for the print header.
	 */
	headerTemplate: string;

	/**
	 * The paper height.
	 */
	height: number|string;

	/**
	 * Value indicating the landscape orientation.
	 */
	landscape: boolean;

	/**
	 * The paper margins.
	 */
	margin: {bottom?: number|string, left?: number|string, right?: number|string, top?: number|string};

	/**
	 * Value indicating wether to embed the document outline into the PDF.
	 */
	outline: boolean;

	/**
	 * The paper ranges to print.
	 */
	pageRanges: string;

	/**
	 * The file path to save the PDF to.
	 */
	path: string;

	/**
	 * Value indicating whether to give prority to any CSS `@page` size declared in the page.
	 */
	preferCSSPageSize: boolean;

	/**
	 * Value indicating whether to print the background graphics.
	 */
	printBackground: boolean;

	/**
	 * The scale of the webpage rendering.
	 */
	scale: number;

	/**
	 * Value indicating whether to generate tagged (accessible) PDF.
	 */
	tagged: boolean;

	/**
	 * The paper width.
	 */
	width: number|string;
}>;
