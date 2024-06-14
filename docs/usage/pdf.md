# The `ctx.renderPdf()` method
This method lets you render an [Eta](https://eta.js.org) template as a **PDF document** and send it as HTTP response.
Its signature and use is basically the same as [the `ctx.render()` method](html.md).

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

!!! info
    The content type of the HTTP response will automatically be set to `application/pdf`.

## Rendering options
The `renderPdf()` method supports the same options as [the `ctx.render()` method](html.md) (i.e. `async` and `writeResponse`).
