import random

import cocotb
from cocotb.triggers import Timer

if cocotb.simulator.is_running():
    from adder_model import adder_model
    from subtractor_model import subtractor_model

ITER = 10000 # кол-во итераций операций сложения и вычитания

@cocotb.test()
async def adder_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(ITER):
        A = random.randint(0, 0xFFFFFFFF)
        B = random.randint(0, 0xFFFFFFFF)

        dut.exu2ialu_cmd_i.value = 4 # код команды ADD

        dut.exu2ialu_main_op1_i.value = A # назначаем значение первому операнду
        dut.exu2ialu_main_op2_i.value = B # назначаем значение второму операнду

        await Timer(2, units="ns")

        # в случае несовпадения результата сложения выводим ошибку и останавливаем работу
        assert dut.ialu2exu_main_res_o.value == adder_model(
            A, B
        ), f"Randomised test failed with: {dut.exu2ialu_main_op1_i.value} + {dut.exu2ialu_main_op2_i.value} = {dut.ialu2exu_main_res_o.value}"


@cocotb.test()
async def sub_randomised_test(dut):
    """Test for subtracting 2 random numbers multiple times"""

    for i in range(ITER):
        A = random.randint(0, 0xFFFFFFFF)
        B = random.randint(0, 0xFFFFFFFF)

        dut.exu2ialu_cmd_i.value = 5 # код команды SUB

        dut.exu2ialu_main_op1_i.value = A
        dut.exu2ialu_main_op2_i.value = B

        await Timer(2, units="ns")

        # в случае несовпадения результата вычитания выводим ошибку и останавливаем работу
        assert dut.ialu2exu_main_res_o.value == subtractor_model(
            A, B
        ), f"Randomised test failed with: {dut.exu2ialu_main_op1_i.value} - {dut.exu2ialu_main_op2_i.value} = {dut.ialu2exu_main_res_o.value}"


