`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2025 03:39:13 PM
// Design Name: 
// Module Name: AdderModule
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


module MultiplierModule(
    input [3:0] A,
    input [3:0] B,
    input carryIn,
    output [7:0] product,
    output carryOut
    ); 
    wire [12:0]sums;
    wire c0, c1, c2,c3,c4,c5,c6,c7,c8,c9,c10,c11; // temporary carries
    assign product[0]=A[0]&B[0];
   
    
    HalfAdder HA0 (
        .A((B[0]&A[1])),
        .B((B[1]&A[0])),
        .s(sums[0]),  // Intermediate sum
        .c(c0)   // Carry from first half-adder
    );
    assign product[1]=sums[0];
    FullAdd fa0 (
        .A((B[0]&A[2])), 
        .B((B[1]&A[1])), 
        .carryIn(c0), 
        .sum(sums[1]), 
        .carryOut(c1)
    );
   HalfAdder HA1 (
        .A((sums[1])),
        .B((B[2]&A[0])),
        .s(sums[2]),  // Intermediate sum
        .c(c2)   // Carry from first half-adder
    );
assign product[2]=sums[2];
    FullAdd fa1 (
        .A((B[0]&A[3])), 
        .B((B[1]&A[2])), 
        .carryIn(c1), 
        .sum(sums[3]), 
        .carryOut(c3)
    );
    FullAdd HA2 (
        .A((sums[3])),
        .B((B[2]&A[1])),
        .carryIn(c2),
        .sum(sums[4]),  // Intermediate sum
        .carryOut(c4)   // Carry from first half-adder
    );
    HalfAdder HA3 (
        .A((sums[4])),
        .B((B[3]&A[0])),
        .s(sums[5]),  // Intermediate sum
        .c(c5)   // Carry from first half-adder
    );
assign product[3]=sums[5];
  HalfAdder HA4 (
        .A(c3),
        .B((B[1]&A[3])),
        .s(sums[6]),  // Intermediate sum
        .c(c6)   // Carry from first half-adder
    );
    FullAdd fa2 (
        .A(sums[6]), 
        .B((B[2]&A[2])), 
        .carryIn(c4), 
        .sum(sums[7]), 
        .carryOut(c7)
    );

    FullAdd fa3 (
        .A(sums[7]), 
        .B((B[3]&A[1])), 
        .carryIn(c5), 
        .sum(sums[8]), 
        .carryOut(c8)
    );
  assign product[4]=sums[8];
 FullAdd fa4 (
        .A(c6), 
        .B((A[3]&B[2])), 
        .carryIn(c7), 
        .sum(sums[9]), 
        .carryOut(c9)
    );
  FullAdd fa5 (
        .A(sums[9]), 
        .B((A[2]&B[3])), 
        .carryIn(c8), 
        .sum(sums[10]), 
        .carryOut(c10)
    );
    assign product[5]=sums[10];
FullAdd fa6 (
        .A(c9), 
        .B((A[3]&B[3])), 
        .carryIn(c10), 
        .sum(sums[11]), 
        .carryOut(c11)
    );
    assign product[6] = sums[11];   // FA6 sum output
    assign product[7] = c11;         // FA6 carry output

endmodule
