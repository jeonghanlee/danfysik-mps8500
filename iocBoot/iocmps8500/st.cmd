#!../../bin/linux-x86_64/mps8500

#  author : Jeong Han Lee
#  email  : jeonghan.lee@gmail.com
#  Date   : 
#  version : 0.0.1

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/mps8500.dbd"
mps8500_registerRecordDeviceDriver pdbbase


# We will use the MOXA NPort 6650-8
# const char *portName,
# const char *hostInfo,
# unsigned int priority : EPICS thread priority for asyn port driver 0=default
# int noAutoConnect,
# int noProcessEos

drvAsynIPPortConfigure "MPS8500", "127.0.0.1:9999", 0, 0, 0
asynOctetSetInputEos   "MPS8500", 0, "\n\r"
asynOctetSetOutputEos  "MPS8500", 0, "\r"

#
# "\r\n" is only valid for the simulator
# , because we want to use Telnet connection also.
#
# asynOctetSetOutputEos  "MPS8500", 0, "\r\n"


## Load record instances
dbLoadRecords "db/iocAdminSoft.db",  "IOC=8500:IocStat"
dbLoadRecords "db/mps8500.db",       "SYSDEV=8500:MPS:,INST=1,MAX=100,MIN=0,HWUNIT=MPS8500"

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=jhlee"


dbl > "${TOP}/${IOC}_PVs.list"

