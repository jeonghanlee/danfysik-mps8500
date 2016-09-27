TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = mps8500
# mps8500.dbd will be created and installed
DBD += mps8500.dbd

# mps8500.dbd will be made up from these files:
mps8500_DBD += base.dbd

# Include dbd files from all support applications:
#mps8500_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#mps8500_LIBS += xxx

# mps8500_registerRecordDeviceDriver.cpp derives from mps8500.dbd
mps8500_SRCS += mps8500_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
mps8500_SRCS_DEFAULT += mps8500Main.cpp
mps8500_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#mps8500_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
mps8500_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

