`timescale 1ns / 1ps

module fp_convert_tb;
    
    reg [11:0]   D;  // two's complement
    reg          S;  // sign bit
    reg [2:0]    E;  // exponent bit
    reg [3:0]    F;  // significand
    
    fp_convert block(
        .D(D),
        .S(S),
        .E(E),
        .F(F)
        );
        
    initial
      begin
		D = 0;
		#100;
        D = -40;
		#100;
		D = 56;
		#100;
		D = 422;
		#100;
		D = 416;
		#100;
		D = 215;
		#100;
      end


endmodule
