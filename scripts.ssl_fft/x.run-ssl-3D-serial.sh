#! /bin/bash
#PJM -N SSL2FFT-3D-SERIAL
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=00:60:00"
#PJM --rsc-list "node=1"
#	#PJM --mpi "max-proc-per-node=4"
#PJM -j
#PJM -S

module list

set -x
hostname
date
WD=${HOME}/tmp/check_ssl2_3D_serial
mkdir -p ${WD}
cd ${WD}; if [ $? != 0 ] ; then echo '@@@ Directory error @@@'; exit; fi
rm ${WD}/*

SRC=${HOME}/ssl_fft/src_ssl2fft

CFLAGS="-Kfast -I${FFTW_DIR}/include "
FFLAGS="-Kfast -I${FFTW_DIR}/include -Nlst=t "
#	FFLAGS+="-Kcmodel=large "
LDFLAGS="-Kfast -SSL2 --linkstl=libfjc++ "
cp $SRC/main_ssl2fft_complex_3D.serial.F main.F90
#	mpifrtpx  -o ssl2fft.ex $FFLAGS  main.F90  $LDFLAGS
#	exit

frt  -o ssl2fft.ex $FFLAGS  main.F90  $LDFLAGS
export OMP_NUM_THREADS=1
./ssl2fft.ex
exit

