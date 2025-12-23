class wr_rd_seq extends uvm_sequence#(transaction); //////read after write
  `uvm_object_utils(wr_rd_seq)
  
  transaction tr;
 
  function new(string name = "wr_rd_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(300)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        tr.addr_c_err.constraint_mode(0);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = writed;
        finish_item(tr);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        finish_item(tr);
 
      end
  endtask
  
 
endclass