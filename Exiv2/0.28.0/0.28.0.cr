class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand([   "-DCMAKE_INSTALL_PREFIX=/usr",
                            "-DCMAKE_BUILD_TYPE=Release",
                            "-DEXIV2_ENABLE_VIDEO=yes",
                            "-DEXIV2_ENABLE_WEBREADY=yes",
                            "-DEXIV2_ENABLE_CURL=#{option("Curl") ? "yes" : "no"}",
                            "-DEXIV2_BUILD_SAMPLES=no",
                            "-G \"Unix Makefiles\"",
                            ".."],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
