`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2025 05:35:47 PM
// Design Name: 
// Module Name: BigCalcSim
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


module BigCalcSim(

    );
    
    reg [3:0] A;
    reg [3:0] B;
    reg carryIn;
    reg [1:0] operator;
    reg clock = 0;
    reg reset = 0;
    wire [30:0] display;
    
    wire [7:0] s;
    
    DisplayMain dut (
        .digit1(A),
        .digit2(B),
        .carryIn(carryIn),
        .operator(operator),
        .clock(clock),
        .reset(reset),
        .sol(s),
        .display(display)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock;     // 100 MHz clock, 10ns period
    end

    // Reset sequence
    initial begin
        reset = 1;    // assert reset at t=0
        #10;
        reset = 0;
    end
    
    
    
    initial begin
        A = 4'b0000;
        B = 4'b0000;
        carryIn = 0;
        operator = 2'b00;
        @(negedge reset);
        #10;
        
        // ADDITION
        
        @(posedge clock);
        A=4'b0100;B=4'b0100;carryIn=0;operator=2'b00;
        
        @(posedge clock);
        A=4'b1000;B=4'b0100;carryIn=0;operator=2'b01;
        
        @(posedge clock); 
        A=4'b0010;B=4'b0011;carryIn=0;operator=2'b10;
        
        @(posedge clock);
        A=4'b0100;B=4'b0100;carryIn=0;operator=2'b10;
        
        @(posedge clock);
        A=4'b1000;B=4'b0011;carryIn=0;operator=2'b10;
        
        @(posedge clock);
        A=4'b0010;B=4'b0100;carryIn=0;operator=2'b10;
        
        @(posedge clock);
        A=4'b1001;B=4'b0011;carryIn=0;operator=2'b11;
        
        @(posedge clock);
        A=4'b0100;B=4'b0100;carryIn=0;operator=2'b11;
        
        @(posedge clock); 
        A=4'b0110;B=4'b0011;carryIn=0;operator=2'b11;
 
        #10;     
    end
   
    
endmodule
