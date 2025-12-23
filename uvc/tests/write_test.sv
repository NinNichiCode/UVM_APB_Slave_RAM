
class write_test extends base_test;
    `uvm_component_utils(write_test)
 
function new(input string inst = "write_test", uvm_component c);
super.new(inst,c);
endfunction
 
virtual task run_test_seq();
write_seq seq; 
 seq   = write_seq::type_id::create("seq");
seq.start(env.a.seqr);
endtask
endclass
 