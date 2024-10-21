import type {Eta, EtaConfig} from "eta";
import type {default as Koa} from "koa";
import type {Buffer} from "node:buffer";
import type {PDFOptions, PuppeteerLaunchOptions} from "puppeteer";

/**
 * Defines the renderer options.
 */
export type RendererOptions = Partial<EtaConfig & {

	/**
	 * The launch options for the browser used to render PDF documents.
	 */
	browser: PuppeteerLaunchOptions
}>;

/**
 * Defines the rendering options.
 */
export type RenderingOptions = Partial<{

	/**
	 * Value indicating whether the template is asynchronous.
	 */
	async: boolean,

	/**
	 * Value indicating whether to write the rendering result to the response.
	 */
	writeResponse: boolean
}>;

/**
 * Attaches a view renderer to the context of the specified application.
 * @param application The application instance.
 * @param rendererOptions The view renderer options.
 * @returns The newly created view renderer.
 */
export function eta(application: Koa, rendererOptions?: Partial<RendererOptions>): Eta;

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
		render(view: string, data?: object, options?: Partial<RenderingOptions>): Promise<string>;

		/**
		 * Renders the specified view as a PDF document.
		 * @param view The view name.
		 * @param data The data that should be made available in the view.
		 * @param options The rendering options.
		 * @returns The rendering result.
		 */
		renderPdf(view: string, data?: object, options?: Partial<PDFOptions & RenderingOptions>): Promise<Buffer>;
	}
}
