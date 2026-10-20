`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2026 10:44:44 PM
// Design Name: 
// Module Name: tcm_ram
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

//64kb RAM

module tcm_ram #(parameter ADDR_WIDTH = 14)(
    //PORT-A
    input clk_i,
    input rst_i,
    input [ADDR_WIDTH-1:0] addr_a_i,
    input [31:0] wdata_a_i,
    input [3:0] wstrb_a_i,
    output reg [31:0] rdata_a_o,
    
    //PORT-B
    //LSU/DATA0
    input [ADDR_WIDTH-1:0] addr_b_i,
    input [31:0] wdata_b_i,
    input [3:0] wstrb_b_i,
    output reg [31:0] rdata_b_o
    
    );
    
    localparam DEPTH = ( 1 << ADDR_WIDTH);
    reg [31:0] mem[0:DEPTH-1];
    
    integer i;
    
    always @(posedge clk_i)begin
        if(rst_i)begin
            for(i=0;i<DEPTH;i=i+1)
                mem[i]<=32'd0000_0000;
        end        
    end
    
    //Logic for port A
    //this port is written using AXI
    
    always @(posedge clk_i) begin
        if(wstrb_a_i[0])
            mem[addr_a_i][7:0] <= wdata_a_i;
        if(wstrb_a_i[1])
            mem[addr_a_i][15:8] <= wdata_a_i;
        if(wstrb_a_i[2])
            mem[addr_a_i][23:16] <= wdata_a_i;
        if(wstrb_a_i[3])
            mem[addr_a_i][31:24] <= wdata_a_i;
        
        rdata_a_o <= mem[addr_a_i];    
    end
    
    //PORT B
    
    always @(posedge clk_i) begin
        if(wstrb_b_i[0])
            mem[addr_b_i][7:0] <= wdata_b_i;
        if(wstrb_b_i[1])
            mem[addr_b_i][15:8] <= wdata_b_i;
        if(wstrb_b_i[2])
            mem[addr_b_i][23:16] <= wdata_b_i;
        if(wstrb_b_i[3])
            mem[addr_b_i][31:24] <= wdata_b_i;
        
        rdata_b_o <= mem[addr_b_i];  
    end
    
endmodule
