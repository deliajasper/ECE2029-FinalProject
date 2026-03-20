`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2025 04:56:42 PM
// Design Name: 
// Module Name: CalculatorMain
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


module CalculatorMain(
    input [3:0] A,
    input [3:0] B,
    input carryIn,
    input [1:0] operator,
    input clock,
    input reset,
    output reg [7:0] solution,
    output reg carryOut
    );
    
    wire [3:0] sum, diff, quot;
    wire [7:0] prod;

    wire addCarry, subCarry, multCarry, divCarry;

    reg [1:0] state, next_state;
    
    parameter addition = 2'b00,
              subtraction = 2'b01,
              multiplication = 2'b10,
              division = 2'b11;
    
    // STEP 1: Perform calculation
        
    AdderModule additionOperator (
        .A(A), 
        .B(B), 
        .carryIn(0), 
        .sum(sum), 
        .carryOut(addCarry)
    );
    
    AdderModule subtractionOperator (
        .A(A), 
        .B(B), 
        .carryIn(1), 
        .sum(diff), 
        .carryOut(subCarry)
    );
    
    MultiplierModule multiplierOperator (
        .A(A), 
        .B(B), 
        .carryIn(carryIn),
        .product(prod), 
        .carryOut(multCarry)
    );
    
    DividerModule dividerOperator (
        .dividend(A), 
        .divisor(B), 
        .quotient(quot), 
        .remainder(divCarry)
    );

    // NEXT STATE LOGIC (combinational)
    always @(*) begin
        next_state = operator;
    end
    // STATE REGISTER (sequential)
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= addition; 
            solution <= 0;
            carryOut <= 0;
        end else 
            state <= next_state;
    end

    // OUTPUT LOGIC 
    always @(*) begin
        case (next_state)
            addition: begin
                solution = {4'b0000, sum};
                carryOut = addCarry;
            end
            subtraction: begin
                solution = {4'b0000, diff};
                carryOut = subCarry;
            end
            multiplication: begin
                solution = prod;
                carryOut = multCarry;
            end
            division: begin
                solution = {4'b0000, quot};
                carryOut = divCarry;
            end
            default: begin
                solution = 0;
                carryOut = 0;
            end
        endcase
    end

endmodule