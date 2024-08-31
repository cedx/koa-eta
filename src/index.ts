import {Eta} from "eta";
import type {Context, default as Koa} from "koa";
import type {Buffer} from "node:buffer";
import {chromium} from "playwright";

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
