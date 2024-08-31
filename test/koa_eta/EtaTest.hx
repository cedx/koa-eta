package koa_eta;

import js.Lib;
import js.html.AbortController;
import js.koa.Application;
import tink.Url;
import tink.http.Client;
import tink.http.Header.HeaderField;
using StringTools;

/** Tests the features of the `render()` and `renderPdf()` methods. **/
@:asserts final class EtaTest {

	/** The Koa application instance. **/
	final application: Application = Lib.require("../example/server.cjs");

	/** The controller used to shut down the server. **/
	var controller: AbortController;

	/** The server URL. **/
	final url: Url = "http://127.0.0.1:3000/";

	/** Creates a new test. **/
	public function new() {}

	/** Method invoked before after test. **/
	@:after public function after() {
		controller.abort();
		return Noise;
	}

	/** Method invoked before each test. **/
	@:before public function before() {
		controller = new AbortController();
		application.listen({host: url.host.name, port: url.host.port, signal: controller.signal});
		return Noise;
	}

	/** Tests the `render()` method. **/
	public function render() {
		// It should have been added to the application context.
		asserts.assert(Reflect.isFunction(untyped application.context.render));

		// It should render a view as HTML page.
		Client.fetch(url, {headers: [new HeaderField(ACCEPT, "text/html")]}).all().next(response -> {
			asserts.assert(response.header.statusCode == OK);
			asserts.assert(response.header.contentType().satisfies(contentType -> contentType.fullType == "text/html"));

			final body = response.body.toString();
			asserts.assert(body.startsWith("<!DOCTYPE html>"));
			asserts.assert(body.contains("<title>Eta for Koa</title>"));
			asserts.assert(body.contains('<b>${Platform.packageVersion}</b>'));
			asserts.assert(body.rtrim().endsWith("</html>"));
		}).handle(asserts.handle);

		return asserts;
	}

	/** Tests the `renderPdf()` method. **/
	public function renderPdf() {
		// It should have been added to the application context.
		asserts.assert(Reflect.isFunction(untyped application.context.renderPdf));

		// It should render a view as PDF document.
		Client.fetch(url, {headers: [new HeaderField(ACCEPT, "application/pdf")]}).all().next(response -> {
			asserts.assert(response.header.statusCode == OK);
			asserts.assert(response.header.contentType().satisfies(contentType -> contentType.fullType == "application/pdf"));

			final body = response.body.toString();
			asserts.assert(body.startsWith("%PDF-"));
			asserts.assert(body.contains("/Title (Eta for Koa)"));
			asserts.assert(body.rtrim().endsWith("%%EOF"));
		}).handle(asserts.handle);

		return asserts;
	}
}
