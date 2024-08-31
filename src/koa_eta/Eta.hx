package koa_eta;

import js.Lib;
import js.eta.Config as EtaConfig;
import js.eta.Eta;
import js.lib.Object;
import js.lib.Promise;
import js.node.Buffer;
import js.playwright.Options.LaunchOptions;
import js.playwright.Options.PdfOptions;
import js.playwright.Playwright;

/**
	Attaches a view renderer to the context of the specified `application`.
	Returns the newly created view renderer.
**/
@:expose("eta")
function eta(application: Dynamic, ?rendererOptions: RendererOptions): Eta {
	final renderer = new Eta(rendererOptions);

	/** Renders the specified `view`. **/
	function render(view: String, ?data: {}, ?renderingOptions: RenderingOptions): Promise<String> {
		final self = Lib.nativeThis;
		final context = Object.assign({}, self.state, data ?? {});

		final promise = (renderingOptions?.async ?? false) ? Promise.resolve(renderer.render(view, context)) : renderer.renderAsync(view, context);
		return promise.then(html -> {
			if (renderingOptions?.writeResponse ?? true) { self.body = html; self.type = "html"; }
			html;
		});
	}

	/** Renders the specified `view` as a PDF document. **/
	function renderPdf(view: String, ?data: {}, ?renderingOptions: PdfOptions & RenderingOptions): Promise<Buffer> {
		final self = Lib.nativeThis;
		final context = Object.assign({}, self.state, data ?? {});

		final promise = (renderingOptions?.async ?? false) ? Promise.resolve(renderer.render(view, context)) : renderer.renderAsync(view, context);
		promise
			.then(html -> {
				final browser = Playwright.chromium;

				"TODO";
			});


		final promise = Promise.resolve(Buffer.from((renderingOptions?.async ?? false) ? "TODO" : "TODO"));
		return promise.then(pdf -> {
			if (renderingOptions?.writeResponse ?? true) { self.body = pdf; self.type = "pdf"; }
			pdf;
		});
	}

	Object.defineProperties(application.context, {
		render: {value: render},
		renderPdf: {value: renderPdf}
	});

	return renderer;
}

/** Defines the renderer options. **/
typedef RendererOptions = EtaConfig & {

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
