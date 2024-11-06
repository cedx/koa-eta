import {Buffer} from "node:buffer";
import {PDFOptions} from "puppeteer";

export * from "./eta.js";
export * from "./puppeteer.js";

/**
 * Declaration merging.
 */
declare module "koa" {

	/**
	 * The request context.
	 */
	interface ExtendableContext {

		/**
		 * Renders the specified view.
		 * @param view The view name.
		 * @param data The data that should be made available in the view.
		 * @param options The rendering options.
		 * @returns The rendering result.
		 */
		render(view: string, data?: object, options?: RenderingOptions): Promise<string>;

		/**
		 * Renders the specified view as a PDF document.
		 * @param view The view name.
		 * @param data The data that should be made available in the view.
		 * @param options The rendering options.
		 * @returns The rendering result.
		 */
		renderPdf(view: string, data?: object, options?: PDFOptions & RenderingOptions): Promise<Buffer>;
	}
}

/**
 * Defines the rendering options.
 */
export type RenderingOptions = Partial<{

	/**
	 * Value indicating whether the template is asynchronous.
	 */
	async: boolean;

	/**
	 * Value indicating whether to write the rendering result to the response.
	 */
	writeResponse: boolean;
}>;
