VERSION=5.2.14
REL=1

git pull
rpmdev-bumpspec -n $VERSION -c "Update VBox to $VERSION" VirtualBox.spec
spectool -g VirtualBox.spec
rfpkg new-sources ./VirtualBox-$VERSION.tar.bz2
rfpkg ci -c && git show
echo Press enter to continue; read dummy;
rfpkg push && rfpkg build --nowait
echo Press enter to continue; read dummy;
git checkout f28 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout f27 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout el7 && git merge master && git push && rfpkg build --nowait; git checkout master

cd ../VirtualBox-kmod/
git pull
rpmdev-bumpspec -n $VERSION -c "Update VBox to $VERSION" VirtualBox-kmod.spec
rfpkg ci -c && git show
#cp VirtualBox-kmod.spec VirtualBox-kmod.spec.new
#git reset HEAD~1
#git rm kernel-4.10.0-0.rc5.lnkops.v2.patch
echo Press enter to continue; read dummy;
rfpkg push && rfpkg build --nowait

echo Press enter to continue; read dummy;
#koji-rpmfusion watch-task
koji-rpmfusion tag-build f27-free-override VirtualBox-$VERSION-$REL.fc27
koji-rpmfusion wait-repo f27-free-build --build=VirtualBox-$VERSION-$REL.fc27
git checkout f27 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
koji-rpmfusion tag-build f26-free-override VirtualBox-$VERSION-$REL.fc26

echo "koji-rpmfusion tag-build f26-free-override VirtualBox-$VERSION-$REL.fc26
koji-rpmfusion wait-repo f26-free-build --build=VirtualBox-$VERSION-$REL.fc26
git checkout f26 && git merge master && git push && rfpkg build --nowait; git checkout master
Press enter to continue; read dummy;
koji-rpmfusion tag-build f25-free-override VirtualBox-$VERSION-$REL.fc25
koji-rpmfusion wait-repo f25-free-build --build=VirtualBox-$VERSION-$REL.fc25
git checkout f25 && git merge master && git push && rfpkg build --nowait; git checkout master
Press enter to continue; read dummy;
koji-rpmfusion tag-build el7-free-override VirtualBox-$VERSION-$REL.el7
koji-rpmfusion wait-repo el7-free-build --build=VirtualBox-$VERSION-$REL.el7
git checkout el7 && git merge master && git push && rfpkg build --nowait; git checkout master"
