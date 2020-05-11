//
`timescale 1ns/1ps
//
// c7seg_dec.v
//
module c7seg_dec (
 input      [3:0] in,
 output reg [7:0] o_out);  
//
// 7-segment decoder ( Active Low )
//
 always @(in) begin
    case(in)
       4'h0   : o_out = 7'b0000001; // 0
       4'h1   : o_out = 7'b1001111; // 1
       4'h2   : o_out = 7'b0010010; // 2
       4'h3   : o_out = 7'b0000110; // 3
       4'h4   : o_out = 7'b1001100; // 4
       4'h5   : o_out = 7'b0100100; // 5
       4'h6   : o_out = 7'b0100000; // 6
       4'h7   : o_out = 7'b0001111; // 7
       4'h8   : o_out = 7'b0000000; // 8
       4'h9   : o_out = 7'b0000100; // 9
       4'hA   : o_out = 7'b0001000; // A
       4'hb   : o_out = 7'b1100000; // B
       4'hC   : o_out = 7'b0110001; // C
       4'hd   : o_out = 7'b1000010; // D
       4'hE   : o_out = 7'b0110000; // E
       4'hF   : o_out = 7'b0111000; // F
       default: o_out = 7'b0000001; // 0
    endcase
 end
//
endmodule
