`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:10:29 03/14/2018 
// Design Name: 
// Module Name:    register 
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
module register( clock_in, readReg1, readReg2, writeReg, regWrite, writeData, readData1, readData2,rst,showAddress,display);
     input clock_in;
	  input [25:21] readReg1;
	  input [20:16] readReg2;
	  input [4:0] writeReg;
	  input [2:0] showAddress;
	  input [31:0] writeData;
	  input regWrite;
	  input rst;
	  output [31:0] readData1;
	  output [31:0] readData2;
	  output reg [31:0] display;
	  
	  reg [31:0] regFile[7:0];
	  reg [31:0] readData1;
	  reg [31:0] readData2;
	  integer i;
	  
	  initial
		begin
		   regFile[0]<=32'b00000000000000000000000000000000;
			regFile[1]<=32'b00000000000000000000000000000000;
			regFile[2]<=32'b00000000000000000000000000000000;
			regFile[3]<=32'b00000000000000000000000000000000;
			regFile[4]<=32'b00000000000000000000000000000000;
			regFile[5]<=32'b00000000000000000000000000000000;
			regFile[6]<=32'b00000000000000000000000000000000;
			regFile[7]<=32'b00000000000000000000000000000000;
			//$readmemh("register.in",regFile,8'h0);
		end
	  always @(readReg1 or readReg2 or showAddress)
	  begin
	      readData1=regFile[readReg1];
			readData2=regFile[readReg2];
			display = regFile[showAddress];
	  end
	  
	  always @(negedge clock_in)
	  begin
	     if (rst)
		  begin 
		     for (i=0;i<8;i=i+1)
			       regFile[i]=0;
		  end
	     else if (regWrite)
		      regFile[writeReg]=writeData; 
	  end
endmodule
