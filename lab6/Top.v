`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:36 03/30/2018 
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
module Top(CLOCK_IN, RESET, SWITCH, LED);
    input CLOCK_IN;
	 input RESET;
	 input [3:0] SWITCH;
	 output [3:0] LED;
    
	 reg [31:0] PC;
//IF->ID
     //wire
	   wire [31:0] IF_AddPlus4;
		wire [31:0] IF_Instruction;
		wire [31:0] NextPC;
		//reg
		reg [31:0] IF_ID_AddPlus4;
		reg [31:0] IF_ID_Instruction;
		
//ID->EX
     //wire
	   wire ID_RegDst;
		wire ID_AluSrc;
		wire ID_MemToReg;
		wire ID_RegWrite;
		wire ID_MemRead;
		wire ID_MemWrite;
		wire ID_Branch;
		wire [1:0] ID_AluOp;
		wire [31:0] ID_ReadData1;
		wire [31:0] ID_ReadData2;
		wire [31:0] ID_Signext;
	  //reg
	   reg ID_EX_RegDst;
	   reg ID_EX_AluSrc;
	   reg ID_EX_MemToReg;
	   reg ID_EX_RegWrite;
	   reg ID_EX_MemRead;
	   reg ID_EX_MemWrite;
	   reg ID_EX_Branch;
	   reg [1:0] ID_EX_AluOp;
	   reg [31:0] ID_EX_AddPlus4;
	   reg [31:0] ID_EX_ReadData1;
	   reg [31:0] ID_EX_ReadData2;
	   reg [31:0] ID_EX_Signext;
		reg [25:21] ID_EX_Inst25_21;
	   reg [20:16] ID_EX_Inst20_16;
	   reg [15:11] ID_EX_Inst15_11;

		
//EX->MEM
     //wire
	   wire [31:0] EX_AddRes;
		wire [31:0] Mux_IDEX_TO_ALU;
		wire [5:0] EX_WriteReg;
		wire EX_Zero;
		wire [31:0] EX_AluRes;
		wire [3:0] EX_AluCtr;
	  //reg
	   reg EX_MEM_MemToReg;
	   reg EX_MEM_RegWrite;
	   reg EX_MEM_MemRead;
	   reg EX_MEM_MemWrite;
	   reg EX_MEM_Branch;
	   reg [31:0] EX_MEM_AddRes;
	   reg EX_MEM_Zero;
	   reg [31:0] EX_MEM_AluRes;
	   reg [31:0] EX_MEM_ReadData2;
	   reg [4:0] EX_MEM_WriteReg;
		
//MEM->WB
     //wire
	   wire [31:0] MEM_ReadData;
	   wire MEM_PCSrc;
	  //reg 
	   reg [31:0] MEM_WB_ReadData;
	   reg [31:0] MEM_WB_AluRes;
	   reg [4:0] MEM_WB_WriteReg;
	   reg MEM_WB_MemToReg;
	   reg MEM_WB_RegWrite;
//After WB
      wire [31:0] WB_WriteData;
      
     	assign IF_AddPlus4 = PC + 4;
      assign NextPC = MEM_PCSrc?EX_MEM_AddRes:IF_AddPlus4;

      assign EX_AddRes = ID_EX_AddPlus4 + (ID_EX_Signext << 2);
      assign Mux_IDEX_TO_ALU =ID_EX_AluSrc?ID_EX_Signext:ID_EX_ReadData2;
		assign EX_WriteReg =ID_EX_RegDst?ID_EX_Inst15_11:ID_EX_Inst20_16;
		
		assign MEM_PCSrc = EX_MEM_Branch & EX_MEM_Zero;
		
		assign WB_WriteData = MEM_WB_MemToReg?MEM_WB_ReadData:MEM_WB_AluRes;

	 initial 
	 begin
	   PC <= 0;
		IF_ID_AddPlus4 <= 0;
	   IF_ID_Instruction <= 0;
		ID_EX_RegDst <= 0;
	   ID_EX_AluSrc <= 0;
	   ID_EX_MemToReg <= 0;
	   ID_EX_RegWrite <= 0;
	   ID_EX_MemRead <= 0;
	   ID_EX_MemWrite <= 0;
	   ID_EX_Branch <= 0;
	   ID_EX_AluOp <= 0;
	   ID_EX_AddPlus4 <= 0;
	   ID_EX_ReadData1 <= 0;
	   ID_EX_ReadData2 <= 0;
	   ID_EX_Signext <= 0;
	   ID_EX_Inst20_16 <= 0;
	   ID_EX_Inst15_11 <= 0;
		EX_MEM_MemToReg <= 0;
	   EX_MEM_RegWrite <= 0;
	   EX_MEM_MemRead <= 0;
	   EX_MEM_MemWrite <= 0;
	   EX_MEM_Branch <= 0;
	   EX_MEM_AddRes <= 0;
	   EX_MEM_Zero <= 0;
	   EX_MEM_AluRes <= 0;
	   EX_MEM_ReadData2 <= 0;
	   EX_MEM_WriteReg <= 0;
      MEM_WB_ReadData <= 0;
	   MEM_WB_AluRes <= 0;
	   MEM_WB_WriteReg <= 0;
	   MEM_WB_MemToReg <= 0;
	   MEM_WB_RegWrite <= 0;
	 end
	 
		//PC
	 InstructionMemory mainInstMem(
	   .IMaddress(PC),
	   .IMCLK(CLOCK_IN),
	   .IMRESET(RESET),
	   .IMreadData(IF_Instruction));
//clock_in, readReg1, readReg2, writeReg, regWrite, 
//writeData, readData1, readData2		
		register mainRegsiter(
		  .clock_in(CLOCK_IN),
		  .readReg1(IF_ID_Instruction[25:21]),
		  .readReg2(IF_ID_Instruction[20:16]),
		  .writeReg(MEM_WB_WriteReg),
		  .writeData(WB_WriteData),
		  .regWrite(MEM_WB_RegWrite),
	     .readData1(ID_ReadData1),
	     .readData2(ID_ReadData2),
		  .rst(RESET)
		  );
		  
		 signext mainSignext(
	        .inst(IF_ID_Instruction[15:0]),
	        .data(ID_Signext)
        );

       Ctr mainCtr(
	       .opCode(IF_ID_Instruction[31:26]),
	       .regDst(ID_RegDst),
	       .aluSrc(ID_AluSrc),
	       .memToReg(ID_MemToReg),
	       .regWrite(ID_RegWrite),
	       .memRead(ID_MemRead),
	       .memWrite(ID_MemWrite),
	       .branch(ID_Branch),
	       .aluOp(ID_AluOp)
	    );

//EX
  
       AluCtr mainAluCtr(
         .aluOp(ID_EX_AluOp),
         .funct(ID_EX_Signext[5:0]),
         .aluCtr(EX_AluCtr)
        ); 
  
       alu mainAlu(
          .input1(ID_EX_ReadData1),
	       .input2(Mux_IDEX_TO_ALU),
	       .aluCtr(EX_AluCtr),
	       .zero(EX_Zero),
	       .aluRes(EX_AluRes)
       );
  
//MEM


        date_memory mainMemory(
          .clock_in(CLOCK_IN),
          .address(EX_MEM_AluRes),
          .writeData(EX_MEM_ReadData2),
          .memWrite(EX_MEM_MemWrite),
          .memRead(EX_MEM_MemRead),
          .readData(MEM_ReadData)
        ); 

always @(posedge CLOCK_IN)
begin

   if (RESET == 1) 
	    begin
		  PC <= 0;
		  IF_ID_AddPlus4 <= 0;
	     IF_ID_Instruction <= 0;
		  ID_EX_RegDst <= 0;
	     ID_EX_AluSrc <= 0;
	     ID_EX_MemToReg <= 0;
	     ID_EX_RegWrite <= 0;
	     ID_EX_MemRead <= 0;
	     ID_EX_MemWrite <= 0;
	     ID_EX_Branch <= 0;
	     ID_EX_AluOp <= 0;
	     ID_EX_ReadData1 <= 0;
	     ID_EX_ReadData2 <= 0;
	     ID_EX_Signext <= 0;
		  ID_EX_Inst25_21 <= 0;
	     ID_EX_Inst20_16 <= 0;
	     ID_EX_Inst15_11 <= 0;
		  EX_MEM_MemToReg <= 0;
	     EX_MEM_RegWrite <= 0;
	     EX_MEM_MemRead <= 0;
	     EX_MEM_MemWrite <= 0;
	     EX_MEM_Branch <= 0;
	     EX_MEM_AddRes <= 0;
	     EX_MEM_Zero <= 0;
	     EX_MEM_AluRes <= 0;
	     EX_MEM_ReadData2 <= 0;
	     EX_MEM_WriteReg <= 0;
        MEM_WB_ReadData <= 0;
	     MEM_WB_AluRes <= 0;
	     MEM_WB_WriteReg <= 0;
	     MEM_WB_MemToReg <= 0;
	     MEM_WB_RegWrite <= 0;
		 end
	else if (MEM_PCSrc)
		begin
			PC <= NextPC;	
			
			MEM_WB_MemToReg <= EX_MEM_MemToReg;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_ReadData <= MEM_ReadData;
			MEM_WB_AluRes <= EX_MEM_AluRes;
			MEM_WB_WriteReg <= EX_MEM_WriteReg;
			
			IF_ID_AddPlus4 <= 0;
	      IF_ID_Instruction <= 0;
		   ID_EX_RegDst <= 0;
	      ID_EX_AluSrc <= 0;
	      ID_EX_MemToReg <= 0;
	      ID_EX_RegWrite <= 0;
	      ID_EX_MemRead <= 0;
	      ID_EX_MemWrite <= 0;
	      ID_EX_Branch <= 0;
	      ID_EX_AluOp <= 0;
	      ID_EX_ReadData1 <= 0;
	      ID_EX_ReadData2 <= 0;
	      ID_EX_Signext <= 0;
		   ID_EX_Inst25_21 <= 0;
	      ID_EX_Inst20_16 <= 0;
	      ID_EX_Inst15_11 <= 0;
		   EX_MEM_MemToReg <= 0;
	      EX_MEM_RegWrite <= 0;
	      EX_MEM_MemRead <= 0;
	      EX_MEM_MemWrite <= 0;
	      EX_MEM_Branch <= 0;
	      EX_MEM_AddRes <= 0;
	      EX_MEM_Zero <= 0;
	      EX_MEM_AluRes <= 0;
	      EX_MEM_ReadData2 <= 0;
	      EX_MEM_WriteReg <= 0;
		end
	else if ((((IF_ID_Instruction[25:21]==EX_MEM_WriteReg)||(IF_ID_Instruction[20:16]==EX_MEM_WriteReg))&&(EX_MEM_RegWrite==1))||(((IF_ID_Instruction[25:21]==MEM_WB_WriteReg)||(IF_ID_Instruction[20:16]==MEM_WB_WriteReg))&&(MEM_WB_RegWrite==1))||(((IF_ID_Instruction[25:21]==EX_WriteReg)||(IF_ID_Instruction[20:16]==EX_WriteReg))&&(ID_EX_RegWrite==1)))
	begin
			MEM_WB_MemToReg <= EX_MEM_MemToReg;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_ReadData <= MEM_ReadData;
			MEM_WB_AluRes <= EX_MEM_AluRes;
			MEM_WB_WriteReg <= EX_MEM_WriteReg;
			
			EX_MEM_MemToReg <= ID_EX_MemToReg;
			EX_MEM_RegWrite <= ID_EX_RegWrite;
			EX_MEM_MemRead <= ID_EX_MemRead;
			EX_MEM_MemWrite <= ID_EX_MemWrite;
			EX_MEM_Branch <= ID_EX_Branch;
			EX_MEM_AddRes <= EX_AddRes;
			EX_MEM_Zero <= EX_Zero;
			EX_MEM_AluRes <= EX_AluRes;
			EX_MEM_ReadData2 <= ID_EX_ReadData2;
			EX_MEM_WriteReg <= EX_WriteReg;
			
         ID_EX_RegDst <= 0;
			ID_EX_AluSrc <= 0;
			ID_EX_MemToReg <= 0;
			ID_EX_RegWrite <= 0;
			ID_EX_MemRead <= 0;
			ID_EX_MemWrite <= 0;
			ID_EX_Branch <= 0;
			ID_EX_AluOp <= 0;
			ID_EX_ReadData1 <= 0;
			ID_EX_ReadData2 <= 0;
			ID_EX_Signext <= 0;
			ID_EX_Inst25_21 <= 0;
			ID_EX_Inst20_16 <= 0;
			ID_EX_Inst15_11 <= 0;
	end

   else	
	begin
	 
	 PC <= NextPC;
  //IF_ID
   IF_ID_AddPlus4 <= IF_AddPlus4;
	IF_ID_Instruction <= IF_Instruction;
	
  //ID_EX	
	 ID_EX_RegDst <= ID_RegDst;
	 ID_EX_AluSrc <= ID_AluSrc;
	 ID_EX_MemToReg <= ID_MemToReg;
	 ID_EX_RegWrite <= ID_RegWrite;
	 ID_EX_MemRead <= ID_MemRead;
	 ID_EX_MemWrite <= ID_MemWrite;
	 ID_EX_Branch <= ID_Branch;
	 ID_EX_AluOp <= ID_AluOp;
	 ID_EX_AddPlus4 = IF_ID_AddPlus4;
	 ID_EX_ReadData1 <= ID_ReadData1;
	 ID_EX_ReadData2 <= ID_ReadData2;
	 ID_EX_Signext <= ID_Signext;
	 ID_EX_Inst25_21 <= IF_ID_Instruction[25:21];
	 ID_EX_Inst20_16 <= IF_ID_Instruction[20:16];
	 ID_EX_Inst15_11 <= IF_ID_Instruction[15:11];
	 
  //EX_MEM
    EX_MEM_MemToReg <= ID_EX_MemToReg;
	 EX_MEM_RegWrite <= ID_EX_RegWrite;
	 EX_MEM_MemRead <= ID_EX_MemRead;
	 EX_MEM_MemWrite <= ID_EX_MemWrite;
	 EX_MEM_Branch <= ID_EX_Branch;
	 EX_MEM_AddRes <= EX_AddRes;
	 EX_MEM_Zero <= EX_Zero;
	 EX_MEM_AluRes <= EX_AluRes;
	 EX_MEM_ReadData2 <= ID_EX_ReadData2;
	 EX_MEM_WriteReg <= EX_WriteReg;

 //MEM_WB
    MEM_WB_MemToReg <= EX_MEM_MemToReg;
	 MEM_WB_RegWrite <= EX_MEM_RegWrite;
	 MEM_WB_ReadData <= MEM_ReadData;
	 MEM_WB_AluRes <= EX_MEM_AluRes;
	 MEM_WB_WriteReg <= EX_MEM_WriteReg;
   end
	 
end		  
endmodule
