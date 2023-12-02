class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames[:mainBuild] = "libvpx-build "
        super

        fileReplaceTextAtLineNumber("#{mainWorkDirectoryPath(false)}/build/make/Makefile","cp -p","cp",295)
    end

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-shared",
                            "--disable-static"],
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
