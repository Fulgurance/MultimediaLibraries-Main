class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames["MainBuild"] = "source"
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr        \
                                    -DCMAKE_BUILD_TYPE=Release          \
                                    -DCMAKE_POLICY_VERSION_MINIMUM=3.5  \
                                    -DBUILD_TESTING=OFF                 \
                                    -DENABLE_LIBNUMA=OFF                \
                                    -W no-dev",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end
