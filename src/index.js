import {Eta} from "eta";
import {chromium} from "playwright";

/**
 * Attaches a view renderer to the context of the specified application.
 * @param {import("koa")} application The application instance.
 * @param {Partial<RendererOptions>} rendererOptions The view renderer options.
 * @returns {Eta} The newly created view renderer.
 */
export default function eta(application, rendererOptions = {}) {
	const renderer = new Eta(rendererOptions);

	/**
	 * Renders the specified view.
	 * @param {string} view The view name.
	 * @param {object} data The data that should be made available in the view.
	 * @param {Partial<RenderingOptions>} renderingOptions The rendering options.
	 * @returns {Promise<string>} The rendering result.
	 * @this {import("koa").Context} The request context.
	 */
	application.context.render = async function render(view, data = {}, renderingOptions = {}) {
		const context = {...this.state, ...data};
		const html = renderingOptions.async ? await renderer.renderAsync(view, context) : renderer.render(view, context);

		if (renderingOptions.writeResponse ?? true) {
			this.body = html;
			this.type = "html";
		}

		return html;
	};

	/**
	 * Renders the specified view as a PDF document.
	 * @param {string} view The view name.
	 * @param {object} data The data that should be made available in the view.
	 * @param {Partial<PdfOptions & RenderingOptions>} renderingOptions The rendering options.
	 * @returns {Promise<import("node:buffer").Buffer>} The rendering result.
	 * @this {import("koa").Context} The request context.
	 */
	application.context.renderPdf = async function renderPdf(view, data = {}, renderingOptions = {}) {
		const browser = await chromium.launch(rendererOptions.browser);
		const page = await browser.newPage();

		const context = {...this.state, ...data};
		await page.setContent(renderingOptions.async ? await renderer.renderAsync(view, context) : renderer.render(view, context), {waitUntil: "load"});
		const pdf = await page.pdf(renderingOptions);
		await browser.close();

		if (renderingOptions.writeResponse ?? true) {
			this.body = pdf;
			this.type = "pdf";
		}

		return pdf;
	};

	return renderer;
}

/**
 * Defines the PDF rendering options.
 * @typedef {object} PdfOptions
 * @property {boolean} displayHeaderFooter Value indicating whether to display the header and footer.
 * @property {string} footerTemplate The HTML template for the print footer.
 * @property {string} format The paper format.
 * @property {string} headerTemplate The HTML template for the print header.
 * @property {number|string} height The paper height.
 * @property {boolean} landscape Value indicating the landscape orientation.
 * @property {Partial<{bottom: number|string, left: number|string, right: number|string, top: number|string}>} margin The paper margins.
 * @property {boolean} outline Value indicating wether to embed the document outline into the PDF.
 * @property {string} pageRanges The paper ranges to print.
 * @property {string} path The file path to save the PDF to.
 * @property {boolean} preferCSSPageSize Value indicating whether to give prority to any CSS `@page` size declared in the page.
 * @property {boolean} printBackground Value indicating whether to print the background graphics.
 * @property {number} scale The scale of the webpage rendering.
 * @property {boolean} tagged Value indicating whether to generate tagged (accessible) PDF.
 * @property {number|string} width The paper width.
 */

/**
 * Defines the renderer options.
 * @typedef {object} RendererOptions
 * @property {boolean} autoEscape Value indicating whether to XML-escape interpolations.
 * @property {boolean} autoFilter Value indicating whether to apply a filter function to every interpolation.
 * @property {TrimOptions|[TrimOptions, TrimOptions]} autoTrim Configures the automatic whitespace trimming.
 * @property {import("playwright-core").LaunchOptions} browser The launch options for the browser used to render PDF documents.
 * @property {boolean} cache Value indicating whether to cache the templates.
 * @property {boolean} cacheFilepaths Value indicating whether to cache the resolved file paths.
 * @property {boolean} debug Value indicating whether to pretty-format error messages.
 * @property {string} defaultExtension The file extension of the templates.
 * @property {(value: unknown) => string} escapeFunction The function used to XML-escape interpolations.
 * @property {(value: unknown) => string} filterFunction The function used to filter the interpolations.
 * @property {string} functionHeader  The raw JavaScript code to be inserted in the template functions.
 * @property {{exec: string, interpolate: string, raw: string}} parse The parsing options.
 * @property {Partial<{processAST: Function, processFnString: Function, processTemplate: Function}>[]} plugins The renderer plugins.
 * @property {boolean} rmWhitespace Value indicating whether to remove all safe-to-remove whitespace.
 * @property {[string, string]} tags The delimiters.
 * @property {boolean} useWith Value indicating whether to data available on the global object.
 * @property {string} varName The name of the data object.
 * @property {string} views The path to the directory containing the templates.
 */

/**
 * Defines the rendering options.
 * @typedef {object} RenderingOptions
 * @property {boolean} async Value indicating whether the template is asynchronous.
 * @property {boolean} writeResponse Value indicating whether to write the rendering result to the response.
 */

/**
 * Defines the automatic whitespace trimming.
 * @typedef {false|"nl"|"slurp"} TrimOptions
 */
