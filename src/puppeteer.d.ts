import {Buffer} from "node:buffer";
import {PDFOptions, PuppeteerLaunchOptions} from "puppeteer";

/**
 * Converts the specified HTML code into a PDF document.
 * @param html The HTML code to convert.
 * @param options The rendering options.
 * @returns The PDF document corresponding to the specified HTML code.
 */
export function htmlToPdf(html: string, options?: {browser?: PuppeteerLaunchOptions, pdf?: PDFOptions}): Promise<Buffer>;
