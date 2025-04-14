export arch=linux-rocky9-zen4
export root=/trinity/home/guest/easybuild
export MODULEPATH=$root/modules/all/:$root/modules/$arch/all
export XDG_CONFIG_DIRS=$root/etc

export EASYBUILD_INSTALLPATH_MODULES=$root/modules/$arch
export EASYBUILD_INSTALLPATH_SOFTWARE=$root/software/$arch
export EASYBUILD_SOURCEPATH=$root/sources
export EASYBUILD_BUILDPATH=/tmp/$USER/easybuild/build/$arch
export EASYBUILD_CONTAINERPATH=$root/containers/$arch
export EASYBUILD_REPOSITORYPATH=$root/ebfiles_repo
export EASYBUILD_SEARCH_PATHS=$root/arcca-eb-configs/easyconfigs
export EASYBUILD_ROBOT_PATHS=$root/arcca-eb-configs/easyconfigs:$root/software/EasyBuild/5.0.0/easybuild/easyconfigs

#installpath-modules  (E) = /opt/easybuild/modules/linux-rocky9-zen4
#installpath-software (E) = /opt/easybuild/software/linux-rocky9-zen4
#rpath                (D) = True

#configfiles    (E) = /apps/easybuild/config.cfg
#module-syntax  (F) = Tcl
#modules-tool   (F) = EnvironmentModulesC
