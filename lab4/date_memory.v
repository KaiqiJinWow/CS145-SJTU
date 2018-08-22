`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:21:16 03/14/2018 
// Design Name: 
// Module Name:    date_memory 
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
module date_memory(clock_in,address,writeData,memWrite,memRead,readData);
    input clock_in;
	 input [31:0] writeData;
	 input [31:0] address;
	 input memWrite;
	 input memRead;
	 output [31:0] readData;
    
	 reg [31:0] readData;
    reg [31:0] memFile[127:0];
	 
	 always @(memRead)
	 begin
      if (memRead) readData=memFile[address];
	 end
	 
	 always @(negedge clock_in)
	 begin
	    if (memWrite) memFile[address]=writeData;      
    end

endmodule
