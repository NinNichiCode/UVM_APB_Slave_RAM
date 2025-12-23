
class write_err_test extends base_test;
    `uvm_component_utils(write_err_test)
 
function new(input string inst = "write_err_test", uvm_component c);
super.new(inst,c);
endfunction

write_err_seq seq; 

virtual task run_test_seq();
seq   = write_err_seq::type_id::create("seq");
seq.start(env.a.seqr);
endtask
endclass
 