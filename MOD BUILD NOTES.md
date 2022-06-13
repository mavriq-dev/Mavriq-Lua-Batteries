# Build Notes


## General Mac Notes
Most of the libs can be built automatically using macports basic gist is:
```
      install macports
      /opt/local/ext/macports/macports.conf.    macosx_deployment_target=10.10
      port -s install libexpat +universal
      under /opt/local/lib/libexpat.a
```


## lua 5.3.6
Even though REAPER uses 5.3.3 there is a bug which will cause many modules to crash. Using 5.3.6 Dynamically loaded in reaper fixes the issue.

Issue number 2 is that Modules loaded with the newer style will complain about multiple VMs. This is patched to remove that check.
```
Windows
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

macos
      wget https://www.lua.org/ftp/lua-5.3.6.tar.gz
      tar -xvf lua-5.3.6.tar.gz
      patch lua-5.3.6/src/lauxlib.c mavriq-lua-batteries/patches/checkversion.patch

      add to makefile in src
      lua53.dylib: $(CORE_O) $(LIB_O)
      $(CC) -dynamiclib -o $@ $^ $(LIBS) -fPIC -mmacosx-version-min=10.9 -arch arm64 -arch x86_64  -install_name @rpath/$@ 
      
      make -C src lua53.dylib
      
```


## zlib
```
win      
      git clone https://github.com/madler/zlib --depth 1
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
mac
      sim as per win
      cmake .. -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
mac alt
      macport
```

## bzip
```
win      
      git clone https://github.com/libarchive/bzip2 --depth 1
      mkdir bzip2/build 
      pushd .
      cd bzip2/build
      cmake ..
      cmake --build . --config Release
      cp Release/bz2.dll $env:LOCALAPPDATA"\LuaVM\externals\bin"
      cp Release/bz2.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp Release/bz2_static.lib $env:LOCALAPPDATA"\LuaVM\externals\lib"
      cp ../*.h $env:LOCALAPPDATA"\LuaVM\externals\include"
      popd
mac
      similar to win
      cmake .. -DENABLE_LIB_ONLY=ON -DENABLE_SHARED_LIB=OFF -DENABLE_STATIC_LIB=ON -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
mac alt
      macports
```
## zstd
```
      git clone https://github.com/facebook/zstd --depth 1
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
mac
      sim proc as win
      cmake .. -DZSTD_BUILD_SHARED=OFF -DZSTD_BUILD_PROGRAMS=OFF -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
mac alt
      macports
```
## lzma (xz)
```
      git clone https://github.com/xz-mirror/xz --depth 1
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

mac
      macports
```
## libzip
```
      git clone https://github.com/nih-at/libzip --depth 1
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

mac
      simliar to win
      cmake .. -DBUILD_DOC=OFF -DBUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_TOOLS=OFF -DENABLE_LZMA=OFF -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
```
## libffi
```
win      
      git clone https://github.com/am11/libffi
      cd libffi
      git checkout --track origin/feature/cmake-build-configs
      cmake ..
      Open Visual Studio Solution adn build static lib.

mac
      macports
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
win      
      MSYS2 64 bit env
      pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-pkg-config
      pacman -S mingw-w64-x86_64-meson
      pacman -S mingw-w64-x86_64-libffi mingw-w64-x86_64-lua
      rename /mingw64/lib/libffi.dll.a to .bak
      use Meson same as for cmake
      In build dir:  ```LDFLAGS="-static-libgcc -static-libstdc++" meson .. -Dlua_version=5.3 -Dshared_libffi=false```
      Ninja All
mac
      clone from github
      brew install pkg-config
      brew install lua@5.3 and follow all instructions after installing ie export settings so pkg config can find esp pkgconfigni
      mkdir -p build/deps/include
      put stattic ffi in deps and its headers in include
      CFLAGS="-arch arm64 -arch x86_64 -mmacosx-version-min=10.10" LDFLAGS="-arch arm64 -arch x86_64 -mmacosx-version-min=10.10"  meson .. -Dlua_version=5.3 -Dlibffi=vendor
      ninja all
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
win 
      git clone https://github.com/yaml/libyaml
      usual cmake
mac
      cmake .. -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
```
# libcurl
```
Win
      cmake .. -DBUILD_SHARED_LIBS=OFF
      just use cmake as usual
mac
      brew install openssl@3
      cmake .. -DBUILD_SHARED_LIBS=OFF -DOPENSSL_ROOT_DIR=/usr/local/Cellar/openssl@3/3.0.3/
      cmake --build . -config Release
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

# lua-zip
```
cmake .. -DLUA_INCLUDE_DIR=/usr/local/Cellar/lua@5.3/5.3.6/include/lua5.3/ -DLUA_LIBRARIES=/usr/local/Cellar/lua@5.3/5.3.6/lib/liblua.dylib -DCMAKE_MODULE_LINKER_FLAGS:STRING="-L/usr/local/lib -lzstd -lz -llzma -lbz2_static -v"
```

# openssl
```
mac
git clone https://github.com/openssl/openssl --depth 1
cp openssl openssl-arm
mv openssl openssl-intel

cd openssl-intel
export MACOSX_DEPLOYMENT_TARGET=10.10
./Configure darwin64-x86_64-cc 
cd -

cd openssl-arm
export MACOSX_DEPLOYMENT_TARGET=10.10
./Configure darwin64-arm64-cc 
cd -

mkdir openssl-mac
lipo -create openssl-intel/libcrypto.a openssl-arm/libcrypto.a -output openssl-mac/libcrypto.a
lipo -create openssl-intel/libssl.a openssl-arm/libssl.a -output openssl-mac/libssl.a
```

# pcre2
```

mac
       cmake .. -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10
alternate mac
      sudo port -s install pcre2 configure.args="PCRE2_SUPPORT_JIT=OFF"  +universal
```

# libexpat
```
mac
      use macport

```

# pcre2
```
mac
      use macport
```

# postgres
```
Universal install will fail as mac has an old build of zic on it. install macports build and let it fail. Under the x86 build directory /opt/local/var/macports/build copy zic to a place earlier in the path than the apple version in /usr/sbin/. You will have to wipe and rebuild so configure can find the new version before building.
```
