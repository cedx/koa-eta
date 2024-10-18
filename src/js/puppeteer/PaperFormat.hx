package js.puppeteer;

/** Defines the valid paper format types when printing a PDF. **/
enum abstract PaperFormat(String) from String to String {

	/** The paper format is A0. **/
	var A0 = "a0";

	/** The paper format is A1. **/
	var A1 = "a1";

	/** The paper format is A2. **/
	var A2 = "a2";

	/** The paper format is A3. **/
	var A3 = "a3";

	/** The paper format is A4. **/
	var A4 = "a4";

	/** The paper format is A5. **/
	var A5 = "a5";

	/** The paper format is A6. **/
	var A6 = "a6";

	/** The paper format is Ledger. **/
	var Ledger = "ledger";

	/** The paper format is Legal. **/
	var Legal = "legal";

	/** The paper format is Letter. **/
	var Letter = "letter";

	/** The paper format is Tabloid. **/
	var Tabloid = "tabloid";
}
