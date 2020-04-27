###########################################################################
## Makefile generated for MATLAB file/project 'pt'. 
## 
## Makefile     : pt_rtw.mk
## Generated on : Fri Apr 24 11:29:18 2020
## MATLAB Coder version: 4.2 (R2019a)
## 
## Build Info:
## 
## Final product: ./PanTompkins.lib
## Product type : static-library
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# COMPUTER                Computer type. See the MATLAB "computer" command.
# COMPILER_COMMAND_FILE   Compiler command listing model reference header paths
# CMD_FILE                Command file

PRODUCT_NAME              = pt
MAKEFILE                  = pt_rtw.mk
COMPUTER                  = PCWIN64
MATLAB_ROOT               = C:/PROGRA~1/MATLAB/R2019a
MATLAB_BIN                = C:/PROGRA~1/MATLAB/R2019a/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
MASTER_ANCHOR_DIR         = 
START_DIR                 = E:/Project/epilepsy-detection/matlab/codegen/lib/pt
ARCH                      = win64
TGT_FCN_LIB               = ISO_C++
RELATIVE_PATH_TO_ANCHOR   = .
COMPILER_COMMAND_FILE     = pt_rtw_comp.rsp
CMD_FILE                  = pt_rtw.rsp
C_STANDARD_OPTS           = -ansi -pedantic -Wno-long-long -fwrapv
CPP_STANDARD_OPTS         = -std=c++98 -pedantic -Wno-long-long -fwrapv

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          MinGW64 | gmake (64-bit Windows)
# Supported Version(s):    6.x
# ToolchainInfo Version:   R2019a
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# C_STANDARD_OPTS
# CPP_STANDARD_OPTS
# MINGW_ROOT
# MINGW_C_STANDARD_OPTS

#-----------
# MACROS
#-----------

WARN_FLAGS            = -Wall -W -Wwrite-strings -Winline -Wstrict-prototypes -Wnested-externs -Wpointer-arith -Wcast-align
WARN_FLAGS_MAX        = $(WARN_FLAGS) -Wcast-qual -Wshadow
CPP_WARN_FLAGS        = -Wall -W -Wwrite-strings -Winline -Wpointer-arith -Wcast-align
CPP_WARN_FLAGS_MAX    = $(CPP_WARN_FLAGS) -Wcast-qual -Wshadow
MEX_OPTS_FILE         = $(MATLAB_ROOT)/bin/win64/mexopts/mingw64.xml
MEX_CPP_OPTS_FILE     = $(MATLAB_ROOT)/bin/win64/mexopts/mingw64_g++.xml
MW_EXTERNLIB_DIR      = $(MATLAB_ROOT)/extern/lib/win64/mingw64
SHELL                 = %SystemRoot%/system32/cmd.exe

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lws2_32

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# C Compiler: GNU C Compiler
CC_PATH = $(MINGW_ROOT)
CC = "$(CC_PATH)/gcc"

# Linker: GNU Linker
LD_PATH = $(MINGW_ROOT)
LD = "$(LD_PATH)/g++"

# C++ Compiler: GNU C++ Compiler
CPP_PATH = $(MINGW_ROOT)
CPP = "$(CPP_PATH)/g++"

# C++ Linker: GNU C++ Linker
CPP_LD_PATH = $(MINGW_ROOT)
CPP_LD = "$(CPP_LD_PATH)/g++"

# Archiver: GNU Archiver
AR_PATH = $(MINGW_ROOT)
AR = "$(AR_PATH)/ar"

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_BIN)/win64
MEX = "$(MEX_PATH)/mex"

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: GMAKE Utility
MAKE_PATH = %MATLAB%/bin/win64
MAKE = "$(MAKE_PATH)/gmake"


#-------------------------
# Directives/Utilities
#-------------------------

CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  = @del
ECHO                = @echo
MV                  = @move
RUN                 =

#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS              = ruvs
CFLAGS               = -c $(MINGW_C_STANDARD_OPTS) -m64 \
                       -O0
CPPFLAGS             = -c $(CPP_STANDARD_OPTS) -m64 \
                       -O0
CPP_LDFLAGS          = -Wl,-rpath,"$(MATLAB_ARCH_BIN)",-L"$(MATLAB_ARCH_BIN)" -static -m64
CPP_SHAREDLIB_LDFLAGS  = -shared -Wl,-rpath,"$(MATLAB_ARCH_BIN)",-L"$(MATLAB_ARCH_BIN)" -Wl,--no-undefined \
                         -Wl,--out-implib,$(basename $(PRODUCT)).lib
