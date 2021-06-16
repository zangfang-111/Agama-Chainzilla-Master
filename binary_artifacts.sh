echo Refreshing binaries from artifacts.supernet.org
echo =========================================
echo Step: Removing old binaries
pwd
[ ! -d assets ] && \
  mkdir -p assets
cd assets
[ -d artifacts.supernet.org ] && \
  echo Removing old artifacts. && \
  rm -rvf artifacts.supernet.org
echo
echo Step: Cloning latest binaries for build
wget --recursive --no-parent https://artifacts.supernet.org/latest/
cd ..
echo =========================================
echo
pwd
echo =========================================
echo Step: Permission +x for OSX binaries from artifacts to assets/bin/osx/
echo
rm assets/artifacts.supernet.org/latest/osx/iguana
chmod +x assets/artifacts.supernet.org/latest/osx/komodo*

mkdir assets/bin
mv assets/artifacts.supernet.org/latest/osx assets/bin/osx

echo Moving legacy libs to assets/bin
wget https://supernetorg.bintray.com/misc/libs_legacy_osx.zip
checksum=`shasum -a 256 libs_legacy_osx.zip | awk '{ print $1 }'`
if [ "$checksum" = "c01a3d1ebfffa2d66fd8eadcc783524a5918f92c52da31dfeea61725a2c2427c" ]; then
    echo "Checksum is correct."
    unzip libs_legacy_osx.zip
    cp -rvf libs_legacy_osx/* assets/bin/osx/.
  else
    echo "Checksum is incorrect!"
    exit 0
fi
echo =========================================
echo Step: Moving Windows binaries from artifacts to assets/bin/win64/
#echo
rm assets/artifacts.supernet.org/latest/windows/iguana
mv assets/artifacts.supernet.org/latest/windows assets/bin/win64
echo
echo =========================================
echo Step: Permissions +x for linux64 binaries from artifacts to assets/bin/linux64
echo
rm assets/artifacts.supernet.org/latest/linux/iguana
chmod +x assets/artifacts.supernet.org/latest/linux/komodo*
echo Moving Linux bins to assets/bin
mv assets/artifacts.supernet.org/latest/linux assets/bin/linux64/
echo
echo =========================================
echo Step: Finished Updating binaries from artifacts
echo
