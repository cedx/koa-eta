import {equal, ok} from "node:assert/strict"
import {createServer} from "node:http"
import {after, before, describe, it} from "node:test"
import app from "../example/server.js"

# Tests the features of the `render()` and `renderPdf()` functions.
describe "eta()", ->
	controller = new AbortController
	after -> controller.abort()

	server = createServer app.callback()
	url = new URL "http://127.0.0.1:0/"
	before -> new Promise (resolve) -> server.listen host: url.hostname, port: Number(url.port), signal: controller.signal, ->
		{address, port} = server.address()
		url = new URL "http://#{address}:#{port}/"
		resolve()

	describe "render()", ->
		it "should have been added to the application context", ->
			ok typeof app.context.render is "function"

		it "should render a view as HTML page", ->
			response = await fetch url, headers: {accept: "text/html"}
			equal response.headers.get("content-type"), "text/html; charset=utf-8"
			equal response.status, 200

			body = await response.text()
			{default: {version}} = await import("../package.json", with: {type: "json"})
			ok body.startsWith "<!DOCTYPE html>"
			ok body.includes "<title>Eta for Koa</title>"
			ok body.includes "<b>#{version}</b>"
			ok body.trimEnd().endsWith "</html>"

	describe "renderPdf()", ->
		it "should have been added to the application context", ->
			ok typeof app.context.renderPdf is "function"

		it "should render a view as PDF document", ->
			response = await fetch url, headers: {accept: "application/pdf"}
			equal response.headers.get("content-type"), "application/pdf"
			equal response.status, 200

			body = await response.text()
			ok body.startsWith "%PDF-"
			ok body.includes "/Title (Eta for Koa)"
			ok body.trimEnd().endsWith "%%EOF"
