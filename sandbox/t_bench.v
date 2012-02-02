`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:10:37 01/16/2012
// Design Name:   top
// Module Name:   C:/Users/J2/Documents/Sandbox/test_dcm/t_bench.v
// Project Name:  test_dcm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_bench;

	// Inputs
	reg clk;
	reg n_reset;

	// Outputs
	wire h_sync;
	wire v_sync;
    wire red;
    wire green;
    wire blue;
    

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.n_reset(n_reset), 
		.h_sync(h_sync),
      .v_sync(v_sync),
      .red(red),
      .green(green),
      .blue(blue)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		n_reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        n_reset = 1;
	end
      always @(clk)
		clk <= #5 ~clk;
endmodule

