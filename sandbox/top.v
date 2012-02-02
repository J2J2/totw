`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:35 08/10/2011 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
  input clk,
  input n_reset,
  
  output  h_sync,
  output v_sync,
  output wire [2:0] red,
  output wire [2:0] green,
  output wire [1:0] blue,
  
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
  output RAMnLB
);
wire LOCKED;
wire clk_25mhz;
wire clk_100mhz;
dcm instance_name
   (// Clock in ports
    .CLK_IN1(clk),      // IN
    // Clock out ports
    .CLK_OUT1(clk_25mhz),     // OUT
    .CLK_OUT2(clk_100mhz),     // OUT
    // Status and control signals
    .RESET(~n_reset),// IN
    .LOCKED(LOCKED)
);

wire [9:0] col;
wire [9:0] row;
wire [15:0] rdata;
reg [15:0] wdata;
wire ready;


vga vga_u0(
    .clk     (clk_25mhz),
    .n_rst   (n_reset),
    .h_sync  (h_sync),
    .v_sync  (v_sync),
    .red     (red),
    .green   (green),
    .blue    (blue),
    .row     (row),
    .col     (col),
    .data_i  (rdata)
    );



reg [25:0] addr;
always @(negedge n_reset or posedge clk_100mhz) begin
    if(~n_reset)
        addr <= {26{1'b0}};
    else if(col>133 && row >31)
        addr <= (col-134)+((row-32)*640);
end
/*
ram_async_interface ram_async_interface_u(
  .ADDR( ADDR ), 
  .DATA(DATA), 
  .MEMnOE(MEMnOE), 
  .MEMnWR(MEMnWR), 
  .MEMnAdv(MEMnAdv), 
  .MEMWait(MEMWait), 
  .MEMClk(MEMClk), 
  .RAMnCS(RAMnCS), 
  .RAMCRE(RAMCRE), 
  .RAMnUB(RAMnUB), 
  .RAMnLB(RAMnLB), 
  .clk_i(clk), 
  .nreset_i(n_reset), 
  .cs_i(n_reset), 
  .rnw_i(n_reset), 
  //.addr_i({ {7{1'b0}}, row, col[9:1] }), 
  .addr_i({1'b0,addr[25:1]}),
  .wdata_i(wdata), 
  .rdata_o(rdata), 
  .ready_o(ready)
);
*/
endmodule
