# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
# Simple tests for an adder module
import random

import cocotb
from cocotb.triggers import Timer


if cocotb.simulator.is_running():
    from adder_model import adder_model
    from subtractor_model import subtractor_model

ITER = 10000

@cocotb.test()
async def adder_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(ITER):
        A = random.randint(0, 0xFFFFFFFF)
        B = random.randint(0, 0xFFFFFFFF)

        dut.exu2ialu_cmd_i.value = 4

        dut.exu2ialu_main_op1_i.value = A
        dut.exu2ialu_main_op2_i.value = B

        await Timer(2, units="ns")

        assert dut.ialu2exu_main_res_o.value == adder_model(
            A, B
        ), f"Randomised test failed with: {dut.exu2ialu_main_op1_i.value} + {dut.exu2ialu_main_op2_i.value} = {dut.ialu2exu_main_res_o.value}"


@cocotb.test()
async def sub_randomised_test(dut):
    """Test for subtracting 2 random numbers multiple times"""

    for i in range(ITER):
        A = random.randint(0, 0xFFFFFFFF)
        B = random.randint(0, 0xFFFFFFFF)

        dut.exu2ialu_cmd_i.value = 5

        dut.exu2ialu_main_op1_i.value = A
        dut.exu2ialu_main_op2_i.value = B

        await Timer(2, units="ns")

        assert dut.ialu2exu_main_res_o.value == subtractor_model(
            A, B
        ), f"Randomised test failed with: {dut.exu2ialu_main_op1_i.value} - {dut.exu2ialu_main_op2_i.value} = {dut.ialu2exu_main_res_o.value}"


