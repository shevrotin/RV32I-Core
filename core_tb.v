`timescale 1ns / 1ps

module core_tb();

    reg clk_tb, rst_tb;

    core dut
    (
    .clk(clk_tb), .rst(rst_tb)
    );
    
    initial 
        begin
        clk_tb <= 0;
        rst_tb <= 0;
        #20
        rst_tb <= 1;
        #20
        rst_tb <= 0;
        end
    
    always #10 clk_tb <= !clk_tb;
   
endmodule
