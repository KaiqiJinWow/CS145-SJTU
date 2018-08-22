`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:51:17 03/14/2018
// Design Name:   date_memory
// Module Name:   E:/516030910382_jinkaiqi/lab4/test_for_date_memory.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: date_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_date_memory;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memWrite;
	reg memRead;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	date_memory uut (
		.clock_in(clock_in), 
		.address(address), 
		.writeData(writeData), 
		.memWrite(memWrite), 
		.memRead(memRead), 
		.readData(readData)
	);
	always 
	     begin 
		   #100; 
			clock_in=~clock_in;
        end	    
	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memWrite = 0;
		memRead = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
      #185;
		memWrite=1'b1;
		address=15;
		writeData=-65536;
		#250;
		memRead = 1'b1;
		memWrite = 1'b0;
	end
//always #100 clock_in=~clock_in;
endmodule

