`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 02:21:29 PM
// Design Name: 
// Module Name: instruction_fetch
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

//instruction fetch is basically fectching the instruction

module instruction_fetch#(parameter ADDR_WIDTH = 14)(
    
    input clk_i,
    input rst_i,
    input [31:0] boot_addr_i, 
    input stall_i,
    input flush_i,
    input redirect_i,
    input [31:0] redirect_pc_i,
    
    output [ADDR_WIDTH-1:0] imem_addr_o,        //instruction memory address
    input [31:0] imem_rdata_i,
    
    output [31:0] pc_o,
    output [31:0] instr_o
    
    );
    
    wire [31:0] live_instr;
    
    //add imm x0,x0,0
    localparam [31:0] nop_instr = 32'h0000_0013;            //no operation instruction
    
    reg [31:0] pc_q;
    reg [31:0] pc_d_q;
    reg stall_d_q;
    
    reg [31:0] instr_hold_q;    //for foldin instruction at stall time
    
    always @(posedge clk_i or posedge rst_i)begin
        if(rst_i) begin
            pc_q<=boot_addr_i;
        end
        else if(redirect_i)begin
            pc_q <= redirect_pc_i;    
        end
        else begin
            pc_q <= pc_q+4;
        end
    end
    
    
    always @(posedge clk_i or posedge rst_i)begin
        if(rst_i)begin
            stall_d_q <= 1'b0;
            instr_hold_q<=nop_instr;
        end
        else begin
            stall_d_q<=stall_i;
            instr_hold_q<=instr_o;
        end
    end
    
    always @(posedge clk_i or posedge rst_i) begin
        if(rst_i)begin
            instr_hold_q<=nop_instr;
        end
        instr_hold_q<=instr_o;
    end
    
    assign live_instr = flush_i?nop_instr:imem_rdata_i;
    
    assign instr_o = stall_i?instr_hold_q:live_instr;
    assign pc_o = pc_d_q;
    assign imem_addr_o = pc_q[ADDR_WIDTH-1:2]; 
    
endmodule
