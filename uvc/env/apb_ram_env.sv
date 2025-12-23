class apb_ram_env extends uvm_env;
`uvm_component_utils(apb_ram_env)
 
function new(input string inst = "apb_ram_env", uvm_component c);
super.new(inst,c);
endfunction
 
apb_ram_agent a;
apb_ram_scoreboard s;
apb_ram_coverage cov;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  a = apb_ram_agent::type_id::create("a",this);
  s = apb_ram_scoreboard::type_id::create("s", this);
  cov = apb_ram_coverage::type_id::create("cov", this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.item_send_port.connect(s.item_recv_imp);
a.m.item_send_port.connect(cov.analysis_export);
endfunction
 
endclass