`timescale 1ns / 1ps

module tb_ram_controller;

  // Inputs
  reg clk;
  reg sw0;

  // Outputs
  wire [7:0] seg;
  wire [3:0] an;
  wire [7:0] Led;
  wire [25:0] ADDR;
  wire MEMnOE;
  wire MEMnWR;
  wire MEMnAdv;
  wire MEMWait;
  wire MEMClk;
  wire RAMnCS;
  wire RAMCRE;
  wire RAMnUB;
  wire RAMnLB;

  // Bidirs
  wire [15:0] DATA;

  // Instantiate the Unit Under Test (UUT)
  ram_async_interface ram_async_interface_u (
    .clk(clk), 
    .sw0(sw0), 
    .seg(seg), 
    .an(an), 
    .Led(Led), 
    .ADDR(ADDR), 
    .DATA(DATA), 
    .MEMnOE(MEMnOE), 
    .MEMnWR(MEMnWR), 
    .MEMnAdv(MEMnAdv), 
    .MEMWait(MEMWait), 
    .MEMClk(MEMClk), 
    .RAMnCS(RAMnCS), 
    .RAMCRE(RAMCRE), 
    .RAMnUB(RAMnUB), 
    .RAMnLB(RAMnLB)
  );

  
  
cellram cellram_u (
    .clk(MEMClk), 
    .adv_n(MEMnAdv), 
    .cre(RAMCRE), 
    .o_wait(MEMWait), 
    .ce_n(RAMnCS), 
    .oe_n(MEMnOE), 
    .we_n(MEMnWR), 
    .lb_n(RAMnLB), 
    .ub_n(RAMnUB), 
    .addr(ADDR), 
    .dq(DATA)
    );
    
  initial begin
    // Initialize Inputs
    clk = 0;
    sw0 = 0;

    // Wait 100 ns for global reset to finish
    #165000;
    /*MEMClk = 0;
    MEMnAdv = 0;
    RAMCRE = 1;
    RAMnCS = 0;
    MEMnOE = 1;
    MEMnWR = 0;
    RAMnLB = 0;
    RAMnUB = 0;
    ADDR   = 0;
    DATA   = 0;
    #100;
    ADDR   = 1;
    #100;
    RAMnCS = 1;
    #100;*/
      sw0 = 1;
    // Add stimulus here

  end
  
always @(clk)
    clk <= #5 ~clk;
      
endmodule

