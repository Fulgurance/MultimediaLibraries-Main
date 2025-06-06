class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                                                      \
                                    --reconfigure                                                               \
                                    #{@buildDirectoryNames["MainBuild"]}                                        \
                                    --prefix=/usr                                                               \
                                    --buildtype=release                                                         \
                                    --wrap-mode=nodownload                                                      \
                                    -Dbase=#{option("Base") ? "enabled" : "disabled"}                           \
                                    -Dgood=#{option("Good") ? "enabled" : "disabled"}                           \
                                    -Dbad=#{option("Bad") ? "enabled" : "disabled"}                             \
                                    -Dugly=#{option("Ugly") ? "enabled" : "disabled"}                           \
                                    -Dintrospection=#{option("Gobject-Introspection") ? "enabled" : "disabled"} \
                                    -Dtests=disabled                                                            \
                                    -Dgpl=enabled",
                        path:       mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
