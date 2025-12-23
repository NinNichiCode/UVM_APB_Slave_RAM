* Overview

This repository contains a complete UVM-based verification environment for an APB RAM design.
The project demonstrates how to build a structured, reusable, and coverage-driven UVM testbench, executed using QuestaSim under Cygwin on Windows.

The goal of this project is to verify the functional correctness, error handling, and corner cases of an APB-compliant RAM through multiple directed and constrained-random tests.

* Design Under Test (DUT)

Module: apb_ram.v

Bus Protocol: AMBA APB

Features:

Read / Write operations

Addressable memory

Protocol error handling

Reset behavior


* Implemented Tests

The following tests are implemented and can be run individually or as a regression:

<img width="541" height="322" alt="image" src="https://github.com/user-attachments/assets/1f92bf34-3dfc-4024-a798-11fb9f2c18dc" />


* Functional Coverage

Address coverage

Data value coverage

Read / write operation coverage

Error access coverage

Coverage results are collected into UCDB files and merged automatically.

* HTML coverage report location:

sim/cov/html/index.html

<img width="443" height="214" alt="image" src="https://github.com/user-attachments/assets/fb4f90b6-5d8f-4949-a432-b49ffcd9b0a7" />


<img width="539" height="353" alt="image" src="https://github.com/user-attachments/assets/a08925c2-a032-4f03-97ca-4454428734e8" />
