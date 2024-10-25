package koa.eta;

import js.Lib;
import js.lib.Promise;
import js.node.Buffer;
import js.puppeteer.LifeCycleEvent;
import js.puppeteer.Page.PdfOptions;
import js.puppeteer.Puppeteer;

/** Converts the specified HTML code into a PDF document. **/
function htmlToPdf(html: String, ?options: {?browser: LaunchOptions, ?pdf: PdfOptions}): Promise<Buffer>
	return Puppeteer.launch(options?.browser ?? Lib.undefined).then(browser -> browser.newPage()
		.then(page -> page.setContent(html, {waitUntil: LifeCycleEvent.Load}).then(_ -> page.pdf(options?.pdf ?? Lib.undefined)))
		.then(pdf -> browser.close().then(_ -> Buffer.from(pdf))));
