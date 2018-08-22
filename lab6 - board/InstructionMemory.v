`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:47 04/03/2018 
// Design Name: 
// Module Name:    InstructionMemory 
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
module InstructionMemory(IMaddress,IMCLK,IMRESET,IMreadData);
    input [31:0]IMaddress;
	 input IMCLK;
	 input IMRESET;
	 output [31:0]  IMreadData;
	 reg [31:0] memBuffer[0:17];
	 reg [31:0] IMreadData;
	 
	 always @(IMRESET)
	   begin
		if (IMRESET==1) 
			begin
        memBuffer[1]=32'b10001100000000010000000000000001;//lw $1,1($0) 
		  memBuffer[2]=32'b00000000000000010010000000100000;//$4=$1+$0
		  memBuffer[3]=32'b10001100000000100000000000000101;//lw $2,5(0) 
        memBuffer[4]=32'b10001100000000110000000000000100;//lw $3,4(0) 
		  memBuffer[5]=32'b00000000010000110010100000100000;//$5=$2+$3
		  memBuffer[6]=32'b00000000101000110010100000100010;//$5=$5-$3
        memBuffer[7]=32'b00000000001000100010000000100000;//$4=$1+$2
        memBuffer[8]=32'b00000000101000110010100000100010;//$5=$5-$3
        memBuffer[9]=32'b00000000101000110010000000100100;//$4=$5 and $3
        memBuffer[10]=32'b10001100000000010000000000000101;//lw $1,1($0)
        memBuffer[11]=32'b00010000001000100000000000000001;//beq $1,S2,3
        memBuffer[12]=32'b00000000010000110010000000100000;//$4=$2+$3
        memBuffer[13]=32'b00000000010000110010000000100010;//$4=$2-$3
        memBuffer[14]=32'b00000000100000100010000000100101;//$4=$4 or $2
        memBuffer[15]=32'b00000000011001000011000000101010;//$6=$3 < $4
        end
	  end
	  always@(IMaddress or IMRESET)
	  begin
	     if (IMRESET == 0) IMreadData= memBuffer[IMaddress>>2];
		  else IMreadData=0;
	  end
	  

endmodule
