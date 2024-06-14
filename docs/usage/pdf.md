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

## Setup
To render view templates as PDF documents, this library relies on the [Playwright](https://playwright.dev) project
and the [Chromium](https://www.chromium.org/Home) web browser (or a derivative
such as [Google Chrome](https://www.google.com/chrome) or [Microsoft Edge](https://www.microsoft.com/edge)).

What does this mean? First of all, you need to make sure that Chromium is correctly installed.
To do this, simply run the following command in a terminal:

```shell
npx playwright install --with-deps chromium
```

!!! tip
    You can skip this step if you prefer to use Chrome or Edge, and already have it installed on your system.

Secondly, you need to be aware that this rendering method is heavy in terms of memory consumption and CPU usage.

It is not suitable for high-traffic websites! It is therefore preferable to consider setting up
a caching system of some kind to avoid having to render the PDF every time your server receives a request.

## Rendering options
The `ctx.renderPdf()` method supports the same options as [the `ctx.render()` method](html.md) (i.e. `async` and `writeResponse`).
