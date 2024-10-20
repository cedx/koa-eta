package koa_eta;

import js.Lib;
import js.eta.Config;
import js.eta.Eta;
import js.koa.Application;
import js.koa.Context;
import js.lib.Object;
import js.lib.Promise;
import js.node.Buffer;
import js.puppeteer.LifeCycleEvent;
import js.puppeteer.Page.PdfOptions;
import js.puppeteer.Puppeteer;

/**
	Attaches a view renderer to the context of the specified `application`.
	Returns the newly created view renderer.
**/
@:expose("eta")
function eta(application: Application, ?rendererOptions: RendererOptions): Eta {
	final renderer = new Eta(rendererOptions);

	/** Renders the specified `view`. **/
	function render(view: String, ?data: {}, ?renderingOptions: RenderingOptions): Promise<String> {
		final context: Context = Lib.nativeThis;
		final viewData = Object.assign({}, context.state, data ?? {});

		final promise = (renderingOptions?.async ?? false) ? Promise.resolve(renderer.render(view, viewData)) : renderer.renderAsync(view, viewData);
		return promise.then(html -> {
			if (renderingOptions?.writeResponse ?? true) { context.body = html; context.type = "html"; }
			html;
		});
	}

	/** Renders the specified `view` as a PDF document. **/
	function renderPdf(view: String, ?data: {}, ?renderingOptions: PdfOptions & RenderingOptions): Promise<Buffer> {
		final context: Context = Lib.nativeThis;
		final viewData = Object.assign({}, context.state, data ?? {});

		final promise = (renderingOptions?.async ?? false) ? Promise.resolve(renderer.render(view, viewData)) : renderer.renderAsync(view, viewData);
		return promise.then(html -> Puppeteer.launch(rendererOptions.browser ?? Lib.undefined).then(browser -> browser.newPage()
			.then(page -> page.setContent(html, {waitUntil: LifeCycleEvent.Load}).then(_ -> page.pdf(renderingOptions)))
			.then(pdf -> browser.close().then(_ -> {
				final buffer = Buffer.from(pdf);
				if (renderingOptions?.writeResponse ?? true) { context.body = buffer; context.type = "pdf"; }
				buffer;
			}))
		));
	}

	Object.defineProperties(application.context, {
		render: {value: render},
		renderPdf: {value: renderPdf}
	});

	return renderer;
}

/** Defines the renderer options. **/
typedef RendererOptions = Config & {

	/** The launch options for the browser used to render PDF documents. **/
	var ?browser: LaunchOptions;
}

/** Defines the rendering options. **/
typedef RenderingOptions = {

	/** Value indicating whether the template is asynchronous. **/
	var ?async: Bool;

	/** Value indicating whether to write the rendering result to the response. **/
	var ?writeResponse: Bool;
}
