# Eta for Koa
A [Koa](https://koajs.com) view renderer based on the [Eta](https://eta.js.org) template engine.
	
## Quick start
Install the latest version of **Eta for Koa** with [npm](https://www.npmjs.com) package manager:

```shell
npm install @cedx/koa-eta
```

For detailed instructions, see the [installation guide](installation.md).

## Usage
This library provides an `eta()` function that you simply invoke by passing the instance
of your Koa application as an argument.

```js
import eta from "@cedx/koa-eta";
import Koa from "koa";

// Initialize the application.
const app = new Koa;
eta(app);
```

This function will add two new methods `render()` and `renderPdf()` to the request context,
that you can use to render [Eta](https://eta.js.org) view templates.

```js
// Render the "view.eta" template.
app.use(async ctx => {
  ctx.body = ctx.render("view");
});
```

For more information, visit the pages dedicated to each of them:

- [The `ctx.render()` method.](usage/html.md)
- [The `ctx.renderPdf()` method.](usage/pdf.md)

### Options
The `eta()` function accepts an option object as a second argument.
These options are directly passed to the `Eta` constructor.

The most important one is the `views` option that let you specify the path of the directory containing your view templates.

```js
import {join} from "node:path";
import eta from "@cedx/koa-eta";

// Initialize the template engine.
const directory = join(import.meta.dirname, "path/to/view/folder");
eta(app, {views: directory});
```

!!! warning
    The `views` option **must** be set to use the template engine.  
    Otherwise, an `EtaFileResolution` error will be raised.

Please refer to the [official Eta documentation](https://eta.js.org) for details
of [all configuration options](https://eta.js.org/docs/api/configuration).
