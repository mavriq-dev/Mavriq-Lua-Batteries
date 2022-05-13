-- Lua-CFFI is almost 100% compatible to lua-Jits' built in FFI. Look to that for examples

reaper.ShowConsoleMsg("Start CFFI-LUA tests.\n")
local cffi = require("cffi")


------------------  Sleep Test ----------------------------
cffi.cdef[[
void Sleep(int ms);
int poll(struct pollfd *fds, unsigned long nfds, int timeout);
]]

local sleep
if cffi.os == "Windows" then
  function sleep(s)
    cffi.C.Sleep(s*1000)
  end
else
  function sleep(s)
    cffi.C.poll(nil, 0, s*1000)
  end
end

for i=1,50 do
  reaper.ShowConsoleMsg(".")
  sleep(0.01)
end
reaper.ShowConsoleMsg("\n")


------------------ Printf -------------------------

cffi.cdef[[
int printf(const char *fmt, ...);
]]

cffi.C.printf("Hello %s!", "world")


------------------ Windows MessageboxA ---------------

if cffi.os == "Windows" then
    local user32 = cffi.load("user32")   -- Load User32 DLL handle

    cffi.cdef([[
    enum{
        MB_OK = 0x00000000L,
        MB_ICONINFORMATION = 0x00000040L
    };

    typedef void* HANDLE;
    typedef HANDLE HWND;
    typedef const char* LPCSTR;
    typedef unsigned UINT;

    int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
    ]]) -- Define C -> Lua interpretation

    user32.MessageBoxA(nil, "Hello world!", "My message", cffi.C.MB_OK + cffi.C.MB_ICONINFORMATION)   -- Call C function 'MessageBoxA' from User32
end

reaper.ShowConsoleMsg("End CFFI-LUA Tests.\n\n")