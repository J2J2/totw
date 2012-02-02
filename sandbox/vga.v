`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:20 01/17/2012 
// Design Name: 
// Module Name:    vga 
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
module vga(
    input clk,
    input n_rst,
    output h_sync,
    output v_sync,
    output wire [2:0] red,
    output wire [2:0] green,
    output wire [1:0] blue,
    output reg [9:0] col,
    output reg [9:0] row,
    input [15:0] data_i
    );

always @(negedge n_rst or posedge clk) begin
    if(~n_rst)
        col <= {10{1'b0}};
    else if(col<800)
        col <= col + 10'b00_0000_0001;
    else 
        col <= {10{1'b0}};
end

assign h_sync =  (col <96 ) ? 1'b0 : 1'b1;

always @(negedge n_rst or posedge clk) begin
    if(~n_rst)
        row <= {10{1'b0}};
    else if(col == 10'b00_0000_0000)
        row <= row + 10'b0_0000_0001;
    else if(row >520)
        row <= {10{1'b0}};
end

assign v_sync =  (row <2 ) ? 1'b0 : 1'b1;
/*
assign red   = col[0] == 1'b0 ? data_i[2:0] : data_i[10:8];
assign green = col[0] == 1'b0 ? data_i[5:3] : data_i[13:11];
assign blue  = col[0] == 1'b0 ? data_i[7:6] : data_i[15:14];
*/

//wire ok = (col == 134) || (col == 639+134) || row ==32 || row ==32+475;
//wire ok = row[0] == 1'b0;

assign red   = col==136 ? 3'b111 : 3'b000;
assign green = col> 150 && col < 700 ? (col[6:4]-2):3'b000;
assign blue  = col==138 ? 2'b11 : 2'b00;


/*
assign red   = col[0] == 1'b0 ? data_i[7:5] : data_i[15:13];
assign green = col[0] == 1'b0 ? data_i[4:2] : data_i[12:10];
assign blue  = col[0] == 1'b0 ? data_i[1:0] : data_i[9:8];
*/
endmodule
