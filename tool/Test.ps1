Write-Host "Running the test suite..."
$environment = $Env:NODE_ENV
npx tsc --build src/tsconfig.json --sourceMap

try {
	$Env:NODE_ENV = "test"
	node --enable-source-maps --test
}
finally {
	$Env:NODE_ENV = $environment
}
