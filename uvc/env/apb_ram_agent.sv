
class apb_ram_agent extends uvm_agent;
`uvm_component_utils(apb_ram_agent)
  
  abp_config cfg;
 
function new(input string inst = "apb_ram_agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
 apb_ram_driver d;
 uvm_sequencer#(transaction) seqr;
 apb_ram_monitor m;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  cfg =  abp_config::type_id::create("cfg"); 
   m = apb_ram_monitor::type_id::create("m",this);
  
  if(cfg.is_active == UVM_ACTIVE)
   begin   
   d = apb_ram_driver::type_id::create("d",this);
   seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
   end
  
  
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  if(cfg.is_active == UVM_ACTIVE) begin  
    d.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction
 
endclass