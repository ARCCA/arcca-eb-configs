#some initial notes on how to install packages with EasyBuild

#Isolate Hawk modules by modifying `MODULEPATH`. Point to 
#- `linux-centos7-skylake_avx512`
#- `linux-centos7-zen2`
#- `linux-rocky9-zen2`
#- `linux-rocky9-cascadelake_avx512`
#
#depending on host and load EasyBuild module.
#eb_version=4.9.4
#eb_version=5.0.0
eb_version=5.1.1

if [ $# -eq 0 ] || [ $1 = '--help' ] || [ $1 = '-h' ] || [ $1 = '-help' ]; then
  echo "Script to setup Easybuild environment. User needs to specify installation target."
  echo "Options are:"
  echo "  linux-rocky9-cascadelake_avx512  (for partition gpu_v100_test)"
  echo "  linux-rocky9-zen2                (for partition xcompute_amd_rocky9)"
  echo "  linux-centos7-cascadelake_avx512 (for partition xgpu_v100)"
  echo "  linux-centos7-skylake_avx512     (for partition xcompute)"
  echo "  linux-centos7-zen2               (for partition xcompute_amd)"
  #exit 0
  return
fi

arch=$1

case "$arch" in
  linux-rocky9-cascadelake_avx512 )
    ModulesTool=EnvironmentModules
    partition=xgpu_v100_test
  ;;
  linux-rocky9-zen2 )
    ModulesTool=EnvironmentModules
    partition=xcompute_amd_rocky9
  ;;
  linux-centos7-cascadelake_avx512 )
    ModulesTool=EnvironmentModulesC
    partition=xgpu_v100
  ;;
  linux-centos7-skylake_avx512 )
    ModulesTool=EnvironmentModulesC
    partition=xcompute
  ;;
  linux-centos7-zen2 )
    ModulesTool=EnvironmentModulesC
    partition=xcompute_amd
  ;;
  * )
    echo "Wrong option $arch"
    #exit 0
    return
  ;;
esac

echo setting environment for $arch

export root=$HOME/easybuild
export MODULEPATH=$root/modules/all:$root/modules/$arch/all:/etc/modulefiles:/usr/share/Modules/modulefiles
module purge
module load EasyBuild/$eb_version

# check if module path exists
if [ ! -d $root/modules/$arch/all ]; then
  echo WARNING, module directory does not exist: $root/modules/$arch/all 
fi

export XDG_CONFIG_DIRS=$root/etc

export EASYBUILD_INSTALLPATH_MODULES=$root/modules/$arch
export EASYBUILD_INSTALLPATH_SOFTWARE=$root/software/$arch
export EASYBUILD_SOURCEPATH=$root/sources
export EASYBUILD_BUILDPATH=/tmp/$USER/eb/build
#export EASYBUILD_BUILDPATH=/tmp/$USER/easybuild/build/$arch
export EASYBUILD_CONTAINERPATH=$root/containers/$arch
export EASYBUILD_REPOSITORYPATH=$root/ebfiles_repo
#export EASYBUILD_SEARCH_PATHS=$root/arcca-eb-configs/easyconfigs
export EASYBUILD_ROBOT_PATHS=$root/arcca-eb-configs/easyconfigs:$root/software/EasyBuild/$eb_version/easybuild/easyconfigs
export EASYBUILD_MODULES_TOOL=$ModulesTool
export EASYBUILD_MODULE_SYNTAX=Tcl
export SBATCH_PARTITION=$partition
export SBATCH_ACCOUNT=scw1001

echo "Settings applied:"
echo "  SBATCH_PARTITION               $SBATCH_PARTITION"
echo "  SBATCH_ACCOUNT                 $SBATCH_ACCOUNT"
echo "  MODULEPATH                     $MODULEPATH"
echo "  EASYBUILD_INSTALLPATH_MODULES  $EASYBUILD_INSTALLPATH_MODULES"
echo "  EASYBUILD_INSTALLPATH_SOFTWARE $EASYBUILD_INSTALLPATH_SOFTWARE"
echo "  EASYBUILD_SOURCEPATH           $EASYBUILD_SOURCEPATH"
echo "  EASYBUILD_BUILDPATH            $EASYBUILD_BUILDPATH"
echo "  EASYBUILD_CONTAINERPATH        $EASYBUILD_CONTAINERPATH"
echo "  EASYBUILD_REPOSITORYPATH       $EASYBUILD_REPOSITORYPATH"
#echo "  EASYBUILD_SEARCH_PATHS         $EASYBUILD_SEARCH_PATHS"
echo "  EASYBUILD_ROBOT_PATHS          $EASYBUILD_ROBOT_PATHS"
echo "  EASYBUILD_MODULES_TOOL         $EASYBUILD_MODULES_TOOL"
echo "  EASYBUILD_MODULE_SYNTAX        $EASYBUILD_MODULE_SYNTAX"
