const {eta} = require("@cedx/koa-eta");
const Koa = require("koa");
const console = require("node:console");
const {join} = require("node:path");
const pkg = require("../package.json");

// Initialize the Koa application.
const app = new Koa;

// Configure the view renderer.
eta(app, {
	cache: app.env == "production",
	debug: app.env != "production",
	views: join(__dirname, "../res")
});

// Configure the data shared by all views.
app.use((ctx, next) => {
	Object.assign(ctx.state, {version: pkg.version});
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

module.exports = app;
