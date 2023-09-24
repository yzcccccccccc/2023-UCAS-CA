`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 12:23:31
// Design Name: 
// Module Name: multiplier_std
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


module multiplier_std(
    input   wire [31:0]     A,
    input   wire [31:0]     B,
    output  wire [63:0]     Res
    );
    wire        sign;
    wire [31:0] srcA, srcB;
    wire [63:0] Res_tmp;

    assign sign     = A[31] ^ B[31];

    assign srcA     = A[31] ? (~A + 1) : A;
    assign srcB     = B[31] ? (~B + 1) : B;

    assign Res_tmp  = srcA * srcB;

    assign Res      = sign ? (~Res_tmp + 1) : Res_tmp;
endmodule
