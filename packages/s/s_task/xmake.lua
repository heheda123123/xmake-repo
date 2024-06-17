package("s_task")
    set_homepage("https://github.com/xhawk18/s_task")
    set_description("awaitable coroutine library for C")

    add_urls("https://github.com/xhawk18/s_task.git")

    add_versions("2024.06.17", "609835c3aef4ca2f8b3959975e85c59d750fa472")

    add_deps("cmake")
    add_configs("shared", {description = "Build shared library.", default = false, type = "boolean", readonly = true})
    add_configs("enable_libuv", {description = "Enable libuv", default = true, type = "boolean", readonly = true})

    on_load(function (package)
        package:add("defines", "USE_LIBUV")
    end)

    on_install(function (package)
        io.replace("CMakeLists.txt", "add_library(s_task ${st_sources})", "if(false)\nadd_library(s_task ${st_sources})", {plain = true})
        io.replace("CMakeLists.txt", "target_link_libraries(ex6_chan s_task)", "endif()", {plain = true})

        os.cp(path.translate("libuv/include"), package:installdir())
        os.cp(path.translate("include/*"), package:installdir("include"))

        import("package.tools.cmake").install(package)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("s_task_init_uv_system_", {includes = "s_task.h"}))
    end)
