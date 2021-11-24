
#cjpeg-rose7-preset/        linear_alg-mid-100x100-sp/ nnet_test/                 radix2-big-64k/            sha-test/
#core/                      loops-all-mid-10k-sp/      parser-125k/               sets/                      zip-test/
#make TARGET=linux64 wrun-<workload name>
#make TARGET=linux64 wrun-sha-test/
#
#make TARGET=linux64 build
#make TARGET=linux64 XCMD='-c4' certify-all

#make   "TARGET=${target}"  wrun-cjpeg-rose7-preset

#for target in linux64 linux64-clang linux64-iccclang
for target in  linux64-icx
do

#make "TARGET=${target}" clean 
    make   "TARGET=${target}"  build > build-${target}.log 2>&1

    echo -e "\n\n ----------target = ${target}---------\n\n"
    for count in 1 2 3
    do
        result=run-${target}-${count}.log
make TARGET=${target} XCMD='-c4' certify-all > ${result} 2>&1

        sed -n '/WORKLOAD RESULTS TABLE/,/CoreMark-PRO/p' ${result} 
    done
done