DOWNLOAD_FLAGS       =
EXECUTE_FLAGS        =
LDFLAGS              = -Wl,-rpath,"$(MATLAB_ARCH_BIN)",-L"$(MATLAB_ARCH_BIN)" -static -m64
MEX_CPPFLAGS         = -R2018a -MATLAB_ARCH=$(ARCH) $(INCLUDES) \
                         \
                       CXXOPTIMFLAGS="$(MINGW_C_STANDARD_OPTS)  \
                       -O0 \
                        $(DEFINES)" \
                         \
                       -silent
MEX_CPPLDFLAGS       = LDFLAGS=='$$LDFLAGS'
MEX_CFLAGS           = -R2018a -MATLAB_ARCH=$(ARCH) $(INCLUDES) \
                         \
                       COPTIMFLAGS="$(MINGW_C_STANDARD_OPTS)  \
                       -O0 \
                        $(DEFINES)" \
                         \
                       -silent
MEX_LDFLAGS          = LDFLAGS=='$$LDFLAGS'
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    = -shared -Wl,-rpath,"$(MATLAB_ARCH_BIN)",-L"$(MATLAB_ARCH_BIN)" -Wl,--no-undefined \
                       -Wl,--out-implib,$(basename $(PRODUCT)).lib



###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = ./PanTompkins.lib
PRODUCT_TYPE = "static-library"
BUILD_TYPE = "Static Library"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = 

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -D__USE_MINGW_ANSI_STDIO=1 -DMODEL=PanTompkins -DHAVESTDIO -DUSE_RTMODEL -DCS_COMPLEX
DEFINES_CUSTOM = 
DEFINES_OPTS = -DCS_COMPLEX
DEFINES_STANDARD = -DMODEL=PanTompkins -DHAVESTDIO -DUSE_RTMODEL

