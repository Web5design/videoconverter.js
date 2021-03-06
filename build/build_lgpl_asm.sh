# Current build uses emscripten at commit df11c6f1fd1636a355b83a1c48b3a890596e6a32

echo "Beginning Build:"

cd ffmpeg

emconfigure ./configure --cc="emcc" --enable-cross-compile --target-os=none --arch=x86_32 --cpu=generic --disable-ffplay --disable-ffprobe --disable-ffserver --disable-asm --disable-doc --disable-devices --disable-pthreads --disable-w32threads --disable-network --disable-hwaccels --disable-parsers --disable-bsfs --disable-debug --disable-zlib --disable-protocols --disable-indevs --disable-outdevs --enable-protocol=file --enable-pic --enable-small
make clean
make
cp ffmpeg ffmpeg.bc
emcc -s OUTLINING_LIMIT=100000 -s VERBOSE=1 -s TOTAL_MEMORY=33554432 -O2 -v ffmpeg.bc -o ../ffmpeg_asm.js --pre-js ../ffmpeg_pre.js --post-js ../ffmpeg_post.js

cd ../

echo "Finished Build"
