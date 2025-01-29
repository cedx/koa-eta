import {Eta} from "eta";
import type {default as Koa, Context} from "koa";
import type {PdfOptions, RendererOptions, RenderingOptions} from "./options.js";
import {htmlToPdf} from "./playwright.js";

/**
 * Attaches a view renderer to the context of the specified application.
 * @param application The application instance.
 * @param options The renderer options.
 * @returns The newly created view renderer.
 */
export function eta(application: Koa, rendererOptions: RendererOptions = {}): Eta {
	const renderer = new Eta(rendererOptions);

	/**
	 * Renders the specified view.
	 * @param view The view name.
	 * @param locals The data that should be made available in the view.
	 * @param renderingOptions The rendering options.
	 * @returns The rendering result.
	 */
	async function render(this: Context, view: string, locals: object = {}, renderingOptions: RenderingOptions = {}): Promise<string> {
		const data = {...this.state, ...locals};
		const html = await (renderingOptions.async ? renderer.renderAsync(view, data) : Promise.resolve(renderer.render(view, data)));

		if (renderingOptions.writeResponse ?? true) {
			this.body = html;
			this.type = "html";
		}

		return html;
	}

	/**
	 * Renders the specified view as a PDF document.
	 * @param view The view name.
	 * @param locals The data that should be made available in the view.
	 * @param renderingOptions The rendering options.
	 * @returns The rendering result.
	 */
	async function renderPdf(this: Context, view: string, locals: object = {}, renderingOptions: PdfOptions & RenderingOptions = {}): Promise<Buffer> {
		const data = {...this.state, ...locals};
		const html = await (renderingOptions.async ? renderer.renderAsync(view, data) : Promise.resolve(renderer.render(view, data)));

		const pdf = await htmlToPdf(html, {browser: rendererOptions.browser, pdf: renderingOptions});
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
