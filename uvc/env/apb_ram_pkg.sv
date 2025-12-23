
package apb_ram_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

    `include "transaction.sv"
    `include "apb_ram_seq.sv"
    `include "write_seq.sv"
	`include "read_seq.sv"
	`include "wr_rd_seq.sv"
	`include "write_err_seq.sv"
	`include "read_err_seq.sv"
	`include "reset_dut_seq.sv"
	`include "wr_bulk_rd_bulk_seq.sv"


    `include "apb_config.sv"
    `include "apb_ram_driver.sv"
    `include "apb_ram_monitor.sv"
    `include "apb_ram_agent.sv"
    `include "apb_ram_scoreboard.sv"
    `include "apb_ram_coverage.sv"
    `include "apb_ram_env.sv"

    `include "base_test.sv"
    `include "apb_ram_test.sv"
    `include "write_test.sv"
	`include "read_test.sv"
	`include "wr_rd_test.sv"
	`include "write_err_test.sv"
	`include "read_err_test.sv"
	`include "reset_dut_test.sv"
	`include "wr_bulk_rd_bulk_test.sv"

endpackage
