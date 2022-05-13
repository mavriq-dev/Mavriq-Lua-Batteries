[![License](https://img.shields.io/badge/license-GPLv3-orange)](./LICENSE)
![Release Build](https://img.shields.io/github/workflow/status/mavriq-dev/Mavriq_Lua_Batteries/Build?label=Build)
![Code Size](https://img.shields.io/github/languages/code-size/mavriq-dev/Mavriq_Lua_Batteries)
![Repo Size](https://img.shields.io/github/repo-size/mavriq-dev/Mavriq_Lua_Batteries)
![Release Ver](https://img.shields.io/github/v/release/mavriq-dev/Mavriq_Lua_Batteries)
![PreRelease Ver](https://img.shields.io/github/v/release/mavriq-dev/Mavriq_Lua_Batteries?include_prereleases)
# Mavirq Lua Batteries

### Details
Scripters have had difficulties using Lua modules with REAPER due to a variety of reasons. This project aims to fix that by making the most common and useful modules available in one package. It follows the approached used by the popular Lua Batteries package available on some platforms.

### Included Modules
#### Lua Sockets
Allows low level sockets support to lua. High level packages for HTTP, TCP, UDP, FTP, SMTP, URL, MIME and LTN12 (filters, sinks, sources and pumps) are available. Does NOT include support for HTTPS.

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


