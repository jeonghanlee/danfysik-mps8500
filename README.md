# danfysik-mps8500
This is the extremely slow-developing-repository for the Danfysik Magenet Power Supply 8500. The work is based on the shoulder of the FRIB 9100 work. 

* http://www.danfysik.com/media/1179/user-manual-sys8500.pdf
* http://www.danfysik.com/media/1182/software-manual-sys8500.pdf

## Working Environment or Requirements

* EPICS 3.15.4

* ASYN-4-29 

* STREAM  791e7c0

* devIocStats 82988fd 

* Simulator

I am developing and also using the simulator in https://bitbucket.org/jeonghanlee/kameleon, was forked from https://bitbucket.org/europeanspallationsource/kameleon, in order to develop the basic EPICS IOC based on the FRIB 9100 db and proto files. ESS might use the Danfysik MPS 8500 in the Raster Scanning Magent Power Supplies. 


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
```
```
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

```
jhlee@kaffee: kameleon (master)$ ./mps8500.sh 

****************************************************
*                                                  *
*  Kameleon v1.4.0 (2016/DEC/02 - Development)     *
*                                                  *
*                                                  *
*  (C) 2015-2016 European Spallation Source (ESS)  *
*                                                  *
****************************************************

[17:42:56.116] Using file 'simulators/danfysik_mps8500/mps8500.kam' (contains 26 commands and 26 statuses).
[17:42:56.116] Start serving from any hostname that the machine has at port '9999'.

```


### EPICS IOC

```jhlee@kaffee:~/epics_env/epics-Apps/danfysik-mps8500/iocBoot/iocmps8500 (master)$ ./st.kameloen.cmd 
#!../../bin/linux-x86_64/mps8500
#  author : Jeong Han Lee
#  email  : jeonghan.lee@gmail.com
#  Date   : 
#  version : 0.0.1
< envPaths
epicsEnvSet("IOC","iocmps8500")
epicsEnvSet("TOP","/home/jhlee/epics_env/epics-Apps/danfysik-mps8500")
epicsEnvSet("STREAM_PROTOCOL_PATH", ".:/home/jhlee/epics_env/epics-Apps/danfysik-mps8500/db")
cd "/home/jhlee/epics_env/epics-Apps/danfysik-mps8500"
## Register all support components
dbLoadDatabase "dbd/mps8500.dbd"
mps8500_registerRecordDeviceDriver pdbbase
# const char *portName,
# const char *hostInfo,
# unsigned int priority : EPICS thread priority for asyn port driver 0=default
# int noAutoConnect,
# int noProcessEos
drvAsynIPPortConfigure "MPS8500", "127.0.0.1:9999", 0, 0, 0
asynOctetSetInputEos   "MPS8500", 0, "\n\r"
#
# asynOctetSetOutputEos "MPS8500", 0, "\r"
#
# "\r\n" is only valid for the simulator
# , because we want to use Telnet connection also.
#
asynOctetSetOutputEos  "MPS8500", 0, "\r\n"
## Load record instances
dbLoadRecords "db/iocAdminSoft.db",  "IOC=8500:IocStat"
dbLoadRecords "db/mps8500.db",       "SYSDEV=8500:MPS:,INST=1,MAX=100,MIN=0,HWUNIT=MPS8500"
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
dbl > "/home/jhlee/epics_env/epics-Apps/danfysik-mps8500/iocmps8500_PVs.list"
epics>

```

### caget script
```
jhlee@kaffee: scripts (master)$  bash caget_pvs.bash ../iocmps8500_PVs.list "MPS"
8500:MPS:RMT_RSTS              Remote
8500:MPS:S1-bit1_desc          Spare
8500:MPS:S1-bit2_desc          DC Overload
_8500:MPS:S1-1sts_             2
_8500:MPS:S1-2sts_             3105
8500:MPS:RMT_CMD               Remote
8500:MPS:PowerSwitch_RSTS      off
8500:MPS:RB_                   1
8500:MPS:RLOC_STS              
8500:MPS:RMT_STS               
_8500:MPS:RAW_CMD              
_8500:MPS:RAW_QUERY            
8500:MPS:S1-bit1_sts           2
8500:MPS:S1-bit2_sts           3105
8500:MPS:S1-sts_               12718082
8500:MPS:Clock                 17,43,58,21,12,2016
8500:MPS:ID-Sts1               SYSTEM 8500 TYP 859H
8500:MPS:ID-Sts2               1250A / 400V
8500:MPS:ID-Sts3               SW VER WCC114
8500:MPS:ID-Sts4               ID 1234567890
8500:MPS:PRINT-Sts1            SYSTEM 8500
8500:MPS:PRINT_Sts2            V1.0A
8500:MPS:RLOC_CMD              
8500:MPS:VER-Sts1              Copyright DANFYSIK A/S
8500:MPS:VER-Sts2              RAMTEX Engineering Aps
8500:MPS:VER-Sts3              SCC V1.13 Aug 10 2008
_8500:MPS:RAW_REPLY            
8500:MPS:PowerSwitch_CMD       off
8500:MPS:RST_CMD               

```