DEFINES = $(DEFINES_) $(DEFINES_CUSTOM) $(DEFINES_OPTS) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(START_DIR)/pt_data.cpp $(START_DIR)/pt_initialize.cpp $(START_DIR)/pt_terminate.cpp $(START_DIR)/pt.cpp $(START_DIR)/filter.cpp $(START_DIR)/conv.cpp $(START_DIR)/abs.cpp $(START_DIR)/filtfilt.cpp $(START_DIR)/introsort.cpp $(START_DIR)/insertionsort.cpp $(START_DIR)/bsxfun.cpp $(START_DIR)/mrdivide_helper.cpp $(START_DIR)/xnrm2.cpp $(START_DIR)/xscal.cpp $(START_DIR)/power.cpp $(START_DIR)/findpeaks.cpp $(START_DIR)/eml_setop.cpp $(START_DIR)/sortIdx.cpp $(START_DIR)/sort1.cpp $(START_DIR)/mean.cpp $(START_DIR)/diff.cpp $(START_DIR)/pt_emxutil.cpp $(START_DIR)/pt_emxAPI.cpp $(START_DIR)/rt_nonfinite.cpp $(START_DIR)/rtGetNaN.cpp $(START_DIR)/rtGetInf.cpp $(START_DIR)/CXSparse/Source/cs_add_ri.cpp $(START_DIR)/CXSparse/Source/cs_add_ci.cpp $(START_DIR)/CXSparse/Source/cs_amd_ri.cpp $(START_DIR)/CXSparse/Source/cs_amd_ci.cpp $(START_DIR)/CXSparse/Source/cs_chol_ri.cpp $(START_DIR)/CXSparse/Source/cs_chol_ci.cpp $(START_DIR)/CXSparse/Source/cs_cholsol_ri.cpp $(START_DIR)/CXSparse/Source/cs_cholsol_ci.cpp $(START_DIR)/CXSparse/Source/cs_counts_ri.cpp $(START_DIR)/CXSparse/Source/cs_counts_ci.cpp $(START_DIR)/CXSparse/Source/cs_cumsum_ri.cpp $(START_DIR)/CXSparse/Source/cs_cumsum_ci.cpp $(START_DIR)/CXSparse/Source/cs_dfs_ri.cpp $(START_DIR)/CXSparse/Source/cs_dfs_ci.cpp $(START_DIR)/CXSparse/Source/cs_dmperm_ri.cpp $(START_DIR)/CXSparse/Source/cs_dmperm_ci.cpp $(START_DIR)/CXSparse/Source/cs_droptol_ri.cpp $(START_DIR)/CXSparse/Source/cs_droptol_ci.cpp $(START_DIR)/CXSparse/Source/cs_dropzeros_ri.cpp $(START_DIR)/CXSparse/Source/cs_dropzeros_ci.cpp $(START_DIR)/CXSparse/Source/cs_dupl_ri.cpp $(START_DIR)/CXSparse/Source/cs_dupl_ci.cpp $(START_DIR)/CXSparse/Source/cs_entry_ri.cpp $(START_DIR)/CXSparse/Source/cs_entry_ci.cpp $(START_DIR)/CXSparse/Source/cs_etree_ri.cpp $(START_DIR)/CXSparse/Source/cs_etree_ci.cpp $(START_DIR)/CXSparse/Source/cs_fkeep_ri.cpp $(START_DIR)/CXSparse/Source/cs_fkeep_ci.cpp $(START_DIR)/CXSparse/Source/cs_gaxpy_ri.cpp $(START_DIR)/CXSparse/Source/cs_gaxpy_ci.cpp $(START_DIR)/CXSparse/Source/cs_happly_ri.cpp $(START_DIR)/CXSparse/Source/cs_happly_ci.cpp $(START_DIR)/CXSparse/Source/cs_house_ri.cpp $(START_DIR)/CXSparse/Source/cs_house_ci.cpp $(START_DIR)/CXSparse/Source/cs_ipvec_ri.cpp $(START_DIR)/CXSparse/Source/cs_ipvec_ci.cpp $(START_DIR)/CXSparse/Source/cs_load_ri.cpp $(START_DIR)/CXSparse/Source/cs_load_ci.cpp $(START_DIR)/CXSparse/Source/cs_lsolve_ri.cpp $(START_DIR)/CXSparse/Source/cs_lsolve_ci.cpp $(START_DIR)/CXSparse/Source/cs_ltsolve_ri.cpp $(START_DIR)/CXSparse/Source/cs_ltsolve_ci.cpp $(START_DIR)/CXSparse/Source/cs_lu_ri.cpp $(START_DIR)/CXSparse/Source/cs_lu_ci.cpp $(START_DIR)/CXSparse/Source/cs_lusol_ri.cpp $(START_DIR)/CXSparse/Source/cs_lusol_ci.cpp $(START_DIR)/CXSparse/Source/cs_malloc_ri.cpp $(START_DIR)/CXSparse/Source/cs_malloc_ci.cpp $(START_DIR)/CXSparse/Source/cs_maxtrans_ri.cpp $(START_DIR)/CXSparse/Source/cs_maxtrans_ci.cpp $(START_DIR)/CXSparse/Source/cs_multiply_ri.cpp $(START_DIR)/CXSparse/Source/cs_multiply_ci.cpp $(START_DIR)/CXSparse/Source/cs_norm_ri.cpp $(START_DIR)/CXSparse/Source/cs_norm_ci.cpp $(START_DIR)/CXSparse/Source/cs_permute_ri.cpp $(START_DIR)/CXSparse/Source/cs_permute_ci.cpp $(START_DIR)/CXSparse/Source/cs_pinv_ri.cpp $(START_DIR)/CXSparse/Source/cs_pinv_ci.cpp $(START_DIR)/CXSparse/Source/cs_post_ri.cpp $(START_DIR)/CXSparse/Source/cs_post_ci.cpp $(START_DIR)/CXSparse/Source/cs_print_ri.cpp $(START_DIR)/CXSparse/Source/cs_print_ci.cpp $(START_DIR)/CXSparse/Source/cs_pvec_ri.cpp $(START_DIR)/CXSparse/Source/cs_pvec_ci.cpp $(START_DIR)/CXSparse/Source/cs_qr_ri.cpp $(START_DIR)/CXSparse/Source/cs_qr_ci.cpp $(START_DIR)/CXSparse/Source/cs_qrsol_ri.cpp $(START_DIR)/CXSparse/Source/cs_qrsol_ci.cpp $(START_DIR)/CXSparse/Source/cs_scatter_ri.cpp $(START_DIR)/CXSparse/Source/cs_scatter_ci.cpp $(START_DIR)/CXSparse/Source/cs_scc_ri.cpp $(START_DIR)/CXSparse/Source/cs_scc_ci.cpp $(START_DIR)/CXSparse/Source/cs_schol_ri.cpp $(START_DIR)/CXSparse/Source/cs_schol_ci.cpp $(START_DIR)/CXSparse/Source/cs_sqr_ri.cpp $(START_DIR)/CXSparse/Source/cs_sqr_ci.cpp $(START_DIR)/CXSparse/Source/cs_symperm_ri.cpp $(START_DIR)/CXSparse/Source/cs_symperm_ci.cpp $(START_DIR)/CXSparse/Source/cs_tdfs_ri.cpp $(START_DIR)/CXSparse/Source/cs_tdfs_ci.cpp $(START_DIR)/CXSparse/Source/cs_transpose_ri.cpp $(START_DIR)/CXSparse/Source/cs_transpose_ci.cpp $(START_DIR)/CXSparse/Source/cs_compress_ri.cpp $(START_DIR)/CXSparse/Source/cs_compress_ci.cpp $(START_DIR)/CXSparse/Source/cs_updown_ri.cpp $(START_DIR)/CXSparse/Source/cs_updown_ci.cpp $(START_DIR)/CXSparse/Source/cs_usolve_ri.cpp $(START_DIR)/CXSparse/Source/cs_usolve_ci.cpp $(START_DIR)/CXSparse/Source/cs_utsolve_ri.cpp $(START_DIR)/CXSparse/Source/cs_utsolve_ci.cpp $(START_DIR)/CXSparse/Source/cs_util_ri.cpp $(START_DIR)/CXSparse/Source/cs_util_ci.cpp $(START_DIR)/CXSparse/Source/cs_reach_ri.cpp $(START_DIR)/CXSparse/Source/cs_reach_ci.cpp $(START_DIR)/CXSparse/Source/cs_spsolve_ri.cpp $(START_DIR)/CXSparse/Source/cs_spsolve_ci.cpp $(START_DIR)/CXSparse/Source/cs_ereach_ri.cpp $(START_DIR)/CXSparse/Source/cs_ereach_ci.cpp $(START_DIR)/CXSparse/Source/cs_leaf_ri.cpp $(START_DIR)/CXSparse/Source/cs_leaf_ci.cpp $(START_DIR)/CXSparse/Source/cs_randperm_ri.cpp $(START_DIR)/CXSparse/Source/cs_randperm_ci.cpp $(START_DIR)/CXSparse/Source/cs_operator_ri.cpp $(START_DIR)/CXSparse/Source/cs_operator_ci.cpp $(START_DIR)/CXSparse/CXSparseSupport/solve_from_lu.cpp $(START_DIR)/CXSparse/CXSparseSupport/solve_from_qr.cpp $(START_DIR)/CXSparse/CXSparseSupport/makeCXSparseMatrix.cpp $(START_DIR)/CXSparse/CXSparseSupport/unpackCXStruct.cpp

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS = pt_data.obj pt_initialize.obj pt_terminate.obj pt.obj filter.obj conv.obj abs.obj filtfilt.obj introsort.obj insertionsort.obj bsxfun.obj mrdivide_helper.obj xnrm2.obj xscal.obj power.obj findpeaks.obj eml_setop.obj sortIdx.obj sort1.obj mean.obj diff.obj pt_emxutil.obj pt_emxAPI.obj rt_nonfinite.obj rtGetNaN.obj rtGetInf.obj cs_add_ri.obj cs_add_ci.obj cs_amd_ri.obj cs_amd_ci.obj cs_chol_ri.obj cs_chol_ci.obj cs_cholsol_ri.obj cs_cholsol_ci.obj cs_counts_ri.obj cs_counts_ci.obj cs_cumsum_ri.obj cs_cumsum_ci.obj cs_dfs_ri.obj cs_dfs_ci.obj cs_dmperm_ri.obj cs_dmperm_ci.obj cs_droptol_ri.obj cs_droptol_ci.obj cs_dropzeros_ri.obj cs_dropzeros_ci.obj cs_dupl_ri.obj cs_dupl_ci.obj cs_entry_ri.obj cs_entry_ci.obj cs_etree_ri.obj cs_etree_ci.obj cs_fkeep_ri.obj cs_fkeep_ci.obj cs_gaxpy_ri.obj cs_gaxpy_ci.obj cs_happly_ri.obj cs_happly_ci.obj cs_house_ri.obj cs_house_ci.obj cs_ipvec_ri.obj cs_ipvec_ci.obj cs_load_ri.obj cs_load_ci.obj cs_lsolve_ri.obj cs_lsolve_ci.obj cs_ltsolve_ri.obj cs_ltsolve_ci.obj cs_lu_ri.obj cs_lu_ci.obj cs_lusol_ri.obj cs_lusol_ci.obj cs_malloc_ri.obj cs_malloc_ci.obj cs_maxtrans_ri.obj cs_maxtrans_ci.obj cs_multiply_ri.obj cs_multiply_ci.obj cs_norm_ri.obj cs_norm_ci.obj cs_permute_ri.obj cs_permute_ci.obj cs_pinv_ri.obj cs_pinv_ci.obj cs_post_ri.obj cs_post_ci.obj cs_print_ri.obj cs_print_ci.obj cs_pvec_ri.obj cs_pvec_ci.obj cs_qr_ri.obj cs_qr_ci.obj cs_qrsol_ri.obj cs_qrsol_ci.obj cs_scatter_ri.obj cs_scatter_ci.obj cs_scc_ri.obj cs_scc_ci.obj cs_schol_ri.obj cs_schol_ci.obj cs_sqr_ri.obj cs_sqr_ci.obj cs_symperm_ri.obj cs_symperm_ci.obj cs_tdfs_ri.obj cs_tdfs_ci.obj cs_transpose_ri.obj cs_transpose_ci.obj cs_compress_ri.obj cs_compress_ci.obj cs_updown_ri.obj cs_updown_ci.obj cs_usolve_ri.obj cs_usolve_ci.obj cs_utsolve_ri.obj cs_utsolve_ci.obj cs_util_ri.obj cs_util_ci.obj cs_reach_ri.obj cs_reach_ci.obj cs_spsolve_ri.obj cs_spsolve_ci.obj cs_ereach_ri.obj cs_ereach_ci.obj cs_leaf_ri.obj cs_leaf_ci.obj cs_randperm_ri.obj cs_randperm_ci.obj cs_operator_ri.obj cs_operator_ci.obj solve_from_lu.obj solve_from_qr.obj makeCXSparseMatrix.obj unpackCXStruct.obj

