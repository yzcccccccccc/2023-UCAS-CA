`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 10:35:42
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
    reg [31:0]     A;
    reg [31:0]     B;
    wire [63:0]     Res, Res_std;
    wire            chk;

    multiplier_std mul_std(
        .A(A),
        .B(B),
        .Res(Res_std)
    );

    multiplier mul(
        .A(A),
        .B(B),
        .Res(Res)
    );

    assign  chk         = (Res == Res_std);

    initial
    begin
        $display("============= Test Begin =============");
        A = 32'd0;
        B = 32'd0;

        # 5;
        A = 32'hFFFFFFFF;
        B = 32'hFFFFFFFF;

        # 5;
        A = 32'd32;
        B = 32'd64;

        # 5;
        A = 32'hFFFFFFFF;
        B = 32'd64;

        # 5;
        $display("Test End");
        $finish;
    end

endmodule
