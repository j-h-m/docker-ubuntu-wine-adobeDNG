mkdir test; cd ./test

git clone https://github.com/j-h-m/docker-ubuntu-wine-adobeDNG

cd ./AdobeDNGProject/test_images

for f in ./BRIT_test_set/*.CR2; do adobedng -c $f; done