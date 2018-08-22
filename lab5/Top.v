`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:44:01 03/21/2018 
// Design Name: 
// Module Name:    Top 
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
module Top(clk,reset,switches,LED);
   input clk;
   input reset;
   input [2:0] switches; 
   reg [31:0] PC;
	reg [31:0] INST;
	reg [7:0] Instmemory [51:0];
	output reg [7:0] LED;

initial
begin
   /*Instmemory[0]=8'b00000000;
	Instmemory[1]=8'b00000000;
   Instmemory[2]=8'b00000000;
   Instmemory[3]=8'b00000000;
   
	Instmemory[4]=8'b10001100;//lw
   Instmemory[5]=8'b00000001;
   Instmemory[6]=8'b00000000;
   Instmemory[7]=8'b00000001;
   Instmemory[8]=8'b10001100;//lw
   Instmemory[9]=8'b00000010;
   Instmemory[10]=8'b00000000;
   Instmemory[11]=8'b00000010;
   Instmemory[12]=8'b00000000;//r
   Instmemory[13]=8'b00100010;
   Instmemory[14]=8'b00011000;
   Instmemory[15]=8'b00100000;
   Instmemory[16]=8'b00000000;//sub
   Instmemory[17]=8'b00100010;
   Instmemory[18]=8'b00100000;
   Instmemory[19]=8'b00100010;
	Instmemory[20]=8'b10001100;//lw
   Instmemory[21]=8'b01100001;
   Instmemory[22]=8'b00000000;
   Instmemory[23]=8'b00000010;
	Instmemory[24]=8'b00000000;//r
   Instmemory[25]=8'b00100010;
   Instmemory[26]=8'b00100000;
   Instmemory[27]=8'b00100010;
	Instmemory[28]=8'b00000000;//or
   Instmemory[29]=8'b00100010;
   Instmemory[30]=8'b00100000;
	Instmemory[31]=8'b00100101;
	Instmemory[32]=8'b00000000;//xor
   Instmemory[33]=8'b00100010;
   Instmemory[34]=8'b00100000;
   Instmemory[35]=8'b00100110;
	Instmemory[36]=8'b00000000;//slt
   Instmemory[37]=8'b01000001;
   Instmemory[38]=8'b00100000;
   Instmemory[39]=8'b00101010;
	Instmemory[40]=8'b00000000;//and
   Instmemory[41]=8'b00100010;
   Instmemory[42]=8'b00100000;
   Instmemory[43]=8'b00100100;
   Instmemory[44]=8'b00001000;//j
   Instmemory[45]=8'b00000000;
   Instmemory[46]=8'b00000000;
   Instmemory[47]=8'b00000001;
   Instmemory[48]=8'b00000000;
   Instmemory[49]=8'b00000000;
   Instmemory[50]=8'b00000000;
   Instmemory[51]=8'b00000000;*/
   $readmemb("inst.in",Instmemory,8'b0);
	PC=0;
end

wire [31:0] nextPC;
wire [31:0]DATA;
wire ZERO;
wire BRANCH;
wire JUMP;
//wire clk;//
wire [31:0] DISP;
always@(posedge clk)
begin
	PC=(reset)?0:nextPC;
	if(reset) PC=0;
end


always@(PC)
   INST={Instmemory[PC],Instmemory[PC+1],Instmemory[PC+2],Instmemory[PC+3]};

	wire [31:0] pcPlus4;
	wire [31:0] instshift;
	wire [31:0]JumpAddr;
	wire [31:0] addshift;
	wire AND;
	wire [31:0] ADDRES;
	wire [31:0] MUXOUT;
	wire REG_DST;
	wire MEM_READ;
	wire MEM_TO_REG;
	wire [1:0] ALUOP;
	wire MEM_WRITE;
	wire ALUSRC;
	wire REG_WRITE;
	wire[4:0]WRITEREG;
	wire[31:0]WRITEDATA;
	wire[31:0]READDATA1;
	wire[31:0]READDATA2;
	wire[3:0] ALUCTR;
	wire [31:0] INPUT2;
	wire [31:0] ALURES;
	wire [31:0] READDATA;
  
   assign pcPlus4=PC+4;
	//assign a_to_g[3:0]=pcPlus4[5:2];
	//assign a_to_g[7:4]=WRITEREG[3:0];
	assign instshift=INST[25:0]<<2;
	assign JumpAddr={pcPlus4[31:28],instshift[27:0]};
	assign addshift=DATA<<2;
	assign AND=(ZERO & BRANCH);
	assign ADDRES=pcPlus4+addshift;
	assign MUXOUT=AND?ADDRES:pcPlus4;
	assign nextPC=JUMP?JumpAddr:MUXOUT;
	assign WRITEREG=REG_DST?INST[15:11]:INST[20:16];
	assign INPUT2=ALUSRC?DATA:READDATA2;
	assign WRITEDATA=MEM_TO_REG?READDATA:ALURES;
//Ctr

	//Ctr(opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,
   //        branch,aluOp,jump);	
	//timeDivider td(.clockIn(clock), .clockOut(clk));
	Ctr mainCtr(.opCode(INST[31:26]),
	            .regDst(REG_DST),
					.aluSrc(ALUSRC),
					.memToReg(MEM_TO_REG),
					.regWrite(REG_WRITE),
					.memRead(MEM_READ),
					.memWrite(MEM_WRITE),
					.branch(BRANCH),
					.aluOp(ALUOP),
					.jump(JUMP));

//register

	
	assign WRITEREG=REG_DST?INST[15:11]:INST[20:16];
	//module register( clock_in, readReg1, readReg2, 
	//writeReg, regWrite, writeData, readData1, readData2);
	register mainregister(.clock_in(clk),
	                      .readReg1(INST[25:21]),
								 .readReg2(INST[20:16]),
								 .writeReg(WRITEREG),
								 .writeData(WRITEDATA),
								 .regWrite(REG_WRITE),
								 .readData1(READDATA1),
								 .readData2(READDATA2),
								 .rst(reset),
								 .showAddress(switches),
								 .display(DISP));

//signext
//module signext(inst,data);

   signext mainsignext(.inst(INST[15:0]),
                       .data(DATA));

//ALUCTR
//module AluCtr(aluOp, funct, aluCtr);							  
   
	AluCtr mainAluCtr(.aluOp(ALUOP),
	                  .funct(INST[5:0]),
							.aluCtr(ALUCTR));

//ALU
//module alu(input1,input2, aluCtr,zero,aluRes);

	 
	 assign INPUT2=ALUSRC?DATA:READDATA2;
	 
	 alu mainAlu(.input1(READDATA1),
					 .input2(INPUT2),
					 .aluCtr(ALUCTR),
					 .zero(ZERO),
					 .aluRes(ALURES));

//memory
//module date_memory(clock_in,address,writeData,memWrite,memRead,readData);					 

	
	date_memory maindate_memory(.clock_in(clk),
	                            .address(ALURES),
										 .writeData(READDATA2),
										 .memWrite(MEM_WRITE),
										 .memRead(MEM_READ),
										 .readData(READDATA));
	 always @ (posedge clk)
	 begin
	     if (!reset)
		  begin
		      LED = 8'b00000000;
		  end
		  else begin
		      LED = DISP[7:0];
		  end
	 end
endmodule
