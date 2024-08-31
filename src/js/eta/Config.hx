package js.eta;

import haxe.Constraints.Function;
import haxe.extern.EitherType;

/** The template engine configuration. **/
typedef Config = {

	/** Value indicating whether to XML-escape interpolations. **/
	var ?autoEscape: Bool;

	/** Value indicating whether to apply a filter function to every interpolation. **/
	var ?autoFilter: Bool;

	/** Configures the automatic whitespace trimming. **/
	var ?autoTrim: EitherType<Bool, EitherType<TrimConfig, Array<EitherType<Bool, TrimConfig>>>>;

	/** Value indicating whether to cache the templates. **/
	var ?cache: Bool;

	/** Value indicating whether to cache the resolved file paths. **/
	var ?cacheFilepaths: Bool;

	/** Value indicating whether to pretty-format error messages. **/
	var ?debug: Bool;

	/** The file extension of the templates. **/
	var ?defaultExtension: String;

	/** The function used to XML-escape interpolations. **/
	var ?escapeFunction: Any -> String;

	/** The function used to filter the interpolations. **/
	var ?filterFunction: Any -> String;

	/** The raw JavaScript code to be inserted in the template functions. **/
	var ?functionHeader: String;

	/** The parsing options. **/
	var ?parse: {
		exec: String,
		interpolate: String,
		raw: String
	};

	/** The renderer plugins. **/
	var ?plugins: Array<{
		?processAST: Function,
		?processFnString: Function,
		?processTemplate: Function
	}>;

	/** Value indicating whether to remove all safe-to-remove whitespace. **/
	var ?rmWhitespace: Bool;

	/** The delimiters. **/
	var ?tags: Array<String>;

	/** Value indicating whether to data available on the global object. **/
	var ?useWith: Bool;

	/** The name of the data object. **/
	var ?varName: String;

	/** The path to the directory containing the templates. **/
	var ?views: String;
}

/** Defines the automatic whitespace trimming. **/
enum abstract TrimConfig(String) from String to String {

	/** Trims a leading or trailing newline. **/
	var NewLine = "nl";

	/** Trims all leading/trailing whitespace. **/
	var Slurp = "slurp";
}
