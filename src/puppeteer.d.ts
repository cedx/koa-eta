import {Buffer} from "node:buffer";
import {LaunchOptions, PDFOptions} from "puppeteer";

/**
 * Converts the specified HTML code into a PDF document.
 * @param html The HTML code to convert.
 * @param options The rendering options.
 * @returns The PDF document corresponding to the specified HTML code.
 */
export function htmlToPdf(html: string, options?: {browser?: LaunchOptions, pdf?: PDFOptions}): Promise<Buffer>;