```
jhlee@kaffee: danfysik-mps8500 (master)$ bash scripts/caget_pvs.bash iocmps8500_PVs.list
8500:IocStat:CA_UPD_TIME       15
8500:IocStat:FD_UPD_TIME       20
8500:IocStat:LOAD_UPD_TIME     10
8500:IocStat:MEM_UPD_TIME      10
8500:IocStat:FD_FREE           65527
8500:IocStat:READACF           0
8500:IocStat:SYSRESET          0
8500:IocStat:SysReset          0
8500:IocStat:ACCESS            Running
8500:MPS:RMT_CMD               Remote
8500:IocStat:GTIM_RESET        Reset
8500:MPS:RLOC_RSTS             
8500:IocStat:HEARTBEAT         54
8500:IocStat:START_CNT         1
8500:IocStat:CA_CLNT_CNT       1
8500:IocStat:CA_CONN_CNT       1
8500:IocStat:CPU_CNT           8
8500:IocStat:FD_CNT            9
8500:IocStat:FD_MAX            65536
8500:IocStat:GTIM_TIME         8.49195e+08
8500:IocStat:IOC_CPU_LOAD      0
8500:IocStat:LOAD              0
8500:IocStat:MEM_FREE          1.3051e+10
8500:IocStat:MEM_MAX           2.52313e+10
8500:IocStat:MEM_USED          7.1721e+06
8500:IocStat:PARENT_ID         15613
8500:IocStat:PROCESS_ID        13961
8500:IocStat:RECORD_CNT        64
8500:IocStat:SUSP_TASK_CNT     0
8500:IocStat:SYS_CPU_LOAD      3.9037
8500:IocStat:APP_DIR2          ik-mps8500/iocBoot/iocmps8500
8500:IocStat:CA_ADDR_LIST      194.47.240.7
....
....
....

```

```
jhlee@kaffee: danfysik-mps8500 (master)$  bash scripts/caget_mbbi.bash 8500:MPS:S1-bit1_sts
8500:MPS:S1-bit1_sts.B0        0
8500:MPS:S1-bit1_sts.B1        0
8500:MPS:S1-bit1_sts.B2        0
8500:MPS:S1-bit1_sts.B3        0
8500:MPS:S1-bit1_sts.B4        0
8500:MPS:S1-bit1_sts.B5        0
8500:MPS:S1-bit1_sts.B6        0
8500:MPS:S1-bit1_sts.B7        0
8500:MPS:S1-bit1_sts.B8        0
8500:MPS:S1-bit1_sts.B9        0
8500:MPS:S1-bit1_sts.BA        0
8500:MPS:S1-bit1_sts.BB        0
8500:MPS:S1-bit1_sts.BC        0
8500:MPS:S1-bit1_sts.BD        0
8500:MPS:S1-bit1_sts.BE        0
8500:MPS:S1-bit1_sts.BF        0

jhlee@kaffee: ~$ caput _8500:MPS:RAW_QUERY "SETBIT 0x00000F"
Old : _8500:MPS:RAW_QUERY            SETBIT 0x00F000
New : _8500:MPS:RAW_QUERY            SETBIT 0x00000F
jhlee@kaffee: ~$ 

jhlee@kaffee: danfysik-mps8500 (master)$ bash scripts/caget_mbbi.bash 8500:MPS:S1-bit1_sts
8500:MPS:S1-bit1_sts.B0        1
8500:MPS:S1-bit1_sts.B1        1
8500:MPS:S1-bit1_sts.B2        1
8500:MPS:S1-bit1_sts.B3        1
8500:MPS:S1-bit1_sts.B4        0
8500:MPS:S1-bit1_sts.B5        0
8500:MPS:S1-bit1_sts.B6        0
8500:MPS:S1-bit1_sts.B7        0
8500:MPS:S1-bit1_sts.B8        0
8500:MPS:S1-bit1_sts.B9        0
8500:MPS:S1-bit1_sts.BA        0
8500:MPS:S1-bit1_sts.BB        0
8500:MPS:S1-bit1_sts.BC        0
8500:MPS:S1-bit1_sts.BD        0
8500:MPS:S1-bit1_sts.BE        0
8500:MPS:S1-bit1_sts.BF        0
jhlee@kaffee: danfysik-mps8500 (master)$ 

```

## License
* https://www.gnu.org/licenses/gpl-2.0.txt 

# Reference
There are three PSU based on System 8500, maybe more. 

* http://www.danfysik.com/media/1098/model-854-datasheet.pdf
* http://www.danfysik.com/media/1233/model-858-datasheet.pdf
* http://www.danfysik.com/media/1099/model-859-datasheet.pdf

# Acknowledgement
A special word of thanks goes to John Priller, who provided the FRIB SYS9100 DB and protocol files. 
