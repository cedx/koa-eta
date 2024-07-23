import {Eta} from "eta";
import type {Context, default as Koa} from "koa";
import type {Buffer} from "node:buffer";
import {chromium} from "playwright";
import type {LaunchOptions} from "playwright-core";

/**
 * Attaches a view renderer to the context of the specified application.
 * @param application The application instance.
 * @param rendererOptions The view renderer options.
 * @returns The newly created view renderer.
 */
export default function eta(application: Koa, rendererOptions: Partial<RendererOptions> = {}): Eta {
	const renderer = new Eta(rendererOptions);

	/**
	 * Renders the specified view.
	 * @param view The view name.
	 * @param data The data that should be made available in the view.
	 * @param renderingOptions The rendering options.
	 * @returns The rendering result.
	 */
	async function render(this: Context, view: string, data: object = {}, renderingOptions: Partial<RenderingOptions> = {}): Promise<string> {
		const context = {...this.state, ...data};
		const html = renderingOptions.async ? await renderer.renderAsync(view, context) : renderer.render(view, context);

		if (renderingOptions.writeResponse ?? true) {
			this.body = html;
			this.type = "html";
		}

		return html;
	}

	/**
	 * Renders the specified view as a PDF document.
	 * @param view The view name.
	 * @param data The data that should be made available in the view.
	 * @param renderingOptions The rendering options.
	 * @returns The rendering result.
	 */
	async function renderPdf(this: Context, view: string, data: object = {}, renderingOptions: Partial<PdfOptions & RenderingOptions> = {}): Promise<Buffer> {
		const context = {...this.state, ...data};
		const html = renderingOptions.async ? await renderer.renderAsync(view, context) : renderer.render(view, context);

		const browser = await chromium.launch(rendererOptions.browser);
		const page = await browser.newPage();
		await page.setContent(html, {waitUntil: "load"});
		const pdf = await page.pdf(renderingOptions);
		await browser.close();

		if (renderingOptions.writeResponse ?? true) {
			this.body = pdf;
			this.type = "pdf";
		}

		return pdf;
	}

	Object.defineProperties(application.context, {
		render: {value: render},
		renderPdf: {value: renderPdf}
	});

	return renderer;
}

/**
 * Defines the PDF rendering options.
 */
export interface PdfOptions {

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
	margin: Partial<{bottom: number|string, left: number|string, right: number|string, top: number|string}>;

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
}

/**
 * Defines the renderer options.
 */
export interface RendererOptions {

	/**
	 * Value indicating whether to XML-escape interpolations.
	 */
	autoEscape: boolean;

	/**
	 * Value indicating whether to apply a filter function to every interpolation.
	 */
	autoFilter: boolean;

	/**
	 * Configures the automatic whitespace trimming.
	 */
	autoTrim: TrimOptions|[TrimOptions, TrimOptions];

	/**
	 * The launch options for the browser used to render PDF documents.
	 */
	browser: LaunchOptions;

	/**
	 * Value indicating whether to cache the templates.
	 */
	cache: boolean;

	/**
	 * Value indicating whether to cache the resolved file paths.
	 */
	cacheFilepaths: boolean;

	/**
	 * Value indicating whether to pretty-format error messages.
	 */
	debug: boolean;

	/**
	 * The file extension of the templates.
	 */
	defaultExtension: string;

	/**
	 * The function used to XML-escape interpolations.
	 */
	escapeFunction: (value: unknown) => string;

	/**
	 * The function used to filter the interpolations.
	 */
	filterFunction: (value: unknown) => string;

	/**
	 * The raw JavaScript code to be inserted in the template functions.
	 */
	functionHeader: string;

	/**
	 * The parsing options.
	 */
	parse: {exec: string, interpolate: string, raw: string};

	/**
	 * The renderer plugins.
	 */
	plugins: Partial<{
		processAST: Function, // eslint-disable-line @typescript-eslint/no-unsafe-function-type
		processFnString: Function, // eslint-disable-line @typescript-eslint/no-unsafe-function-type
		processTemplate: Function // eslint-disable-line @typescript-eslint/no-unsafe-function-type
	}>[];

	/**
	 * Value indicating whether to remove all safe-to-remove whitespace.
	 */
	rmWhitespace: boolean;

	/**
	 * The delimiters.
	 */
	tags: [string, string];

	/**
	 * Value indicating whether to data available on the global object.
	 */
	useWith: boolean;

	/**
	 * The name of the data object.
	 */
	varName: string;

	/**
	 * The path to the directory containing the templates.
	 */
	views: string;
}

/**
 * Defines the rendering options.
 */
export interface RenderingOptions {

	/**
	 * Value indicating whether the template is asynchronous.
	 */
	async: boolean;

	/**
	 * Value indicating whether to write the rendering result to the response.
	 */
	writeResponse: boolean;
}

/**
 * Defines the automatic whitespace trimming.
 */
export type TrimOptions = false|"nl"|"slurp";
