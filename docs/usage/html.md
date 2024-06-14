# The `ctx.render()` method
This method lets you render an [Eta](https://eta.js.org) template as a **string** and send it as HTTP response.

```js
import {join} from "node:path";
import eta from "@cedx/koa-eta";
import Koa from "koa";

const app = new Koa;
eta(app, {views: join(import.meta.dirname, "path/to/view/folder")});

app.use(async ctx => {
  const viewData = {message: "Hello World!"};
  return ctx.render("view", viewData);
});
```

!!! info
    The content type of the HTTP response will automatically be set to `text/html`.

This method accepts up to three arguments, the first of which is mandatory.
Its signature is as follows:

```js
/**
 * @param {string} view - The view name.
 * @param {object} data - The data that should be made available in the view.
 * @param {Partial<RenderingOptions>} renderingOptions - The rendering options.
 * @returns {Promise<string>} The rendering result.
 */
async render(view, data = {}, renderingOptions = {})
```

## Rendering options

### **async**: boolean = `false`
The view templates can use asynchronous expressions (i.e. `await` statements, or `.then()` calls).
When this happens, you must inform the [Eta](https://eta.js.org) engine to render the template asynchronously
by setting the `async` option to `true`.

```js
// The "view.eta" template contains asynchronous statements.
app.use(async ctx => {
  const viewData = {message: "Hello World!"};
  return ctx.render("view", viewData, {async: true});
});
```

### **writeResponse**: boolean = `true`
By default, the method will write the rendering result in the body of the HTTP response,
and set the content type as `html`.

But sometimes you'll want to leave the response body undefined and just get the final result,
or use a different content type if your view template is not in HTML format.

You can do this by setting the `writeResponse` option to `false`.

```js
// Use a different content type, such as `application/xml` for an XML view.
app.use(async ctx => {
  const viewData = {items: ["one", "two", "three"]};
  ctx.body = await ctx.render("view", viewData, {writeResponse: false});
  ctx.type = "xml";
});

// Or maybe use the rendering result to send a mail.
app.use(async ctx => {
  const {createTransport} = await import("nodemailer");
  await createTransport("smtp://user:pwd@smtp.example.com").sendMail({
    from: "foo@bar.xyz",
    to: "baz@qux.xyz",
    subject: "Hello World!",
    html: await ctx.render("view", {}, {writeResponse: false})
  });
	
  ctx.status = 204; // No content.
});
```
