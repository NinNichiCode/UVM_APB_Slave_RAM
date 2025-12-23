
class wr_rd_test extends base_test;
    `uvm_component_utils(wr_rd_test)
 
function new(input string inst = "wr_rd_test", uvm_component c);
    super.new(inst,c);
endfunction

wr_rd_seq seq; 
 
virtual task run_test_seq();
    seq   = wr_rd_seq::type_id::create("seq");
    seq.start(env.a.seqr);
endtask
endclass
 