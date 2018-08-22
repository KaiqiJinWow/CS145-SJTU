`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:48:44 03/07/2018 
// Design Name: 
// Module Name:    AluCtr 
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
module AluCtr(aluOp, funct, aluCtr);
    input [1:0] aluOp;
    input [5:0] funct;
    output [3:0] aluCtr;
    
	 reg [3:0] aluCtr;
	 
	 always @ (aluOp or funct)
	 casex ({aluOp, funct})
	     8'b00XXXXXX: aluCtr = 4'b0010;
        8'bX1XXXXXX: aluCtr = 4'b0110;
		  8'b1XXX0000: aluCtr = 4'b0010;
		  8'b1XXX0010: aluCtr = 4'b0110;
		  8'b1XXX0100: aluCtr = 4'b0000;
		  8'b1XXX0101: aluCtr = 4'b0001;
		  8'b1XXX1010: aluCtr = 4'b0111;
	 endcase

endmodule
