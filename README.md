# danfysik-mps8500
This is the extremely slow-developing-repository for the Danfysik Magenet Power Supply 8500. The work is based on the shoulder of the FRIB 9100 work. 


## Working Environment or Requirements

* EPICS 3.15.4

* ASYN-4-29 

* STREAM  791e7c0

* devIocStats 82988fd 

* Simulator
Currently, I am using the simulator in https://bitbucket.org/jeonghanlee/kameleon, was forked from https://bitbucket.org/europeanspallationsource/kameleon, in order to develop the basic EPICS IOC based on the FRIB 9100 db and proto files. ESS might use the Danfysik MPS 8500 in the Raster Scanning Magent Power Supplies. 


## Commands and Dir Structure

### Simulator
```
jhlee@kaffee: kameleon (master)$ tree -L 2
.
├── [jhlee     21K]  kameleon.py
├── [jhlee    2.7K]  README
└── [jhlee    4.0K]  simulators
    ├── [jhlee    4.0K]  ak_nord_xt_pico_sxl
    ├── [jhlee    4.0K]  danfysik_mps8500
    ├── [jhlee    4.0K]  example
    ├── [jhlee    4.0K]  fug_hch_15k-100k
    ├── [jhlee    4.0K]  fug_hcp_353500
    ├── [jhlee    4.0K]  gconpi
    ├── [jhlee    4.0K]  hameg_hmo3034
    ├── [jhlee    4.0K]  julabo_f25-hl
    ├── [jhlee    4.0K]  lakeshore_336
    ├── [jhlee    4.0K]  SCPI
    ├── [jhlee    4.0K]  tdk_lambda_10-500
    └── [jhlee    4.0K]  template

13 directories, 2 files

jhlee@kaffee: kameleon (master)$ python kameleon.py --host="127.0.0.1" --file=simulators/danfysik_mps8500/mps8500.kam

****************************************************
*                                                  *
*  Kameleon v1.3.3 (2016/OCT/13 - Production)      *
*                                                  *
*                                                  *
*  (C) 2015-2016 European Spallation Source (ESS)  *
*                                                  *
****************************************************

[11:02:38.139] Using file 'simulators/danfysik_mps8500/mps8500.kam' (contains 1 commands and 1 statuses).
[11:02:38.139] Start serving from hostname '127.0.0.1' at port '9999'.
```

### EPICS IOC

```
jhlee@kaffee:~/epics_env/epics-Apps/danfysik-mps8500/iocBoot/iocmps8500 (master)$ ./st.cmd.kameleon 
#!../../bin/linux-x86_64/mps8500
## You may have to change mps8500 to something else
## everywhere it appears in this file
< envPaths
epicsEnvSet("IOC","iocmps8500")
epicsEnvSet("TOP","/home/jhlee/epics_env/epics-Apps/danfysik-mps8500")
epicsEnvSet("STREAM_PROTOCOL_PATH", ".:/home/jhlee/epics_env/epics-Apps/danfysik-mps8500/db")
cd "/home/jhlee/epics_env/epics-Apps/danfysik-mps8500"
## Register all support components
dbLoadDatabase "dbd/mps8500.dbd"
mps8500_registerRecordDeviceDriver pdbbase
drvAsynIPPortConfigure("MPS8500", "127.0.0.1:9999", 0, 0, 0)
## Load record instances
dbLoadRecords("db/iocAdminSoft.db",  "IOC=KAM-MPS:IOC")
dbLoadRecords("db/mps8500.db", "SYS=KAM,SUB=MPS,DEV=8500,INST=1,MAX=100,MIN=0,HWUNIT=MPS8500")
cd "/home/jhlee/epics_env/epics-Apps/danfysik-mps8500/iocBoot/iocmps8500"
iocInit
Starting iocInit
############################################################################
## EPICS R3.15.4 $$Date$$
## EPICS Base built Sep 27 2016
############################################################################
iocRun: All initialization complete
## Start any sequence programs
#seq sncxxx,"user=jhlee"
```



## License
* https://www.gnu.org/licenses/gpl-2.0.txt 
