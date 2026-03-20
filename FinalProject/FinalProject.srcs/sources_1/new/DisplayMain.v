`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2025 10:27:31 AM
// Design Name: 
// Module Name: DisplayMain
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

module DigitSplitter (
    input  [7:0] value,     // 0-15
    output reg [3:0] tens,  // 0-9
    output reg [3:0] ones   // 0-9 or 0-5
);

    always @(*) begin
        if (value < 10) begin
            tens = 0;
            ones = value;
        end else begin
            tens = value/10;
            ones = value - (tens*10);
        end
    end

endmodule


module DisplayMain(
    input [3:0] digit1,
    input [3:0] digit2,
    input carryIn,
    input [1:0] operator,
    input clock,
    input reset,
    output reg [7:0] sol,
    output reg [30:0] display
    );
    
    wire [7:0] solution;
    wire carryOut;
    
    wire [3:0] tens;
    wire [3:0] ones;
    
    wire [14:0] tensLEDDisp;
    wire [14:0] onesLEDDisp;
    
    CalculatorMain calc (
        .A(digit1),
        .B(digit2),
        .carryIn(carryIn),
        .operator(operator),
        .clock(clock),
        .reset(reset),
        .solution(solution),
        .carryOut(carryOut)
    );
    
    DigitSplitter dig (
        .value(solution),
        .tens(tens),
        .ones(ones)
    );
    
    
    DisplayCreator tensPlace (
        .bcdIn(tens),
        .signalOut(tensLEDDisp)
    );
    
    DisplayCreator onesPlace (
        .bcdIn(ones),
        .signalOut(onesLEDDisp)
    );
    
    always @(*) begin
        display = {tensLEDDisp, onesLEDDisp};
        sol = solution;
    end
    
    
    
endmodule
