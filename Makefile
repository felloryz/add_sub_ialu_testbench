# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/scr1_pipe_ialu.sv
VERILOG_SOURCES += $(PWD)/scr1_arch_description.svh
VERILOG_SOURCES += $(PWD)/scr1_arch_types.svh
VERILOG_SOURCES += $(PWD)/scr1_riscv_isa_decoding.svh
VERILOG_SOURCES += $(PWD)/scr1_search_ms1.svh
# use VHDL_SOURCES for VHDL files

EXTRA_ARGS += -Wno-WIDTHEXPAND -Wno-CASEINCOMPLETE
EXTRA_ARGS += --trace --trace-structs --coverage

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = scr1_pipe_ialu

# MODULE is the basename of the Python test file
MODULE = test_add_sub

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
