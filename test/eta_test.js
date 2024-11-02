import {equal, ok} from "node:assert/strict";
import {after, before, describe, it} from "node:test";
import app from "../example/server.js";
import pkg from "../package.json" with {type: "json"};

/**
 * Tests the features of the {@link render} and {@link renderPdf} functions.
 */
describe("eta()", () => {
	const url = new URL("http://127.0.0.1:3000/");
	const controller = new AbortController;
	before(() => app.listen({host: url.hostname, port: Number(url.port), signal: controller.signal}));
	after(() => controller.abort());

	describe("render()", () => {
		it("should have been added to the application context", () =>
			ok(typeof app.context.render == "function"));

		it("should render a view as HTML page", async () => {
			const response = await fetch(url, {headers: {accept: "text/html"}});
			equal(response.headers.get("content-type"), "text/html; charset=utf-8");
			equal(response.status, 200);

			const body = await response.text();
			console.log("body", body);
			ok(body.startsWith("<!DOCTYPE html>"));
			ok(body.includes("<title>Eta for Koa</title>"));
			ok(body.includes(`<b>${pkg.version}</b>`));
			ok(body.trimEnd().endsWith("</html>"))
		});
	});

	describe("renderPdf()", () => {
		it("should have been added to the application context", () =>
			ok(typeof app.context.renderPdf == "function"));

		it("should render a view as PDF document", async () => {
			const response = await fetch(url, {headers: {accept: "application/pdf"}});
			equal(response.headers.get("content-type"), "application/pdf");
			equal(response.status, 200);

			const body = await response.text();
			ok(body.startsWith("%PDF-"));
			ok(body.includes("/Title (Eta for Koa)"));
			ok(body.trimEnd().endsWith("%%EOF"));
		});
	});
});
