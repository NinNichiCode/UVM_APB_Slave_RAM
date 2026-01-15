
class apb_ram_monitor extends uvm_monitor;
`uvm_component_utils(apb_ram_monitor)
 
uvm_analysis_port#(transaction) item_send_port;
transaction tr;
virtual apb_if vif;
 
    function new(input string inst = "apb_ram_monitor", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    item_send_port = new("item_send_port", this);
      if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
        `uvm_error("MON","Unable to access Interface");
    endfunction
    
    
virtual task run_phase(uvm_phase phase);
    forever begin
        @(posedge vif.pclk);
        if (!vif.presetn) begin
            transaction rst_tr = transaction::type_id::create("rst_tr");
            rst_tr.op = transaction::rst;
            item_send_port.write(rst_tr);
        end
        else if (vif.psel && vif.penable && vif.pready) begin
            transaction collected_tr = transaction::type_id::create("collected_tr");
            
            collected_tr.PADDR   = vif.paddr;
            collected_tr.PWRITE  = vif.pwrite;
            collected_tr.op      = (vif.pwrite) ? transaction::writed : transaction::readd;
            collected_tr.PSLVERR = vif.pslverr; 
            
            if (vif.pwrite) 
                collected_tr.PWDATA = vif.pwdata;
            else            
                collected_tr.PRDATA = vif.prdata;

            `uvm_info("MON", $sformatf("Collected: addr:%0d, pslverr:%0b", collected_tr.PADDR, collected_tr.PSLVERR), UVM_HIGH)
            item_send_port.write(collected_tr);
        end
    end
endtask
 
endclass