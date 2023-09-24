`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 23:47:17
// Design Name: 
// Module Name: adder_32
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


module adder_64(
    input   wire [63:0]     A,
    input   wire [63:0]     B,
    input   wire            Cin,
    output  wire [63:0]     S,
    output  wire            Cout
    );
    assign {Cout, S}        = A + B + Cin;
endmodule
