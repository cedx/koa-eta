import {Eta, EtaConfig} from "eta";
import {default as Koa} from "koa";
import {PuppeteerLaunchOptions} from "puppeteer";

/**
 * Attaches a view renderer to the context of the specified application.
 * @param application The application instance.
 * @param options The renderer options.
 * @returns The newly created view renderer.
 */
export function eta(application: Koa, options?: RendererOptions): Eta;

/**
 * Defines the renderer options.
 */
export type RendererOptions = Partial<EtaConfig & {

	/**
	 * The launch options for the browser used to render PDF documents.
	 */
	browser: PuppeteerLaunchOptions;
}>;
