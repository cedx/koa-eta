import tink.testrunner.Reporter.AnsiFormatter;
import tink.testrunner.Reporter.BasicReporter;
import tink.testrunner.Runner;
import tink.unit.TestBatch;

/** Runs the test suite. **/
function main() {
	ANSI.stripIfUnavailable = false;
	Runner
		.run(TestBatch.make([new koa.eta.EtaTest()]), new BasicReporter(new AnsiFormatter()))
		.handle(Runner.exit);
}