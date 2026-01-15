// interface apb_if ();
//   logic              pclk;
//   logic              presetn;
//   logic       [31:0] paddr;
//   logic              pwrite;
//   logic       [31:0] pwdata;
//   logic              penable;
//   logic              psel;
//   logic       [31:0] prdata;
//   logic              pslverr;
//   logic              pready;
 
// endinterface : apb_if

interface apb_if();
  logic pclk;
  logic presetn;

  logic [31:0] paddr;
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;
  logic        pslverr;

  // 
  // clocking cb @(posedge pclk);
  //   default input #1step output #0;
  //   input  paddr, psel, penable, pwrite, pwdata, prdata, pready, pslverr;
  //   output paddr, psel, penable, pwrite, pwdata;
  // endclocking

  // // --- Modport for different components ---
  // modport master (clocking cb, input pclk, presetn);
  // modport slave  (clocking cb, input pclk, presetn);
  // modport monitor(input pclk, presetn,
  //                 paddr, psel, penable, pwrite, pwdata, prdata, pready, pslverr);

  // ================  SVA  =========================

  // P1: PENABLE must only be asserted after PSEL is high
  property p_penable_after_psel;
    @(posedge pclk) disable iff (!presetn)
      $rose(penable) |-> ##1 psel;
  endproperty
  a_penable_after_psel: assert property (p_penable_after_psel)
    else $error("APB SVA: PENABLE asserted without prior PSEL");

  // P2: PRDATA must be stable and known during read transfer
  property p_prdata_valid_on_read;
    @(posedge pclk) disable iff (!presetn)
      (psel && penable && !pwrite && pready) |-> !$isunknown(prdata);
  endproperty
  a_prdata_valid_on_read: assert property (p_prdata_valid_on_read)
    else $warning("APB SVA: PRDATA is unknown during valid read");

  // P3: PREADY must be high for exactly one cycle per transfer (zero-wait assumption)
  property p_pready_single_cycle;
    @(posedge pclk) disable iff (!presetn)
      pready |-> ##1 !pready;
  endproperty
  a_pready_single_cycle: assert property (p_pready_single_cycle)
    else $info("APB SVA: PREADY held >1 cycle (multi-cycle not supported in this model)");

  // P4: Slave error must be set for out-of-bound address (addr >= 32)
  property p_slverr_on_invalid_addr;
    @(posedge pclk) disable iff (!presetn)
      (psel && penable && (paddr >= 32)) |-> pslverr;
  endproperty
  a_slverr_on_invalid_addr: assert property (p_slverr_on_invalid_addr)
    else $error("APB SVA: Invalid address but PSLVERR not asserted");

  // P5: No bus activity when PSEL = 0
  property p_no_activity_when_psel_low;
    @(posedge pclk) disable iff (!presetn)
      !psel |-> (penable == 0);
  endproperty
  a_no_activity_when_psel_low: assert property (p_no_activity_when_psel_low)
    else $error("APB SVA: PENABLE high while PSEL low");

  // ==================================================
  // Coverage
  // ==================================================

  cover_psel:        cover property (@(posedge pclk) disable iff (!presetn) psel);
  cover_write:       cover property (@(posedge pclk) disable iff (!presetn) psel && penable && pwrite);
  cover_read:        cover property (@(posedge pclk) disable iff (!presetn) psel && penable && !pwrite);
  cover_slverr:      cover property (@(posedge pclk) disable iff (!presetn) pslverr);
  cover_valid_addr:  cover property (@(posedge pclk) disable iff (!presetn) psel && penable && (paddr < 32));
  cover_invalid_addr:cover property (@(posedge pclk) disable iff (!presetn) psel && penable && (paddr >= 32));

endinterface : apb_if
