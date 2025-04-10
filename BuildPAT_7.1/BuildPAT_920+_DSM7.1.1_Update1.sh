curl -L https://cndl.synology.cn/download/DSM/release/7.1.1/42962-1/DSM_DS920%2B_42962.pat -o ds.pat
mkdir synoesp
curl --location https://cndl.synology.cn/download/DSM/release/7.0.1/42218/DSM_DS3622xs%2B_42218.pat --output oldpat.tar.gz
tar -C./synoesp/ -xf oldpat.tar.gz rd.gz --warning=no-file-changed
cd synoesp
xz -dc < rd.gz >rd 2>/dev/null || echo "extract rd.gz"
echo "finish"
cpio -idm <rd 2>&1 || echo "extract rd"
mkdir extract && cd extract
cp ../usr/lib/libcurl.so.4 ../usr/lib/libmbedcrypto.so.5 ../usr/lib/libmbedtls.so.13 ../usr/lib/libmbedx509.so.1 ../usr/lib/libmsgpackc.so.2 ../usr/lib/libsodium.so ../usr/lib/libsynocodesign-ng-virtual-junior-wins.so.7 ../usr/syno/bin/scemd ./
ln -s scemd syno_extract_system_patch
cd ../..
mkdir pat
#tar xf ds.pat -C pat
ls -lh ./
sudo LD_LIBRARY_PATH=synoesp/extract synoesp/extract/syno_extract_system_patch ds.pat pat || echo "extract latest pat"
cd pat
tar -czvf archive.tar.gz ./ --warning=no-file-changed
mv archive.tar.gz ../DSM_DS920+_42962_Update1.pat
cd ../
rm -r ds.pat oldpat.tar.gz pat synoesp
