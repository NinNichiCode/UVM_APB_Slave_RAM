class read_err_test extends base_test;
    `uvm_component_utils(read_err_test)
 
function new(input string inst = "read_err_test", uvm_component c);
super.new(inst,c);
endfunction

read_err_seq seq; 

virtual task run_test_seq();
  seq   = read_err_seq::type_id::create("seq");
    seq.start(env.a.seqr);
endtask
endclass


 
 