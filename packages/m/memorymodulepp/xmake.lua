package("memorymodulepp")
    set_homepage("https://github.com/bb107/MemoryModulePP")
    set_description("MemoryModulePP, used to load a DLL from memory. MemoryModulePP is compatible with Win32 API and supports exception handling.")
    set_license("MIT")

    add_urls("https://github.com/bb107/MemoryModulePP.git")

    add_versions("2024.11.7", "79f258b672f81c6ebbee1454335c4a4309d07ccb")
    add_deps("microsoft-detours")

    on_install("windows|x86", "windows|x64", function (package)
        io.replace("MemoryModule/stdafx.h", '../3rdparty/phnt/include/phnt_windows.h', '3rdparty/phnt/include/phnt_windows.h', {plain = true})
        io.replace("MemoryModule/stdafx.h", '../3rdparty/phnt/include/phnt.h', '3rdparty/phnt/include/phnt.h', {plain = true})
        io.replace("MemoryModule/MmpDotNet.cpp", '3rdparty/Detours/detours.h', 'detours.h', {plain = true})
        io.replace("MemoryModule/MmpTls.cpp", '3rdparty/Detours/detours.h', 'detours.h', {plain = true})
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            add_requires("microsoft-detours")
            target("memorymodulepp")
                add_packages("microsoft-detours")
                set_kind("$(kind)")
                add_files("MemoryModule/*.cpp")
                add_files("MemoryModule/*.c")
                add_files("MemoryModule/MemoryModulePP.def")
                add_headerfiles("MemoryModule/*.h", {prefixdir = "MemoryModule"})
                add_headerfiles("3rdparty/phnt/include/*.h", {prefixdir = "3rdparty/phnt/include"})
                add_includedirs(".")

        ]])
        import("package.tools.xmake").install(package)

    end)

    on_test(function (package)
        assert(package:has_cxxfuncs("LdrLoadDllMemoryExW", {includes = "MemoryModule/stdafx.h"}))
    end)
