class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
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

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libvorbis-1.3.7")

        copyFile("#{buildDirectoryPath}doc/Vorbis*","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libvorbis-1.3.7")
    end

end
