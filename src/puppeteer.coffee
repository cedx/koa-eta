import {Buffer} from "node:buffer"
import puppeteer from "puppeteer"

###*
# Converts the specified HTML code into a PDF document.
# @param {string} html TODO
# @param {Partial<{browser: import("puppeteer").PuppeteerLaunchOptions, pdf: import("puppeteer").PDFOptions}>} options
# @returns {Promise<Buffer>} TODO
###
export htmlToPdf = (html, options = {}) ->
	browser = await puppeteer.launch options.browser
	page = await browser.newPage()
	await page.setContent html, waitUntil: "load"
	pdf = await page.pdf options.pdf
	await browser.close()
	Buffer.from pdf
