class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames["MainBuild"] = "libvpx-build "
        super

        fileReplaceTextAtLineNumber(path:       "#{mainWorkDirectoryPath}/build/make/Makefile",
                                    text:       "cp -p",
                                    newText:    "cp",
                                    lineNumber: 295)
    end

    def configure
        super

        configureSource(arguments:  "--prefix=/usr
                                    --enable-shared
                                    --disable-static",
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
