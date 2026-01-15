class write_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(write_seq)
  
  transaction tr;
 
  function new(string name = "write_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(100)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);//enable 
        tr.addr_c_err.constraint_mode(0);//disable
 
        start_item(tr);
        assert(tr.randomize() with {
            op == writed;
        });
        finish_item(tr);        
      end
  endtask
  
 
endclass