ALL_OBJS = $(OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

LIBS = 

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_ = -fopenmp
CFLAGS_BASIC = $(DEFINES) $(INCLUDES) @$(COMPILER_COMMAND_FILE)

CFLAGS += $(CFLAGS_) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_ = -fopenmp
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES) @$(COMPILER_COMMAND_FILE)

CPPFLAGS += $(CPPFLAGS_) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_ = -fopenmp

CPP_LDFLAGS += $(CPP_LDFLAGS_)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_ = -fopenmp

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_)

#-----------
# Linker
#-----------

LDFLAGS_ = -fopenmp

LDFLAGS += $(LDFLAGS_)

#---------------------
# MEX C++ Compiler
#---------------------

MEX_CPP_Compiler_BASIC =  @$(COMPILER_COMMAND_FILE)

MEX_CPPFLAGS += $(MEX_CPP_Compiler_BASIC)

#-----------------
# MEX Compiler
#-----------------

MEX_Compiler_BASIC =  @$(COMPILER_COMMAND_FILE)

MEX_CFLAGS += $(MEX_Compiler_BASIC)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_ = -fopenmp

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_)

###########################################################################
## INLINED COMMANDS
###########################################################################


ifdef SIM_TARGET_BUILD
MINGW_C_STANDARD_OPTS = $(filter-out -ansi, $(C_STANDARD_OPTS))
else
MINGW_C_STANDARD_OPTS = $(C_STANDARD_OPTS)
endif


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build clean info prebuild download execute


