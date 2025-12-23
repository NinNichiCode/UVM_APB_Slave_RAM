class read_err_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(read_err_seq)
  
  transaction tr;
 
  function new(string name = "read_err_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(300)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(0);
        tr.addr_c_err.constraint_mode(1);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        finish_item(tr);
      end
  endtask
  
 
endclass