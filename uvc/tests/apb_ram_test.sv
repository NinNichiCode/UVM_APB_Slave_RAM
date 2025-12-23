
class apb_ram_test extends base_test;
    `uvm_component_utils(apb_ram_test)
 
function new(input string inst = "apb_ram_test", uvm_component c);
    super.new(inst,c);
endfunction

apb_ram_seq seq;
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  seq   = apb_ram_seq::type_id::create("seq");
endfunction
 
virtual task run_test_seq();
    seq.start(env.a.seqr);
endtask
endclass
 