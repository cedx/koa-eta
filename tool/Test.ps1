"Running the test suite..."
npx tsc --build src/tsconfig.json --sourceMap
Start-Process node "--enable-source-maps --test" -Environment @{ NODE_ENV = "test" } -NoNewWindow -Wait
