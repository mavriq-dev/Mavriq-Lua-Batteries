# Build Notes

## lua 5.3.6
Even though REAPER uses 5.3.3 there is a bug which will cause many modules to crash. Using 5.3.6 Dynamically loaded in reaper fixes the issue.

Issue number 2 is that Modules loaded with the newer style will complain about multiple VMs. This is patched to remove that check.
```
      Invoke-WebRequest -OutFile lua-5.3.6.tar.gz https://www.lua.org/ftp/lua-5.3.6.tar.gz
      tar -xvf lua-5.3.6.tar.gz
      patch lua-5.3.6/src/lauxlib.c checkversion.patch --binary
      pushd .
      cd lua-5.3.6/src
      cl /MD /O2 /c /DLUA_BUILD_AS_DLL *.c
      ren lua.obj lua.o
      ren luac.obj luac.o
      link /DLL /IMPLIB:lua53.lib /OUT:lua53.dll *.obj
      popd
```

## zlib
```
      git clone https://github.com/madler/zlib
      mkdir zlib/build 
      pushd .
      cd zlib/build
      cmake ..
      msbuild .\zlib.vcxproj /property:Configuration=Release /property:Platform=x64
      msbuild .\zlibstatic.vcxproj /property:Configuration=Release /property:Platform=x64
      cp Release/zlib.dll $env:LOCALAPPDATA"\LuaVM\externals\bin"
      cp Release/zlib.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp Release/zlibstatic.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      popd
```

## bzip
```
      git clone https://github.com/libarchive/bzip2
      mkdir bzip2/build 
      pushd .
      cd bzip2/build
      cmake -DENABLE_STATIC_LIB=true ..
      cmake --build . --config Release
      cp Release/bz2.dll $env:LOCALAPPDATA"\LuaVM\externals\bin"
      cp Release/bz2.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp Release/bz2_static.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp ../*.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      popd
```
## zstd
```
      git clone https://github.com/facebook/zstd
      mkdir zstd/build/cmake/builddir
      pushd .
      cd zstd/build/cmake/builddir
      cmake ..  
      cmake --build . --config Release
      cp lib\Release/zstd.dll $env:LOCALAPPDATA"\LuaVM\externals\bin"
      cp lib\Release/zstd.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp lib\Release/zstd_static.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp ../../../lib/*.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      popd
```
## lzma (xz)
```
      git clone https://github.com/xz-mirror/xz
      mkdir xz/build
      pushd .
      cd xz/build
      cmake ..
      cmake --build . --config Release
      cp Release/liblzma.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp ../src/liblzma/api/*.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      mkdir $env:LOCALAPPDATA"\LuaVM\externals\include\lzma"
      cp ../src/liblzma/api/lzma/*.h $env:LOCALAPPDATA"\LuaVM\externals\include\lzma"
      popd
```
## libzip
```
      git clone https://github.com/nih-at/libzip
      patch libzip/lib/zip_algorithm_xz.c libzip.patch --binary
      mkdir libzip/build
      pushd .
      cd libzip/build
      cmake -DBUILD_SHARED_LIBS=OFF .. # -DZLIB_INCLUDE_DIR=$env:LOCALAPPDATA"\LuaVM\externals\include" -DZLIB_LIBRARY_RELEASE=$env:LOCALAPPDATA"\LuaVM\externals\lib\zlib.lib"..
      cmake --build . --config Release
      cp lib\Release/zip.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp ../lib/zip.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      cp zipconf.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      popd
```
## libffi
```
      git clone https://github.com/am11/libffi
      cd libffi
      git checkout --track origin/feature/cmake-build-configs
      cmake ..
      Open Visual Studio Solution adn build static lib.
```
### Other Alternatives for libffi
`https://github.com/winlibs/libffi` has vc16 etc projectgs

Building from source
```
      MSys2
      configure --enable-static
```
# cffi-lua
```
      MSYS2 64 bit env
      pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-pkg-config
      pacman -S mingw-w64-x86_64-meson
      pacman -S mingw-w64-x86_64-libffi mingw-w64-x86_64-lua
      rename /mingw64/lib/libffi.dll.a to .bak
      use Meson same as for cmake
      In build dir:  ```LDFLAGS="-static-libgcc -static-libstdc++" meson .. -Dlua_version=5.3 -Dshared_libffi=false```
      Ninja All
```
# lua-sec
```
      Build open ssl 3.0 as per norm
      Remove open ssl included with LuaVM
      copy libs, dlls, and includes to LuaVM
      luarocks unpack luasec
      patch rockspec to include Advapi.lib and Users32.lib
      Patch rockspec for proper names of openssl
      cd to luasec
      lua options.lua -g C:\Users\geoff_obr9bt1\AppData\Local\LuaVM\externals\include\openssl\ssl.h > options.c
      luarocks make
```
# pcre
```
      clone repo
      reg cmake commands
```
# sqllite3
```
      Navigate to https://www.sqlite.org/download.html and download latest amalgamation source version of SQLite.
      Extract all the files into your project directory, or your include path, or separate path that you will add/added as include path in your project properties.
      Run Developer Command Prompt for VS **** which is usually available at Start -> Programs -> Visual Studio **** -> Visual Studio Tools.
      Navigate with command prompt to that directory where we extracted our SQLite.
      Run next command to compile: cl /c /EHsc sqlite3.c
      Run next command to create static library: lib sqlite3.obj
      Open properties of your project and add sqlite3.lib to Linker -> Input -> Additional Dependencies.
```
# libyaml
```
git clone https://github.com/yaml/libyaml
usual cmake
```
# libcurl
```
cmake .. -DBUILD_SHARED_LIBS=OFF
just use cmake as usual
```
# moonglfw (TODO)
```
make in msys32
pacman -S mingw-w64-x86_64-glfw
make LIBS="-llua -lglfw3"
Looks like glfw3 is loaded at runtime via dlopen. This needs to be changed.

```
# wxLua
```
git clone https://github.com/pkulchenko/wxlua
mkdir wxlua/wxlua/wxlua-build
pushd .
CD wxlua/wxlua/wxlua-build
cmake .. -DwxWidgets_ROOT_DIR="$env:projdir"/wxWidgets/ -DwxLua_LUA_LIBRARY_USE_BUILTIN=false -DwxLua_LUA_INCLUDE_DIR="$env:LOCALAPPDATA"\LUAVM\versions\5.3\include -DwxLua_LUA_LIBRARY="$env:LOCALAPPDATA"\LUAVM\versions\5.3\lua53.lib
cmake --build . --config Release
popd
```
# MySql-Server
Lib is broken under VS 17.2+. Unresolved Symbols
```
cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=C:\Users\geoff_obr9bt1\Documents\GitHub\test



```