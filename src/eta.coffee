import {Eta} from "eta"
import {htmlToPdf} from "./puppeteer.js"

# Attaches a view renderer to the context of the specified application.
export eta = (application, rendererOptions = {}) ->
	renderer = new Eta rendererOptions

	# Renders the specified view.
	render = (view, locals = {}, renderingOptions = {}) ->
		data = {@state..., locals...}
		html = await if renderingOptions.async then Promise.resolve renderer.render view, data else renderer.renderAsync view, data
		if renderingOptions.writeResponse ? yes
			@body = html
			@type = "html"
		html

	# Renders the specified view as a PDF document.
	renderPdf = (view, locals = {}, renderingOptions = {}) ->
		data = {@state..., locals...}
		html = await if renderingOptions.async then Promise.resolve renderer.render view, data else renderer.renderAsync view, data
		pdf = await htmlToPdf html, browser: rendererOptions.browser, pdf: renderingOptions
		if renderingOptions.writeResponse ? yes
			@body = pdf
			@type = "pdf"
		pdf

	# Attach the rendering functions to the application context.
	Object.defineProperties application.context, render: {value: render}, renderPdf: {value: renderPdf}
	renderer
