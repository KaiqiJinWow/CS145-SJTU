`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:25 03/07/2018 
// Design Name: 
// Module Name:    alu 
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
module alu(input1,input2, aluCtr,zero,aluRes);
    input [31:0] input1;
    input [31:0] input2;
    input [3:0] aluCtr;
    output zero;
    output [31:0] aluRes;
    reg zero;
    reg [31:0] aluRes;

    always @ (input1 or input2 or aluCtr)
	 begin
	     if (aluCtr == 4'b0010)//add
		  begin
     		  aluRes = input1+input2;
			  if (aluRes==0)
				    zero =1;
				else 
				    zero=0;
		 end
		  else if(aluCtr == 4'b0110)//sub
		  begin
		      aluRes = input1 -input2;
				if (aluRes==0)
				    zero =1;
				else 
				    zero=0;
		  end
		  else if (aluCtr==4'b0000)//AND
		  begin
		       aluRes=input1&input2;
				 if (aluRes==0)
				    zero =1;
				else 
				    zero=0;
		  end
		  else if (aluCtr==4'b0001)//OR
		  begin
      		  aluRes=input1|input2;
				  if (aluRes==0)
				    zero =1;
				  else 
				    zero=0;
			end
		  else if (aluCtr==4'b1100)//NOR
		  begin
      		  aluRes=~(input1&input2);
				  if (aluRes==0)
				    zero =1;
				else 
				    zero=0;
		 end
		  else if (aluCtr==4'b0111)//set on less than
		       begin
				   if (input1<input2)
					      aluRes=1;
					else aluRes=0;
					if (aluRes==0)
				    zero =1;
				else 
				    zero=0;
				 end
		end
endmodule
