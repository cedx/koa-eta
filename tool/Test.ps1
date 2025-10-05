Write-Host "Running the test suite..."
$nodeEnvironment = $Env:NODE_ENV
$Env:NODE_ENV = "test"
npx tsc --build src/tsconfig.json --sourceMap
node --enable-source-maps --test
$Env:NODE_ENV = $nodeEnvironment
