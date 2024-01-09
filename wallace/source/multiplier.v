`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 23:58:18
// Design Name: 
// Module Name: multiplier
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


module multiplier(
    input   wire [31:0]     A,
    input   wire [31:0]     B,
    output  wire [63:0]     Res
    );

    wire [31:0]          src_o  [20:0];
    wire [63:0]          src    [20:0];

    wire [15:0]         cin;

// Booth_Decoder
    booth_decoder bd_0(
        .y2(A[1]),
        .y1(A[0]),
        .y0(1'b0),
        .src(B),
        .res(src_o[0]),
        .c(cin[0])
    );
    assign src[0] = {{32{src_o[0][31]}}, src_o[0]};

    genvar i;
    generate
        for (i = 2; i < 31; i = i + 2) begin: mul_loop
            booth_decoder bd(
                .y2(A[i + 1]),
                .y1(A[i]),
                .y0(A[i - 1]),
                .src(B),
                .res(src_o[i / 2]),
                .c(cin[i / 2])
            );
            assign src[i / 2] = {{32{src_o[i / 2][31]}}, src_o[i / 2]} << i;
        end
    endgenerate

// Wallace Tree
    wire [63:0] S, C;

    wallace my_w(
        .src1(src[0]),  .src2(src[1]),  .src3(src[2]),  .src4(src[3]),
        .src5(src[4]),  .src6(src[5]),  .src7(src[6]),  .src8(src[7]),
        .src9(src[8]),  .src10(src[9]), .src11(src[10]), .src12(src[11]),
        .src13(src[12]), .src14(src[13]), .src15(src[14]), .src16(src[15]),
        .Cin(cin[15:0]),
        .S(S),
        .C(C)
    );

// 64-bits Adder
    wire cout;
    adder_64 adder(
        .A(S),
        .B({C[62:0], 1'b0}),
        .Cin(0),
        .S(Res),
        .Cout(cout)
    );

endmodule
