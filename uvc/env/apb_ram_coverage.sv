class apb_ram_coverage extends uvm_subscriber#(transaction);
    `uvm_component_utils(apb_ram_coverage)

    transaction trans;

covergroup cov_inst;
    // 1. 
    CP_OP: coverpoint trans.op {
        bins read  = {transaction::readd};
        bins write = {transaction::writed};
        bins reset = {transaction::rst};
    }

    // 2. 
    CP_ADDR: coverpoint trans.PADDR {
        bins valid[] = {[0:31]};
        bins invalid = {[32:$]};
    }

    // 3. Cross: addr for wr and rd
    X_RW_ADDR: cross CP_OP, CP_ADDR {
        // focus on cross forr readd and writed
        ignore_bins reset_op = binsof(CP_OP) intersect {transaction::rst};
        bins addr_error = binsof(CP_ADDR.invalid);
    }

    // 4.  (Slave Error)
    CP_PSLVERR: coverpoint trans.PSLVERR {
        bins no_err = {0};
        bins has_err = {1};
    }

    // 5. 
        X_ERR_VALIDATION: cross CP_ADDR, CP_PSLVERR {
            bins pslverr_hit = binsof(CP_ADDR.invalid) && binsof(CP_PSLVERR.has_err);

            illegal_bins unexpected_err = binsof(CP_ADDR.valid) && binsof(CP_PSLVERR.has_err);

            ignore_bins ignore_valid_no_err = binsof(CP_ADDR.valid) && binsof(CP_PSLVERR.no_err);
            ignore_bins ignore_invalid_no_err = binsof(CP_ADDR.invalid) && binsof(CP_PSLVERR.no_err);
        }
endgroup

    function new(string name ="apb_ram_coverage", uvm_component parent = null);
        super.new(name, parent);
        cov_inst = new();
    endfunction

    virtual function void write(transaction t);
        trans = t;
        cov_inst.sample(); 
    endfunction
endclass