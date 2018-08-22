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
module register( clock_in, readReg1, readReg2, writeReg, regWrite, writeData, readData1, readData2,rst);
     input clock_in;
	  input [25:21] readReg1;
	  input [20:16] readReg2;
	  input [4:0] writeReg;
	  input [31:0] writeData;
	  input regWrite;
	  input rst;
	  output [31:0] readData1;
	  output [31:0] readData2;
	  
	  reg [31:0] regFile[7:0];
	  reg [31:0] readData1;
	  reg [31:0] readData2;
	  integer i;
	  
	  initial
		begin
		//	$readmemh("register.in",regFile,8'h0);
			regFile[0]=8'h1;
			regFile[1]=8'h1;
			regFile[2]=8'h1;
			regFile[3]=8'h1;
			regFile[4]=8'h1;
			regFile[5]=8'h1;
			regFile[6]=8'h1;
			regFile[7]=8'h1;
		end
	  always @(readReg1 or readReg2 or regFile[readReg1] or regFile[readReg2])
	  begin
	     readData1=regFile[readReg1];
		readData2=regFile[readReg2];
	  end
	  
	  always @(negedge clock_in)
	  begin
	     if (rst)
		  begin 
		     for (i=0;i<=7;i=i+1)
			      regFile[i]=0;
		  end
	     else if (regWrite)
		  begin
		      regFile[writeReg]=writeData;
				//readData1<=regFile[readReg1];
			   //readData2<=regFile[readReg2];
		  end
				//readData1<=regFile[readReg1];
			  // readData2<=regFile[readReg2];
	  end


endmodule
