
class reset_dut_test extends base_test;
    `uvm_component_utils(reset_dut_test)
 
function new(input string inst = "reset_dut_test", uvm_component c);
super.new(inst,c);
endfunction

reset_dut_seq seq; 
  
virtual task run_test_seq();
 seq   = reset_dut_seq::type_id::create("seq");
seq.start(env.a.seqr);
endtask
endclass
 