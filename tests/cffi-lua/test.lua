local mv = require("mavriq")


mv.msg("Start CFFI-LUA tests.\n")
local cffi = require("cffi")
local C = cffi.C

mv.msg("Sleep Test.\n")
------------------  Sleep Test ----------------------------
cffi.cdef[[
void Sleep(int ms);
int poll(struct pollfd *fds, unsigned long nfds, int timeout);
]]

local sleep
if cffi.os == "Windows" then
  function sleep(s)
    C.Sleep(s*1000)
  end
else
  function sleep(s)
    C.poll(nil, 0, s*1000)
  end
end

mv.msg("Waiting")
for i=1,50 do
  mv.msg(".")
  sleep(0.01)
end
mv.msg("Done. \n")


------------------ C Type -------------------------
mv.msg("Metatable Test.\n")

cffi.cdef[[
typedef struct { double x, y; } point_t;
]]

local point
local mt = {
  __add = function(a, b) return point(a.x+b.x, a.y+b.y) end,
  __index = {
    len = function(a,b) return math.sqrt(a.x*a.x + a.y*a.y) end,
    area = function(a) return a.x*a.x + a.y*a.y end,
  },
}
point = cffi.metatype("point_t", mt)

local a = point(3, 4)
mv.printf("a:%s b:%s\n",a.x, a.y) --> 3  4
mv.msg("len:" .. a:len() .. "\n") --> 5
mv.msg("area:" .. a:area() .. "\n")--> 25
local b = a + point(0.5, 8)
mv.msg("len:" .. b:len() .. "\n")--> 12.5      

------------------ Windows MessageboxA ---------------

mv.msg("Messagebox Test.\n")

---------   alternate long way to call a function if not loaded into the cffi.C -------------------------------

-- if cffi.os == "Windows" then
--     local user32 = cffi.load("user32")   -- Load User32 DLL handle

--     cffi.cdef([[
--     enum{
--         MB_OK = 0x00000000L,
--         MB_ICONINFORMATION = 0x00000040L
--     };

--     typedef void* HANDLE;
--     typedef HANDLE HWND;
--     typedef const char* LPCSTR;
--     typedef unsigned UINT;

--     int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
--     ]]) -- Define C -> Lua interpretation

--     user32.MessageBoxA(nil, "Hello world!", "My message", cffi.C.MB_OK + cffi.C.MB_ICONINFORMATION)   -- Call C function 'MessageBoxA' from User32
-- end


cffi.cdef[[
    int MessageBoxA(void *w, const char *txt, const char *cap, int type);
    enum{
         MB_OK = 0x00000000L,
         MB_ICONINFORMATION = 0x00000040L
     };
]]
C.MessageBoxA(nil, "Hello world!", "My Message", C.MB_OK + C.MB_ICONINFORMATION)


------------------ Machine Code Execution ---------------

mv.msg("Machine Code Test.\n")

-- Load Windows kernel32 DLL
-- Add C definitions to FFI for usage descriptions of components
cffi.cdef([[
// Redefinitions for WinAPI conventions
typedef void VOID;
typedef VOID* LPVOID;
typedef uintptr_t ULONG_PTR;
typedef ULONG_PTR SIZE_T;
typedef unsigned long DWORD;
typedef int BOOL;
// Property flags for functions below
enum{
  MEM_COMMIT = 0x1000,
  MEM_RESERVE = 0x2000
};
enum{
  PAGE_EXECUTE_READWRITE = 0x40
};
enum{
  MEM_RELEASE = 0x8000
};
// Function headers for correct Lua->C->Lua conversions
LPVOID __stdcall VirtualAlloc(LPVOID, SIZE_T, DWORD, DWORD);
BOOL __stdcall VirtualFree(LPVOID, SIZE_T, DWORD);
]])

-- Metatable for C function wrapping
local func_mt = {
  __call = function(obj, ...)
    return obj[1](...)
  end,
  __tostring = function(obj)
    return tostring(obj[1])
  end
}

-- Converts machine code to function
local function mem2func(header, code)
  -- Check arguments
  if type(header) ~= "string" or type(code) ~= "table" then
    error("Expected function header as string and machine code as table!", 2)
  end
  -- Get code size
  local code_n = #code
  -- Allocate memory with executable rights
  local exec_memory = C.VirtualAlloc(nil, code_n, C.MEM_COMMIT + C.MEM_RESERVE, C.PAGE_EXECUTE_READWRITE)
  if not exec_memory then
    error("Couldn't allocate memory with execution rights!", 2)
  end
  cffi.gc(exec_memory, function(memory) C.VirtualFree(memory, 0, C.MEM_RELEASE) end)
  -- Copy code into executable memory
  cffi.copy(exec_memory, cffi.new("char[?]", code_n, code), code_n)
  -- Return executable memory as function (packed in table with memory to keep her safe from garbage collection)
  return setmetatable(
    {cffi.cast(header, exec_memory), exec_memory},
    func_mt
  )
end

-- Test
local func = mem2func("int (*)(int, int)", {0x8b, 0x44, 0x24, 0x08, 0x03, 0x44, 0x24, 0x04, 0xc3})
--[[
   0: 8b 44 24 08           mov    0x8(%esp),%eax
   4: 03 44 24 04           add    0x4(%esp),%eax
   8: c3                    ret
]]

mv.printf("Result of Register Addition:%s\n\n",func(4, -1))



mv.msg("End CFFI-LUA Tests.\n\n")