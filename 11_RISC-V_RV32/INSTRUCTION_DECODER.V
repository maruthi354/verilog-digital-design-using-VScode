`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 04:25:43 PM
// Design Name: 
// Module Name: instruction_decoder
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

//`include "riscv_defs.v"
module instruction_decoder(

    input [31:0] instr_i,
    
    //outputs related to register address fields
    output [4:0] rd_addr_o,
    output [4:0] rs1_addr_o,
    output [4:0] rs2_addr_o,
    output reg [2:0] imm_type_o,
    
    //alu control signals
    output reg [3:0] alu_op_o,
    output reg [1:0] alu_src_a_sel_o,
    output reg alu_srcb_imm_o, //0-rs2, 1-immediate
    
    //signals related to memory control
    output reg mem_read_o,
    output reg mem_write_o,
    
    //signals related to control flow signals
    output reg branch_o,
    output reg jump_o,
    output reg jalr_o,
    
    //writeback control signals
    output reg reg_write_o,
    output reg [2:0] wb_sel_o,
    
    //rv 32m instruction
    output reg muldiv_en_o,
    output reg [2:0] mul_div_op_o,
    
    //csr_en_o,
    output reg csr_en_o,
    output reg system_o,
    output reg illegal_o
    );
    
    wire [6:0] opcode = instr_i[6:0];
    wire [2:0] funct3 = instr_i[14:12];
    wire [6:0] funct7 = instr_i[31:25];
    
    assign rd_addr_o = instr_i[11:7];
    assign rs1_addr_o = instr_i[19:15];
    assign rs2_addr_o = instr_i[24:20];
    
    always @(*) begin
        imm_type_o = 3'd5;  //IMM_NONE
        alu_op_o = 4'd0;    //ALU_ADD
        alu_src_a_sel_o = 2'd0;  //ALU_SRC_A_RS1
        alu_srcb_imm_o = 1'b0;
        mem_read_o = 1'b0;
        mem_write_o = 1'b0;
        branch_o = 1'b0;
        jump_o = 1'b0;
        reg_write_o = 1'b0;
        wb_sel_o = 3'd0;    //WB_SEL_ALU  
        muldiv_en_o = 1'b0;
        mul_div_op_o = 1'b0;
        csr_en_o = 1'b0;
        system_o = 1'b0;
        
        case (opcode)
            //opcode corresponding to immediate instructions like addi/slti/sltui
            7'b0010011:begin                    //I-TYPE IMM_I  ADDI/SLTI/../SRAI
                imm_type_o = 3'd0;              //IMM_I    OP-IMM, LOAD, JALR
                alu_srcb_imm_o = 1'b1;
                reg_write_o = 1'b1;
                wb_sel_o = `WB_SEL_ALU;    //WB_SEL_ALU
                
                case(funct3)
                    3'b000:alu_op_o = 4'd0;     
                    3'b001:alu_op_o = 4'd2;
                    3'b010:alu_op_o = 4'd3;
                    3'b011:alu_op_o = 4'd4;
                    3'b100:alu_op_o = 4'd5;
                    3'b101:alu_op_o = (funct7 == 7'b0100000)?4'd7:4'd6;
                    3'b110:alu_op_o = 4'd8;
                    3'b111:alu_op_o = 4'd9;
                endcase
            end
            7'b0110011:begin
                reg_write_o = 1'b1;
                if(funct7==`F7_MULDIV)begin             //F7_MULDIV
                    muldiv_en_o=1'b1;
                    wb_sel_o = ;
                    case(funct3) 
                        `F3_MUL:mul_div_op_o = 4'd0;     //signed mul  
                        `F3_MULH:mul_div_op_o = 4'd1;     //signed mul for upper 32
                        `F3_MULHSU:mul_div_op_o = 4'd2;     
                        `F3_MULHU:mul_div_op_o = 4'd3;
                        `F3_DIV:mul_div_op_o = 4'd4;
                        `F3_DIVU:mul_div_op_o = 4'd5;
                        `F3_REM:mul_div_op_o = 4'd6;
                        `F3_REMU:mul_div_op_o = 4'd7;
                        default:illegal_o = 1'b1;
                    endcase
                end
            end
        endcase
        
        
        
    end
    
endmodule
