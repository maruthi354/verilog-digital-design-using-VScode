`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2026 10:13:54 PM
// Design Name: 
// Module Name: UART_Tb
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


module UART_TB;

    reg clk;
    reg reset;
    reg wr_enb;
    reg rdy_clr;
    reg [7:0] data_in;
    
    wire [7:0] data_out;
    wire busy;
    wire ready;
    
    UART dut(clk,reset,wr_enb,rdy_clr,data_in,ready,busy,data_out);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 0;
        wr_enb = 0;
        rdy_clr = 0;
        data_in = 0;
    end
    
    initial begin
        @(negedge clk);
        reset = 1'b1;
        
        @(negedge clk);
        reset = 1'b0;
        
        send_data(8'h43);
        wait(!busy);
        wait(ready);
        
        clear_ready;
        
        send_data(8'h84);
        wait(!busy);
        wait(ready);
        
        #10000 $finish;
        
    end
    
    task send_data(input [7:0] din);
        begin
            @(negedge clk);
            data_in = din;
            wr_enb=1'b1;
            @(negedge clk);
            wr_enb = 1'b0;
        end
    endtask
    
    task clear_ready;
        begin
            @(negedge clk);
            rdy_clr = 1'b1;
            @(negedge clk);
            rdy_clr = 1'b0;
        end
    endtask  
        

endmodule

class driver;
    uart_txn txnh;  //transaction class handle
    virtual uart_if.DRIVER vif;
    mailbox #(uart_txn) gen2drv;
    mailbox #(uart_txn) drv2sb;
    mailbox #(uart_txn) drv2rm;
    
    function new(mailbox#(uart_tnx)gen2drv,mailbo #(uart_tnx) drv2sb,mailbox#(uart_tnx) drv2rm);
        this.gen2drv = gen2drv;
        this.drv2sb = drv2sb;
        this.drv2rm = drv2rm;

    endfunction

    task reset_phase();
        vif.drv_cb.rst<=1'b1;
        vif.drv_cb.wr_enb<=1'b0;
        vif.drv_cb.ready_clr<=1'b0;
        
        repeat(5) @(posedge vif.clk);
        vif.drv_cb.rst<=1'b0;
    endtask

    task run();

    reset_phase();
    forever 
         begin
            gen2drv.get(txn);
            send(txn);
            send(txn);
            drv2sb.put(txn);
            drv2rm.put(txn);
         end
    endtask

task send();
    @(posedge vif.clk);
    vif.drv_cb.data_in<=txn.data;
    vif.drv_cb.wr_en<=1'b1;
    @(posedge vif.clk);
    vif.drv_cb.wr_en<=1'b0;

    wait(!vif.drv_cb.busy);
    wait(vif.drv_cb.ready);

    txn.display("DRIVER:DATA SENT");

    vif.drv_cb.rdy_clr=1'b1;

endtask

endclass