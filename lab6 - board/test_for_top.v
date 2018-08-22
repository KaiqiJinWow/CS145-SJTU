`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:37:27 04/03/2018
// Design Name:   Top
// Module Name:   E:/516030910382_jinkaiqi/lab6/test_for_top.v
// Project Name:  lab6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_top;

	// Inputs
	reg CLOCK_IN;
	reg RESET;
	reg [3:0] SWITCH;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK_IN(CLOCK_IN), 
		.RESET(RESET), 
		.SWITCH(SWITCH), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		CLOCK_IN = 0;
		RESET = 1;
		SWITCH = 0;

		// Wait 100 ns for global reset to finish
		#100;
      RESET=0;  
		// Add stimulus here

	end
always
    #20   CLOCK_IN=~CLOCK_IN;

endmodule

