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
    reg [7:0] memFile[127:0];
	 
	initial
	    begin 
		    //$readmemh("data.in",memFile,8'h0);
			 memFile[0]=8'h00000000;
			 memFile[1]=8'h00000001;
			 memFile[2]=8'h00000002;
			 memFile[3]=8'h00000003;
			 memFile[4]=8'h00000004;
			 memFile[5]=8'h00000005;
			 memFile[6]=8'h00000006;
			 memFile[7]=8'h00000007;
		 end
		 
	 always @(memRead or address or memWrite)
	 begin
      if (memRead) readData=memFile[address];
	 end
	 
	 always @(negedge clock_in)
	 begin
	   // if (memRead) readData=memFile[address];
	    if (memWrite) {memFile[address],memFile[address+1],memFile[address+2],memFile[address+3]} = writeData;      
    end

endmodule
