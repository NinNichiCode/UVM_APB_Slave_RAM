class wr_bulk_rd_bulk_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(wr_bulk_rd_bulk_seq)
  
  transaction tr;
 
  function new(string name = "wr_bulk_rd_bulk_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    
    repeat(100) begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        tr.addr_c_err.constraint_mode(0);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = writed;
        finish_item(tr);
      
    end
      
    repeat(15) begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        tr.addr_c_err.constraint_mode(0);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        finish_item(tr);
      
    end
  endtask
  
 
endclass