import {htmlToPdf} from "./puppeteer.js"

###*
# Attaches a view renderer to the context of the specified application.
# @param {import("koa")} application The application instance.
# @param {Partial<import("eta").EtaConfig & {browser: import("puppeteer").PuppeteerLaunchOptions}>} rendererOptions The view renderer options.
# @returns {import("eta").Eta} The newly created view renderer.
###
export eta = (application, rendererOptions = {}) ->
	renderer = new Eta rendererOptions

	# Renders the specified view.
	render = (view, data = {}, renderingOptions = {}) ->
		viewData = Object.assign {}, @state, data
		html = await if renderingOptions.async then Promise.resolve renderer.render view, viewData else renderer.renderAsync view, viewData
		if renderingOptions.writeResponse
			@body = html
			@type = "html"
		html

	# Renders the specified view as a PDF document.
	renderPdf = (view, data = {}, renderingOptions = {}) ->
		viewData = Object.assign {}, @state, data
		html = await if renderingOptions.async then Promise.resolve renderer.render view, viewData else renderer.renderAsync view, viewData
		pdf = await htmlToPdf(html, {browser: rendererOptions.browser, pdf: renderingOptions})
		if renderingOptions.writeResponse
			@body = pdf
			@type = "pdf"
		pdf

	# Attach the rendering functions to the application context.
	Object.defineProperties application.context, render: {value: render}, renderPdf: {value: renderPdf}
	renderer
