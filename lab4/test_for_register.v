`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:39:25 03/14/2018
// Design Name:   register
// Module Name:   E:/516030910382_jinkaiqi/lab4/test_for_register.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_register;

	// Inputs
	reg clock_in;
	reg [25:21] readReg1;
	reg [20:16] readReg2;
	reg [4:0] writeReg;
	reg regWrite;
	reg [31:0] writeData;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;

	// Instantiate the Unit Under Test (UUT)
	register uut (
		.clock_in(clock_in), 
		.readReg1(readReg1), 
		.readReg2(readReg2), 
		.writeReg(writeReg), 
		.regWrite(regWrite), 
		.writeData(writeData), 
		.readData1(readData1), 
		.readData2(readData2)
	);   
	always 
	     begin 
		   #100; 
			clock_in=~clock_in;
        end	 
	initial begin
		// Initialize Inputs
		clock_in = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		regWrite = 0;
		writeData = 0;


  	// Wait 100 ns for global reset to finish
	   #100;
		clock_in = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		regWrite = 0;
		writeData = 0;
		#285;
      regWrite = 1'b1;
      writeReg = 21;
      writeData = 4294901760;

      #200;
      writeReg = 10;
      writeData = 65535;
      
      #200;
      regWrite = 1'b0;
      writeReg = 5'b00000;
      writeData = 32'b00000000000000000000000000000000;

      #50;
      readReg1 = 21;
      readReg2 = 10;		
		// Add stimulus here
	end
   
endmodule

