`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 23:49:35
// Design Name: 
// Module Name: booth_decoder
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


module booth_decoder(
    input   wire            y2,
    input   wire            y1,
    input   wire            y0,
    input   wire [31:0]     src,
    output  wire [31:0]     res,
    output  wire            c
    );

    wire        zero, o_x, t_x, m_x, m_t_x;
    wire [31:0] res_tmp;

    assign zero     = (~y2 & ~y1 & ~y0) | (y2 & y1 & y0);
    assign o_x      = (~y2 & ~y1 & y0) | (~y2 & y1 & ~y0);
    assign t_x      = (~y2 & y1 & y0);
    assign m_x      = (y2 & ~y1 & y0) | (y2 & y1 & ~y0);
    assign m_t_x    = (y2 & ~y1 & ~y0);

    assign res_tmp  = {32{zero}} & 32'b0
                    | {32{o_x}} & src
                    | {32{t_x}} & (src << 32'd1)
                    | {32{m_x}} & (~src)
                    | {32{m_t_x}} & ~(src << 32'd1);
    
    assign c        = m_x | m_t_x;

    assign res      = res_tmp;
endmodule
