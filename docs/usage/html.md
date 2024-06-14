# The `ctx.render()` method
This method lets you render an [Eta](https://eta.js.org) template as a string and send it as HTTP response.

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
