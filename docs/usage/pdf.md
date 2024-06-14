# The `ctx.renderPdf()` method
This method lets you render an [Eta](https://eta.js.org) template in HTML format as a **PDF document**
and send it as HTTP response.
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
To do this, run the following command in a terminal:

```shell
npx playwright install --with-deps chromium
```

!!! tip
    You can skip this step if you prefer to use Chrome or Edge, and already have it installed on your system.

Secondly, you need to be aware that this rendering method is heavy in terms of memory consumption and CPU usage.
Your server must therefore be sufficiently sized to accept such a load.

!!! danger
    It's not suitable for high-traffic websites! It's preferable to consider setting up a caching system
    of some kind to avoid having to render the same PDF every time your server receives a request.

The `eta()` function accepts a `browser` option which is an object that is directly passed
to the [`BrowserType.launch()`](https://playwright.dev/docs/api/class-browsertype#browser-type-launch) method
provided by [Playwright](https://playwright.dev).
Use it to customize which browser will be used to render PDF documents.

```js
// Use Microsoft Edge instead of Chromium.
eta(app, {
  browser: {channel: "msedge"},
  views: join(import.meta.dirname, "path/to/view/folder")
});
```

Please refer to the [Playwright documentation](https://playwright.dev) for details
of [all configuration settings](https://playwright.dev/docs/api/class-browsertype#browser-type-launch)
supported by the `browser` option.

## Rendering options
The `ctx.renderPdf()` method supports the same options as [the `ctx.render()` method](html.md) (i.e. `async` and `writeResponse`).
