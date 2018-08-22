`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:14:09 03/07/2018
// Design Name:   alu
// Module Name:   E:/516030910382_jinkaiqi/alu/test_for_alu.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr), 
		.zero(zero), 
		.aluRes(aluRes)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;

		// Wait 100 ns for global reset to finish
		#100;
      #100
		begin
		input1=0;
		input2=0;
		aluCtr=0;
		end
      #100
		begin
		input1=255;
		input2=170;
		aluCtr=0;
		end      
		#100
		begin
		input1=255;
		input2=170;
		aluCtr=1;
		end      
		#100
		begin
		input1=1;
		input2=1;
		aluCtr=2;
		end      
		#100
		begin
		input1=255;
		input2=170;
		aluCtr=6;
		end
		#100
		begin
		input1=1;
		input2=1;
		aluCtr=6;
		end
		#100
		begin
		input1=250;
		input2=170;
		aluCtr=7;
		end
		#100
		begin
		input1=32'b10000000000000000000000000000001;
		input2=32'b10000000000000000000000000000010;
		aluCtr=12;
		end   
      #100
		begin
		input1=170;
		input2=255;
		aluCtr=7;
		end

		// Add stimulus here

	end
      
endmodule

