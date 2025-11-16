class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr  \
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

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libvorbis-1.3.7")

        copyFile(   "#{buildDirectoryPath}doc/Vorbis*",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libvorbis-1.3.7")
    end

end
