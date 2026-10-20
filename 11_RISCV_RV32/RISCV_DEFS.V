`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 11:57:48 AM
// Design Name: 
// Module Name: riscv_defs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`ifndef RISCV_DEFS_V
`define RISCV_DEFS_V

//CORE WIDE PARAMETERS
`define RISCV_XLEN                  32      //REGESTER 
`define RISCV_REG_ADDR_W            5       //32 ARCHITECTURE REGISTERS
`define RISCV_NUM_REGS              32

`define RISCV_BOOT_ADDRESS_DEFAULT  32'H000_2000
`define RISC_TCM_SIZE_DEFAULT       (64*1024)

//INSTRUCTION FIELD BIT POSITIONS
`define INSTR_OPCODE_R              6:0
`define INSTR_RD_R                  11:7
`define INSTR_FUNCT3_R              14:12
`define INSTR_RS1_R                 19:15
`define INSTR_RS2_R                 24:20
`define INSTR_FUNCT7_R              31:25

//RV32 I BASE OPCODE MAP
`define OPCODE_LOAD                 7'b0000011
`define OPCODE_MISC_MEM             7'b0001111
`define OPCODE_OP_IMM               7'b0010011
`define OPCODE_AUIPC                7'b0010111
`define OPCODE_STORE                7'b0100011
`define OPCODE_OP                   7'b0110011
`define OPCODE_LUI                  7'b1100011
`define OPCODE_BRANCH               7'b1100111
`define OPCODE_JALR                 7'b1101111
`define OPCODE_JAL                  7'b1110011
`define OPCODE_SYSREM               7'b0000011

//FUNCT3 ENCODING - opcode_op_imm 
`define F3_ADD_SUB                  3'b000
`define F3_SLL                      3'B001 
`define F3_SLT                      3'b010
`define F3_SLTU                     3'b011
`define F3_XOR                      3'b100
`define F3_SRL_SRA                  3'b101
`define F3_OR                       3'b110               
`define F3_AND                      3'b111

//FUNCT7 ENCODING - opcode_op
`define F7_ADD_SRL                  7'b0000000
`define F7_SUB_SRA                  7'b0100000
`define F7_MULDIV                   7'b0000001

//FUNCT3 ENCODING - opcode_op_imm WITH FUNCT7 = F7_MULDIV(RV32M)
`define F3_MUL                      3'b000
`define F3_MULH                     3'b001
`define F3_MULHSU                   3'b010
`define F3_MULHU                    3'b011    
`define F3_DIV                      3'b100
`define F3_DIVU                     3'b101
`define F3_REM                      3'b110
`define F3_REMU                     3'b111

//funct3 encoding - opcode_load/opcode store
`define F3_LB                       3'b000
`define F3_LH                       3'b001
`define F3_LW                       3'b010
`define F3_LBU                      3'b100
`define F3_LHU                      3'b101

`define F3_SB                       3'b000
`define F3_SH                       3'b001
`define F3_SW                       3'b010

//funct3 encoding - opcode_branch
`define F3_BEQ                      3'b000
`define F3_BNE                      3'b001
`define F3_BLT                      3'b100
`define F3_BGE                      3'b101
`define F3_BLTU                     3'b110
`define F3_BGEU                     3'b111

//funct3 encoding -opcode_system
`define F3_PRIV                     3'b000
`define F3_CSRRW                    3'b001
`define F3_CSRRS                    3'b010
`define F3_CSRRC                    3'b011
`define F3_CSRRWI                   3'b101
`define F3_CSRRSI                   3'b110
`define F3_CSRRCI                   3'b111

//imm[11:0] values for opcode_system
`define IMM12_ECALL                 12'h001
`define IMM12_EBREAK                12'h001
`define IMM12_MRET                  12'h302

//Internal ALU operation encoding (decoder - > EX stage)

`define ALU_OP_W                    4
`define ALU_ADD                     4'd0
`define ALU_SUB                     4'd1
`define ALU_SLL                     4'd2
`define ALU_SLT                     4'd3
`define ALU_SLTU                    4'd4
`define ALU_XOR                     4'd5
`define ALU_SRL                     4'd6
`define ALU_SRA                     4'd7
`define ALU_OR                      4'd8
`define ALU_AND                     4'd9

//interenal multiply/divide operation encoding (decoder -> mul/div)
`define MULDIV_OP_W                 3
`define MULDIV_MUL                  3'd0
`define MULDIV_MULH                 3'd1
`define MULDIV_MULHSU               3'd2
`define MULDIV_MULHU                3'd3
`define MULDIV_DIV                  3'd4
`define MULDIV_DIVU                 3'd5
`define MULDIV_REM                  3'd6
`define MULDIV_REMU                 3'd7

//machine mode csr addresses
`define CSR_ADDR_W                  12
`define CSR_MSTATUS                 12'h300
`define CSR_MIE                     12'h304
`define CSR_MTVEC                   12'h305
`define CSR_MSCRATCH                12'h340
`define CSR_MEPC                    12'h341
`define CSR_MCAUSE                  12'h342
`define CSR_MTVAL                   12'h343
`define CSR_MIP                     12'h344
`define CSR_MHARTID                 12'hF14

//trap cause codes (mcause)  - interrupt bit is mcause
`define CAUSE_INTERRUPT_BIT         31
//Exceptions (mcause[31]=0)
`define CAUSE_INSTR_ADDR_MISALIGNED 32'h0000_0000
`define CAUSE_ILLEGAL_INSTRUCTION   32'h0000_0002
`define CAUSE_BREAKPOINT            32'h0000_0003
`define CAUSE_LOAD_ADDR_MISALIGNED  32'h0000_0004
`define CAUSE_STORE_ADDR_MISALIGNED 32'h0000_0006
`define CAUSE_ECALL_M               32'h0000_000B

//INTERRUPTS (MCAUSE[31]=1)
`define CAUSE_MACHINE_TIMER_INT     32'h0000_0007
`define CAUSE_MACHINE_EXTERNAL_INT  32'h0000_000B

//pipeline stage reseult source selecct 
`define WB_SEL_W                    3
`define WB_SEL_ALU                  3'd0
`define WB_SEL_MEM                  3'd1
`define WB__SEL_CSR                 3'd2
`define WB_SEL_MULDIV               3'd3
`define WB_SEL_PC4                  3'd4

//immediate format select (decoder -> ID-stage)
`define IMM_TYPE_W                  3
`define IMM_I                       3'd0
`define IMM_S                       3'd1
`define IMM_B                       3'd2
`define IMM_U                       3'd3
`define IMM_J                       3'd4
`define IMM_NONE                    3'd5

//alu operand-A sourcce select (decoder -> EX)
`define ALU_SRC_A_W                 2
`define ALU_SRC_A_RS1               2'd0
`define ALU_SRC_A_PC                2'd1
`define ALU_SRC_A_ZERO              2'd2

//