`timescale 1ns / 1ps


module ram_async_interface(
  output [25:0] ADDR,
  inout  [15:0] DATA,
  output MEMnOE,
  output MEMnWR,
  output MEMnAdv,
  input  MEMWait,
  output MEMClk,
  output RAMnCS,
  output RAMCRE,
  output RAMnUB,
  output RAMnLB,
  
  input clk_i,
  input nreset_i,
  
  input  cs_i,
  input  rnw_i,
  input  [25:0] addr_i,
  input  [15:0] wdata_i,
  output [15:0] rdata_o,
  output ready_o
);


reg [25:0] ADDR_q;
reg [15:0] wdata_q;
reg MEMnOE_q;
reg MEMnWR_q;
reg MEMnAdv_q;
reg MEMClk_q;
reg RAMnCS_q;
reg RAMCRE_q;
reg RAMnUB_q;
reg RAMnLB_q;


reg [15:0] rdata_q;
reg ready_q;



/*
//async mode
//assign MEMWait  = 1'b0;
assign MEMClk   = 1'b0;
assign RAMCRE   = 1'b0;
//16bits access
assign RAMnUB   = 1'b0;
assign RAMnLB   = 1'b0;


assign ADDR     = addr_i;
assign MEMnAdv  = 1'b0;
assign RAMnCS   = ~cs_i;
assign MEMnOE   = ~rnw_i;
assign MEMnWR   = rnw_i;
*/
//assign DATA     = rnw_i ? {16{1'bz}} : wdata_i;
assign DATA     = MEMnWR_q ? {16{1'bz}} : wdata_q;
assign rdata_o  = MEMnWR_q ? DATA : {16{1'b0}};


reg [2:0] cpt_rdy_q;
always @(posedge clk_i or negedge nreset_i)
  if(~nreset_i)
    cpt_rdy_q <= 3'b000;
  else if (cs_i)
    cpt_rdy_q <= cpt_rdy_q + 3'b001;

assign ready_o = cpt_rdy_q == 3'b111;

initial begin
    RAMnCS_q = 1;
    #160000;
    MEMClk_q = 0;
    MEMnAdv_q = 0;
    RAMCRE_q = 0;
    RAMnCS_q = 0;
    MEMnOE_q = 1;
    MEMnWR_q = 0;
    RAMnLB_q = 0;
    RAMnUB_q = 0;
    ADDR_q   = 0;
    wdata_q  = 0;
    #100;
    RAMnCS_q = 1;
    #100;
    RAMnCS_q = 0;
    ADDR_q   = 1;
    #500;
    RAMnCS_q = 1;
    #100;
    
    MEMClk_q   = 1'b0;
    RAMCRE_q   = 1'b0;
    //16bits access
    RAMnUB_q   = 1'b0;
    RAMnLB_q   = 1'b0;
    ADDR_q     = addr_i;
    MEMnAdv_q  = 1'b0;
    RAMnCS_q   = ~cs_i;
    MEMnOE_q   = ~rnw_i;
    MEMnWR_q   = rnw_i;
    
    
end

assign ADDR = ADDR_q;
assign wdata = wdata_q;
assign MEMnOE = MEMnOE_q;
assign MEMnWR = MEMnWR_q;
assign MEMnAdv = MEMnAdv_q;
assign MEMClk = MEMClk_q;
assign RAMnCS = RAMnCS_q;
assign RAMCRE = RAMCRE_q;
assign RAMnUB = RAMnUB_q;
assign RAMnLB = RAMnLB_q;



endmodule
