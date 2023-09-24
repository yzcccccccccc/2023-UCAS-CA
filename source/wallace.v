`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 23:24:22
// Design Name: 
// Module Name: wallace
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


module wallace(
    input   wire [63:0]     src1,
    input   wire [63:0]     src2,
    input   wire [63:0]     src3,
    input   wire [63:0]     src4,
    input   wire [63:0]     src5,
    input   wire [63:0]     src6,
    input   wire [63:0]     src7,
    input   wire [63:0]     src8,
    input   wire [63:0]     src9,
    input   wire [63:0]     src10,
    input   wire [63:0]     src11,
    input   wire [63:0]     src12,
    input   wire [63:0]     src13,
    input   wire [63:0]     src14,
    input   wire [63:0]     src15,
    input   wire [63:0]     src16,

    input   wire [15:0]      Cin,

    output  wire [63:0]     S,
    output  wire [63:0]     C
    );

    wire [15:0]      w_in   [66:0];
    wire [13:0]      w_cout [66:0];

    assign w_cout[0]    = 0;

    genvar  i;
    generate
        for (i = 0; i < 64; i=i + 1)
        begin:  wallace_loop
            assign w_in[i]  = {src16[i], src15[i], src14[i], src13[i], src12[i], src11[i], src10[i],
                                src9[i], src8[i], src7[i], src6[i], src5[i], src4[i], src3[i], src2[i], src1[i]};
            wallace_1bit u_w_1bit(
                .N(w_in[i]),
                .l1_cin(w_cout[i][4:0]),
                .l2_cin(w_cout[i][8:5]),
                .l3_cin(w_cout[i][10:9]),
                .l4_cin(w_cout[i][12:11]),
                .l5_cin(w_cout[i][13]),
                .cin((i & 32'd1) ? 1'b0 : (i < 32 ? Cin[i >> 32'd1] : 1'b0)),
                .l1_cout(w_cout[i + 1][4:0]),
                .l2_cout(w_cout[i + 1][8:5]),
                .l3_cout(w_cout[i + 1][10:9]),
                .l4_cout(w_cout[i + 1][12:11]),
                .l5_cout(w_cout[i + 1][13]),
                .S(S[i]),
                .C(C[i])
            );
        end
    endgenerate

endmodule
