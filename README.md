*Overview

This repository contains a complete UVM-based verification environment for an APB RAM design.
The project demonstrates how to build a structured, reusable, and coverage-driven UVM testbench, executed using QuestaSim under Cygwin on Windows.

The goal of this project is to verify the functional correctness, error handling, and corner cases of an APB-compliant RAM through multiple directed and constrained-random tests.

*Design Under Test (DUT)

Module: apb_ram.v

Bus Protocol: AMBA APB

Features:

Read / Write operations

Addressable memory

Protocol error handling

Reset behavior


*Implemented Tests

The following tests are implemented and can be run individually or as a regression:

Test Name	Description
reset_dut_test	Verify DUT reset behavior
write_test	Single write transactions
read_test	Single read transactions
wr_rd_test	Mixed write-read operations
wr_bulk_rd_bulk_test	Burst write followed by burst read
write_err_test	Invalid write access
read_err_test	Invalid read access

*Functional Coverage

Address coverage

Data value coverage

Read / write operation coverage

Error access coverage

*Coverage results are collected into UCDB files and merged automatically.

 HTML coverage report location:

sim/cov/html/index.html

<img width="539" height="353" alt="image" src="https://github.com/user-attachments/assets/a08925c2-a032-4f03-97ca-4454428734e8" />
