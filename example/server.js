import {join} from "node:path";
import eta from "@cedx/koa-eta";
import Koa from "koa";
import pkg from "../package.json" with {type: "json"};

// Initialize the Koa application.
const app = new Koa;

// Configure the view renderer.
eta(app, {
	cache: app.env == "production",
	debug: app.env != "production",
	views: join(import.meta.dirname, "../res")
});

// Configure the request state.
app.use((ctx, next) => {
	Object.assign(ctx.state, {address: ctx.ip, version: pkg.version});
	return next();
});

// Render the view as HTML or PDF depending on content negotiation.
app.use(ctx => {
	const items = [{name: "Arthion Xyrlynn"}, {name: "Elen Naenan"}, {name: "Paeris Xilmenor"}];
	return ctx.accepts("pdf") ? ctx.renderPdf("main", {items}) : ctx.render("main", {items});
});

// Start the application.
if (app.env != "test")
	app.listen(3000, "127.0.0.1", () => console.log("Server listening on http://127.0.0.1:3000..."));

export default app;
