# The `ctx.renderPdf()` method
This method lets you render an [Eta](https://eta.js.org) template as a PDF document and send it as HTTP response.

```js
import {join} from "node:path";
import eta from "@cedx/koa-eta";
import Koa from "koa";

const app = new Koa;
eta(app, {views: join(import.meta.dirname, "path/to/view/folder")});

app.use(async ctx => {
  const viewData = {message: "Hello World!"};
  return ctx.renderPdf("view", viewData);
});
```

This method accepts up to three arguments, the first of which is mandatory.
Its signature is as follows:

```js
/**
 * @param {string} view - The view name.
 * @param {object} data - The data that should be made available in the view.
 * @param {Partial<PdfOptions & RenderingOptions>} renderingOptions - The rendering options.
 * @returns {Promise<import("node:buffer").Buffer>} The rendering result.
 */
async renderPdf(view, data = {}, renderingOptions = {})
```
