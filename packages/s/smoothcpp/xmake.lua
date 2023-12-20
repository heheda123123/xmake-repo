package("smoothcpp")

    set_homepage("https://github.com/heheda123123/smoothcpp")
    set_description("Easy to use first cross platform cpp library. Intended as a supplement to the c++ standard library.")
    set_license("MIT")

    set_urls("https://github.com/heheda123123/smoothcpp.git")
    add_versions("2023.12.20", "13c5d67b748f3f8bbb91fac881e288ffce3d83ab")

    on_install("windows", "mingw", "linux", "macosx", function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include "scpp/string/string.h"
            #include <iostream>

            void test() {
                bool a = (scpp::to_lower("aAaAAbb") == "aaaaabb");
                std::cout << a << std::endl;
            }
        ]]}, {configs = {languages = "c++11"}}))
    end)
