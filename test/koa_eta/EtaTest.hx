package koa_eta;

import tink.http.Header.HeaderField;
import js.Lib;
import js.html.AbortController;
import js.koa.Application;
import tink.Url;
import tink.http.Client;
using StringTools;

/** Tests the features of the `eta` factory. **/
@:asserts final class EtaTest {

	/** The Koa application instance. **/
	final application: Application = Lib.require("../example/server.cjs");

	/** The controller used to shut down the server. **/
	final controller = new AbortController();

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
		application.listen({host: url.host.name, port: url.host.port, signal: controller.signal});
		return Noise;
	}

	/** Tests the `render()` method. **/
	public function render() {
		// It should have been added to the application context.
		asserts.assert(Reflect.isFunction(untyped application.context.render));

		// It should render a view as HTML page.
		Client.fetch(url, {headers: [new HeaderField(ACCEPT, "text/html")]}).all()
			.next(response -> {
				asserts.assert(response.header.contentType().satisfies(contentType -> contentType.fullType == "text/html"));
				asserts.assert(response.header.statusCode == OK);

				final body = response.body.toString();
				asserts.assert(body.startsWith("<!DOCTYPE html>"));
				asserts.assert(body.contains("<title>Eta for Koa</title>"));
				asserts.assert(body.contains('<b>${Platform.packageVersion}</b>'));
				asserts.assert(body.rtrim().endsWith("</html>"));
			})
			.handle(asserts.handle);

		return asserts;
	}
}
