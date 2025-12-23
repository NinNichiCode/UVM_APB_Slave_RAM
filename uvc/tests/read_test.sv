
class read_test extends base_test;
    `uvm_component_utils(read_test)
 
function new(input string inst = "read_test", uvm_component c);
super.new(inst,c);
endfunction

read_seq seq; 

 
virtual task run_test_seq();
  seq   = read_seq::type_id::create("seq");
    seq.start(env.a.seqr);
endtask
endclass


 