class apb_ram_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(apb_ram_seq)
  
  transaction tr;
 
  function new(string name = "apb_ram_seq");
    super.new(name);
  endfunction
  
  virtual task body();
        repeat(10) begin
            tr = transaction::type_id::create("tr");
            tr.addr_c.constraint_mode(0);
            tr.addr_c_err.constraint_mode(0);
            start_item(tr);
            assert(tr.randomize() with { 
                PADDR == 32'hFFFF_FFFF; 
            });
            finish_item(tr);
            
            #20;

            start_item(tr);
            assert(tr.randomize() with { 
                PADDR == 32'h0000_0000; 
            });
            finish_item(tr);
        end
  endtask  
 
endclass