all : build
	@echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


prebuild : 


download : build


execute : download


###########################################################################
## FINAL TARGET
###########################################################################

#---------------------------------
# Create a static library         
#---------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS)
	@echo "### Creating static library "$(PRODUCT)" ..."
	$(AR) $(ARFLAGS)  $(PRODUCT) @$(CMD_FILE)
	@echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.obj : %.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : %.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : E:/Project/epilepsy-detection/matlab/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : E:/Project/epilepsy-detection/matlab/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : $(MATLAB_ROOT)/rtw/c/src/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : $(MATLAB_ROOT)/rtw/c/src/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/CXSparse/Source/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/CXSparse/Source/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/CXSparse/CXSparseSupport/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.obj : $(START_DIR)/CXSparse/CXSparseSupport/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : rtw_proj.tmw $(COMPILER_COMMAND_FILE) $(MAKEFILE)


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@echo "### PRODUCT = $(PRODUCT)"
	@echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@echo "### BUILD_TYPE = $(BUILD_TYPE)"
	@echo "### INCLUDES = $(INCLUDES)"
	@echo "### DEFINES = $(DEFINES)"
	@echo "### ALL_SRCS = $(ALL_SRCS)"
	@echo "### ALL_OBJS = $(ALL_OBJS)"
	@echo "### LIBS = $(LIBS)"
	@echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	@echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@echo "### CFLAGS = $(CFLAGS)"
	@echo "### LDFLAGS = $(LDFLAGS)"
	@echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@echo "### CPPFLAGS = $(CPPFLAGS)"
	@echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@echo "### ARFLAGS = $(ARFLAGS)"
	@echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	@echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	@echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	@echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	@echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	$(RM) $(subst /,\,$(PRODUCT))
	$(RM) $(subst /,\,$(ALL_OBJS))
	$(ECHO) "### Deleted all derived files."


