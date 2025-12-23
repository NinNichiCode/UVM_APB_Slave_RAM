class read_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(read_seq)
  
  transaction tr;
 
  function new(string name = "read_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(1)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        tr.addr_c_err.constraint_mode(0);//disable
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        finish_item(tr);
      end
  endtask
  
 
endclass