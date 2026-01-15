
LIB = work_apb_ram

INCDIRS = +incdir+../uvc/seq +incdir+../uvc/env +incdir+../uvc/tests

TESTS = write_test \
		read_test \
		wr_rd_test \
		write_err_test \
		read_err_test \
		reset_dut_test \
		wr_bulk_rd_bulk_test \
		apb_ram_test


all: compile regress coverage summary 

compile:
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv -cover bcetf ../apb_ram.v ../tb/apb_if.sv
	vlog -work work -sv $(INCDIRS) ../uvc/env/apb_ram_pkg.sv ../tb/top.sv

regress:
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t \
	-voptargs="+acc" -assertdebug \
	-l logs/$$t.log -do "coverage save -onexit cov/$$t.ucdb; run -all; quit";  \
	done

coverage:
	@echo "==== MERGING COVERAGE ===="
	rm -f cov/merged.ucdb
	vcover merge cov/merged.ucdb cov/*.ucdb
	vcover report -html cov/merged.ucdb -htmldir cov/html
	vcover report -details -file cov/coverage.txt cov/merged.ucdb

summary:
	@echo "========================================="
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed 's#.*/##'

clean:
	rm -rf $(LIB) transcript logs *.log modelsim.ini cov

.PHONY: all compile regress summary clean 

