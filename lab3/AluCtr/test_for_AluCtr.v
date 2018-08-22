`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:02:50 03/07/2018
// Design Name:   AluCtr
// Module Name:   E:/516030910382_jinkaiqi/AluCtr/test_for_AluCtr.v
// Project Name:  AluCtr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AluCtr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_AluCtr;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	AluCtr uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		#100 funct=6'bxxxxxx;
      #100 aluOp=2'b01;
		
		// Add stimulus here		
      #100 aluOp=2'b10;funct=6'bxx0000;
		#100 funct=6'bxx0010;
		#100 funct=6'bxx0100;
		#100 funct=6'bxx0101;
		#100 funct=6'bxx1010;
	end
      
endmodule

