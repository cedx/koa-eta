import {Buffer} from "node:buffer";
import {PdfOptions, RenderingOptions} from "./index.js";

declare module "koa" {
	interface ExtendableContext {

		/**
		 * Renders the specified view.
		 * @param view The view name.
		 * @param data The data that should be made available in the view.
		 * @param options The rendering options.
		 * @returns The rendering result.
		 */
		render: (view: string, data?: object, options?: Partial<RenderingOptions>) => Promise<string>;

		/**
		 * Renders the specified view as a PDF document.
		 * @param view The view name.
		 * @param data The data that should be made available in the view.
		 * @param options The rendering options.
		 * @returns The rendering result.
		 */
		renderPdf: (view: string, data?: object, options?: Partial<PdfOptions & RenderingOptions>) => Promise<Buffer>;
	}
}
