`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2026 10:34:37 AM
// Design Name: 
// Module Name: SPI_Slave_Tb
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


module SPI_Slave_Tb;

    logic clk;
    logic rst_n;
    
    logic sclk;
    logic cs;
    logic miso;
    logic mosi;
    
    //          DUT
    
    SPI_Slave dut(
        .clk(clk),
        .rst_n(rst_n),
        .sclk(sclk),
        .cs(cs),
        .miso(miso),
        .mosi(mosi)
    );
    
    //          FPGA CLK
    
    initial begin
        clk=1'b0;
        
        forever #5 clk = ~clk;
        
    end
    
    //          spi_initialization
    
    initial begin
        sclk = 1'b0;
        cs = 1'b1;
        mosi = 1'b1;
    end
    
    //          Task to transmit 1Byte
    
    task spi_write_byte (input logic [7:0] data) ;
        integer i;
        begin
            for(i=7; i>=0 ; i=i-1) begin
                mosi = data[i];
                
                #5
                sclk = 1'b1;
                #5
                sclk = 1'b0;
                
            end
        end
    endtask
    
    //          Task to transmist address and data
    
    task spi_write_reg(input logic [7:0] address,input logic [31:0] data);
        begin
            $display("__________________________");
            $display("\t SPI Write ");
            $display("address = %h",address);
            $display("data = %h",data);
            
            cs = 1'b0;
            
            //      CMD Wrtie
            spi_write_byte(8'h01);
            
            //      write byte address
            spi_write_byte(address);
            
            //      write data
            spi_write_byte(data[31:24]);
            spi_write_byte(data[23:16]);
            spi_write_byte(data[15:8]);
            spi_write_byte(data[7:0]);
            
            #10;
            cs=1'b1;
            
            mosi=1'b0;
            
            #10;
            
        end
    endtask
    
    //          Main Test Bench
    
    initial begin
        $display("______________________");
        $display("SPI SLAVE TEST BENCH");
        $display("______________________");
        
        rst_n=1'b1; #20;
        rst_n=1'b0; #20;
    
        $display(" TEST WRITE ");
        
        spi_write_reg(8'h08,32'h1234_5678);
        
        if (dut.config_reg == 32'h1234_5678) begin

            $display("PASS: CONFIG register written correctly.");

        end

        else begin

            $display("FAIL: CONFIG register incorrect.");
            $display("Expected = 12345678");
            $display("Actual   = %h", dut.config_reg);
            $display("Actual   = %h", dut.control_reg);
            $display("Actual   = %h", dut.counter_reg);
            $display("Actual   = %h", dut.status_reg);
            $display("Actual   = %h", dut.error_count_reg);

        end


        #100;

        $display("_____________________");
        $display(" TEST COMPLETE");
        $display("_____________________");

        $finish;
        
    
    end

endmodule
