`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 22:56:08
// Design Name: 
// Module Name: 1bit_wallace
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


module wallace_1bit(
    input   wire [15:0]     N,
    input   wire [4:0]      l1_cin,
    input   wire [3:0]      l2_cin,
    input   wire [1:0]      l3_cin,
    input   wire [1:0]      l4_cin,
    input   wire            l5_cin,
    input   wire            cin,

    output  wire [4:0]      l1_cout,
    output  wire [3:0]      l2_cout,
    output  wire [1:0]      l3_cout,
    output  wire [1:0]      l4_cout,
    output  wire            l5_cout,

    output  wire            C,
    output  wire            S
    );
    
    //-------------------------- DEF --------------------------
        wire [4:0]      l1_C;
        wire [4:0]      l1_S;

        wire [3:0]      l2_C;
        wire [3:0]      l2_S;

        wire [1:0]      l3_C;
        wire [1:0]      l3_S;

        wire [1:0]      l4_C;
        wire [1:0]      l4_S;

        wire            l5_C, l5_S;

    //-------------------------- Layer 1 --------------------------
        FA  FA_1(
            .A(N[0]),
            .B(N[1]),
            .Cin(N[2]),
            .S(l1_S[0]),
            .Cout(l1_C[0])
        );

        FA  FA_2(
            .A(N[3]),
            .B(N[4]),
            .Cin(N[5]),
            .S(l1_S[1]),
            .Cout(l1_C[1])
        );

        FA  FA_3(
            .A(N[6]),
            .B(N[7]),
            .Cin(N[8]),
            .S(l1_S[2]),
            .Cout(l1_C[2])
        );

        FA  FA_4(
            .A(N[9]),
            .B(N[10]),
            .Cin(N[11]),
            .S(l1_S[3]),
            .Cout(l1_C[3])
        );

        FA  FA_5(
            .A(N[12]),
            .B(N[13]),
            .Cin(N[14]),
            .S(l1_S[4]),
            .Cout(l1_C[4])
        );

        assign l1_cout = l1_C;
    
    //-------------------------- Layer 2 --------------------------
        FA  FA_6(
            .A(l1_S[0]),
            .B(l1_S[1]),
            .Cin(l1_S[2]),
            .S(l2_S[0]),
            .Cout(l2_C[0])
        );

        FA  FA_7(
            .A(l1_S[3]),
            .B(l1_S[4]),
            .Cin(l1_cin[0]),
            .S(l2_S[1]),
            .Cout(l2_C[1])
        );

        FA  FA_8(
            .A(l1_cin[1]),
            .B(l1_cin[2]),
            .Cin(l1_cin[3]),
            .S(l2_S[2]),
            .Cout(l2_C[2])
        );

        FA  HA_1(
            .A(l1_cin[4]),
            .B(N[15]),
            .Cin(cin),
            .S(l2_S[3]),
            .Cout(l2_C[3])
        );

        assign l2_cout = l2_C;

    //-------------------------- Layer 3 --------------------------
        FA  FA_9(
            .A(l2_S[0]),
            .B(l2_S[1]),
            .Cin(l2_S[2]),
            .S(l3_S[0]),
            .Cout(l3_C[0])
        );

        FA  FA_10(
            .A(l2_S[3]),
            .B(l2_cin[0]),
            .Cin(l2_cin[1]),
            .S(l3_S[1]),
            .Cout(l3_C[1])
        );

        assign l3_cout = l3_C;

    //-------------------------- Layer 4 --------------------------
        FA  FA_11(
            .A(l3_S[0]),
            .B(l3_S[1]),
            .Cin(l3_cin[0]),
            .S(l4_S[0]),
            .Cout(l4_C[0])
        );

        FA  FA_12(
            .A(l3_cin[1]),
            .B(l2_cin[2]),
            .Cin(l2_cin[3]),
            .S(l4_S[1]),
            .Cout(l4_C[1])
        );

        assign l4_cout = l4_C;

    //-------------------------- Layer 5 --------------------------
        FA  FA_13(
            .A(l4_S[0]),
            .B(l4_S[1]),
            .Cin(l4_cin[0]),
            .S(l5_S),
            .Cout(l5_C)
        );

        assign l5_cout = l5_C;
        
    //-------------------------- Layer 6 --------------------------
        FA  FA_14(
            .A(l5_S),
            .B(l5_cin),
            .Cin(l4_cin[1]),
            .S(S),
            .Cout(C)
        );

endmodule
