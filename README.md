[![License](https://img.shields.io/badge/license-GPLv3-orange)](./LICENSE)
![Release Build](https://img.shields.io/github/workflow/status/mavriq-dev/Mavriq_Lua_Batteries/Build?label=Build)
![Code Size](https://img.shields.io/github/languages/code-size/mavriq-dev/Mavriq_Lua_Batteries)
![Repo Size](https://img.shields.io/github/repo-size/mavriq-dev/Mavriq_Lua_Batteries)
![Release Ver](https://img.shields.io/github/v/release/mavriq-dev/Mavriq_Lua_Batteries)
![PreRelease Ver](https://img.shields.io/github/v/release/mavriq-dev/Mavriq_Lua_Batteries?include_prereleases)
# Mavirq Lua Batteries

### Details
Scripters have had difficulties using Lua modules with REAPER due to a variety of reasons. This project aims to fix that by making the most common and useful modules available in one package. It follows the approached used by the popular Lua Batteries package available on some platforms.

### Using the Library
Include the following at the top of your script.
```
dofile( reaper.GetResourcePath() ..
   "/Scripts/Mavriq ReaScript Repository/Various/Mavriq Lua Batteries/batteries_header.lua")
```
You can then call the libraries via require statements: ```require("socket.core")```

### Documentation
There is documentation available for each included library under the doc folder. There are also example test files for many under the tests folder.

### Included Modules
#### Mavriq Library
Some utility functions for quickly printing tables and formatted strings to the console.

#### BinaryHeap
Binaryheap is an implementation of the Binary Heap to B-Tree sorting algorithm. Some common uses are for:

* Priority Queues
* Graph Algorithms: Dijkstra's shortest path, Prim's Minimum Spanning Tree
* Solving: largest element in an array, Sort an array, Merge sorted arrays
* Get min or max element

#### Cffi-lua
![Cffi](https://i.postimg.cc/sf7t9Htj/cffi.png)
This allows all sorts of fun things from lua:
* call any function from any library. 
* Execute C code on the fly
* Execute Machine Code on the fly

One of the most powerful tools in Mavriq Lua Batteries. Besides examples in the cffi-lua docs you can look for cffi (python) and luajit ffi as they are very similar interfaces based on libffi.

#### Copas
Copas is a dispatcher based on coroutines that can be used for asynchronous networking. For example TCP or UDP based servers. But it also features timers and client support for http(s), ftp and smtp requests.

It uses LuaSocket as the interface with the TCP/IP stack and LuaSec for ssl support.

It has several high level duplicates of http(s), ftp, smtp functions from lusockets/luasec but are handled asynchronously.

It also makes creating network servers much easier buy handling the esoteric elements for you. Xavante uses copas to create its http server.

#### dkjson
This is a JSON module written in Lua. It supports UTF-8.

JSON (JavaScript Object Notation) is a format for serializing data based on the syntax for JavaScript data structures. It is an ideal format for transmitting data between different applications and commonly used for dynamic web pages. It can also be used to save Lua data structures, but you should be aware that not every Lua table can be represented by the JSON standard. For example tables that contain both string keys and an array part cannot be exactly represented by JSON. You can solve this by putting your array data in an explicit subtable.

dkjson is written in Lua without any dependencies, but when LPeg is available dkjson can use it to speed up decoding.

#### Lbase64
Pure Lua base64 encoder/decoder.

#### Librs232
Multiplatform library for serial communications over RS-232 (serial port). Great for things that are controlled via a com port.

#### Lpeg
![Lpeg](https://i.postimg.cc/NFqZvRrv/lpeg.png)
LPeg is a new pattern-matching library for Lua, based on Parsing Expression Grammars (PEGs).

Lpeg expressions are much like regular expressions in their power. LPeg uses "first-class" patterns which allow better documentation (as it is easy to comment the code, to break complex definitions in smaller parts, etc.) and are extensible, as we can define new functions to create and compose patterns.

#### Lrexlib-pcre
Regular expression library on PCRE API.

#### Lua-curl
Provides curl like functions to lua. Fetch web pages, files etc. Post HTML forms, File uploads. Can do multiple files at once.

#### Lua-cjson
The Lua CJSON module provides JSON support for Lua.

Features
* Fast, standards compliant encoding/parsing routines
* Full support for JSON with UTF-8, including decoding surrogate pairs
* Optional run-time support for common exceptions to the JSON specification (infinity, NaN,..)
* No dependencies on other libraries

Caveats
* UTF-16 and UTF-32 are not supported

#### Luaexpat
LuaExpat is a SAX XML parser based on the Expat library.

#### Luafilesystem
The missing file system functions for lua: chdir, currentdir, dir iterators, symlinks, mkdir, rmdir, file attributes, etc

#### Luafun
Lua Fun provides a set of more than 50 programming primitives typically found in languages like Standard ML, Haskell, Erlang, JavaScript, Python and even Lisp. High-order functions such as map, filter, reduce, zip, etc., make it easy to write simple and efficient functional code.

#### Lua-LXSH
LXSH is a collection of [lexers] lexing and [syntax highlighters] highlighting written in Lua using the excellent pattern-matching library LPeg. Several syntax's are currently supported: Lua, C, BibTeX and shell script. The syntax highlighters support three output formats: HTML html designed to be easily embedded in web pages, LaTeX latex which can be used to generate high quality PDF files and RTF rtf which can be used in graphical text editors like Microsoft Word and LibreOffice (formerly OpenOffice). Three predefined color schemes are included. Here are some examples of the supported input languages, output formats and color schemes:

#### Lua-Protobuffers
Protocol buffers are Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data – think XML, but smaller, faster, and simpler. You define how you want your data to be structured once, then you can use special generated source code to easily write and read your structured data to and from a variety of data streams and using a variety of languages.

This project offers a C module manipulating Google's protobuf protocol, both for version 2 and 3 syntax and semantics. It splits to the lower-level and the high-level parts for different goals.

#### Luasec
![Luasec](https://i.postimg.cc/rpXmbrZ5/socketsmedly.png)
LuaSec is a binding for OpenSSL library to provide TLS/SSL communication. It takes an already established TCP connection and creates a secure session between the peers. It builds upon Luasocket to deliver networking with security.

#### LuaSocket
LuaSocket is a Lua extension library that is composed by two parts: a C core that provides support for the TCP and UDP transport layers, and a set of Lua modules that add support for functionality commonly needed by applications that deal with the Internet.

The included lua modules are: SMTP, HTTP, FTP. Also there is MIME for common encodings, URL for url manipulation and LTN12 for filters, sinks, sources and pumps. LTN12 is particularly useful and a good description of its uses can be found on the [lua-wiki](http://lua-users.org/wiki/FiltersSourcesAndSinks). It can be very useful outside of networking when working with larger data.

#### Luasql
LuaSQL is a simple interface from Lua to a DBMS. It enables a Lua program to:

Connect to ODBC, ADO, Oracle, MySQL, SQLite, Firebird and PostgreSQL databases;
Execute arbitrary SQL statements;
Retrieve results in a row-by-row cursor fashion.

If you need to connect to a db with lua, this is the one.

Features include:
* Normalisation of broken down date objects
* allows for complex time/date manipulation logic e.g. "What day is it in 2 days, 5 hours from now?"
* `strftime` style formatting
* timezone arithmetic (linux only)

#### Lua-zip
![Luazip](https://i.postimg.cc/VkbvDRgY/zip.png)
A full service inflate/deflate library built on the libzip library.

#### Lustache
lustache is an implementation of the mustache template system in Lua. Takes a "form/template" and combines it with data. This "form" could be HTML, config files, source code or anything else that where you need to replace placeholders with data.

#### lyaml
LibYAML binding for Lua, with a fast C implementation for converting between %YAML 1.1 and Lua tables, and a low-level YAML event parser for implementing more intricate YAML document loading.

#### MD5
This pure-Lua module computes md5 in Lua.

#### Middleclass
This library is for adding class like behavior to lua. There is not much documentation but a [Wikipedia](https://fo.wikipedia.org/wiki/Module:Middleclass) page has a reasonable overview. 

#### Moses
Does everything but part the red sea. Massive utilities for tables are arrays. If you work with either, this has everything not includes by default in lua.

#### Penlight
![Penlight](https://i.postimg.cc/zBqfD1rB/penlight.png)
This is a must have library for lua. 
* Tables and Arrays
* Strings
* Paths an Directories
* Date and Time
* Data
* Functional Programming
* Classes
* Testing Framework

If you program in lua, you need to know this library.

#### Rings
Rings offers a single function which creates a new Lua state and returns an object representing it. The state which creates other states is called the master and the created ones are called slaves. The master can execute code in any of its slaves but each slave only has direct access to its master (or its own slaves).

All standard Lua libraries are opened automatically in a new state; other libraries have to be loaded explicitly.

The object representing a slave state has a method (dostring) which can execute Lua code in the corresponding state. This method can receive arguments (only numbers, strings, booleans and userdata, which are converted to lightuserdata) and always returns a boolean indicating whether the code executed correctly or not, followed by eventual return values or an error message.

#### Serpent
Lua serializer and pretty printer.

Features
* Human readable:
	* Provides single-line and multi-line output.
	* Nested tables are properly indented in the multi-line output.
	* Numerical keys are listed first.
	* Keys are (optionally) sorted alphanumerically.
	* Array part skips keys ({'a', 'b'} instead of {[1] = 'a', [2] = 'b'}).
	* nil values are included when expected ({1, nil, 3} instead of {1, [3]=3}).
	* Keys use short notation ({foo = 'foo'} instead of {['foo'] = 'foo'}).
	* Shared references and self-references are marked in the output.
* Machine readable: provides reliable deserialization using loadstring().
* Supports deeply nested tables.
* Supports tables with self-references.
* Keeps shared tables and functions shared after de/serialization.
* Supports function serialization using string.dump().
* Supports serialization of global functions.
* Supports __tostring and __serialize metamethods.
* Escapes new-line \010 and end-of-file control \026 characters in strings.
* Configurable with options and custom formatters.*

#### Stdlib
![Stdlib](https://i.postimg.cc/d32psD8k/stdlib.png)
A large collection of useful functions. Many extend existing lua functions and other bring new Classes such a tree, container, object, list, optparse, set, and strbuf.

#### Timerwheel
Can create times that run a callback function when they expire. 

#### Vstruct
A library for packing and unpacking binary data. If you've used lpack, struct, or the string.pack built into 5.3, you're already familiar with the concept. It's written in pure Lua and supports a variety of advanced features.

  * Signed and unsigned integers, strings (fixed-width, null-
    terminated, and length-prefixed), fixed and floating point values,
    bitmasks, and booleans.
  * Bit-packed versions of most of these (e.g. four 4-bit ints packed
    into 16 bits).
  * Arbitrary sizes, such as 24-bit ints or 128-bit bitfields; it's not
    limited to C types.
  * Big and little endian data.
  * Widechar strings.
  * Operations on both files and strings.
  * Written entirely in Lua; runs anywhere Lua 5.1 or 5.2 do, and has
    no external dependencies.

And vstruct's "killer feature":

  * Named fields and support for repetition and nested structs, allowing
    you to describe not just the format on disk of your data, but how it
    should be shaped once loaded into Lua.

#### wxLua
![wxlua](https://i.postimg.cc/k5Q4dgLz/wxmedly.png)

wxLua is a Lua wrapper for the cross-platform wxWidgets GUI library. It allows developers to create applications for Windows, macOS, and Linux using Lua. Unlike other cross-platform toolkits, wxWidgets (and by extension wxlua) gives applications a native look and feel as it uses the platform's native API rather than emulating the GUI.


#### Xavante
Xavante is a Lua HTTP 1.1 Web server that uses a modular architecture based on URI mapped handlers. Xavante currently offers a file handler, a redirect handler and a WSAPI handler. Those are used for general files, URI remapping and WSAPI applications respectively

#### ZipWriter
A library for working with Zip files.


### Background
Reaper is missing exports of LUA C functions as it is built statically. As such things such as the luasockets library etc will not work. If loaded they will throw an error complaining of missing symbols when the library tries to access them.

It isn't practical to change how REAPER is built to address this. As such there are a couple of workarounds.

The first is to build lua in statically to each module. This is the approach used in [Mavriq Lua Sockets](https://github.com/mavriq-dev/mavriq-lua-sockets). This works ok, but takes a lot of work to specifically craft each binary.

The second is to dynamically load the lua functions from the lua interpreter. Lua must be built as a dynamic library. To load it we use a call something like this:

```
assert(package.loadlib( "liblua.so","*"))
```

The module specified in the first argument must be the full path. The `*` in the second argument tells lua to load the entire library and load it into the script space. You can call individual functions as well by specifying one there and the call will return the function:

```
fn = assert(package.loadlib( "liblua.so","some_function"))
```

### Binaries
You can find builds under releases on [GitHub], or you can install via [ReaPack](https://github.com/mavriq-dev/public-reascripts/raw/master/index.xml).

https://github.com/mavriq-dev/public-reascripts/raw/master/index.xml


