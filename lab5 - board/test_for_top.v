`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:04:34 03/21/2018
// Design Name:   Top
// Module Name:   E:/516030910382_jinkaiqi/lab5/test_for_top.v
// Project Name:  lab5
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
	reg clk;
	reg reset;
   reg [2:0]switches;
	wire [7:0] LED;
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clock(clk), 
		.reset(reset),
		.switches(switches),
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		clk <= 0;
		reset <= 0;
      switches <=0;
		// Wait 100 ns for global reset to finish
		#1100;
      reset <= 1;  
		// Add stimulus here

	end
   
   always
   #50 clk=~clk;   
endmodule

