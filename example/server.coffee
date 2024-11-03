import {eta} from "@cedx/koa-eta"
import Koa from "koa"
import console from "node:console"
import {join} from "node:path"

# Initialize the Koa application.
app = new Koa

# Configure the view renderer.
eta app,
	cache: app.env is "production"
	debug: app.env isnt "production"
	views: join import.meta.dirname, "../res"

# Configure the data shared by all views.
app.use (ctx, next) ->
	pkg = await import("../package.json", with: {type: "json"})
	Object.assign ctx.state, version: pkg.default.version
	next()

# Render the view as HTML or PDF depending on content negotiation.
app.use (ctx) ->
	items = [{name: "Arthion Xyrlynn"}, {name: "Elen Naenan"}, {name: "Paeris Xilmenor"}]
	if ctx.accepts "pdf" then ctx.renderPdf "main", {items} else ctx.render "main", {items}

# Start the application.
app.listen(3000, "127.0.0.1", -> console.log "Server listening on http://127.0.0.1:3000...") unless app.env is "test"
export default app;
