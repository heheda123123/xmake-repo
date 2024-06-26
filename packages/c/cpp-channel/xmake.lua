package("cpp-channel")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/andreiavrammsd/cpp-channel")
    set_description("Thread-safe container for sharing data between threads")
    set_license("MIT")

    set_urls("https://github.com/andreiavrammsd/cpp-channel/archive/refs/tags/v$(version).zip",
             "https://github.com/andreiavrammsd/cpp-channel.git")

    add_versions("0.8.2", "36f234c40d59b90356d37b558a8918a86b128030ad5d42d8c6a627cfe81c8624")

    add_deps("cmake")

    on_install(function (package)
        os.cp("include", package:installdir())
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <msd/channel.hpp>
            void test() {
                msd::channel<int> chan;
            }
        ]]}, {configs = {languages = "c++11"}}))
    end)
