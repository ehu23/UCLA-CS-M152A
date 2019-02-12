`timescale 1ns / 1ps

module lin_to_fp(sm, exp, sig, fifth);

    input [11:0]    sm;     // sign magnitude
    output [2:0]    exp;    // exponent
    output [3:0]    sig;    // significand
    output          fifth;  // fifth bit after leading zeroes
    
    integer         index;
    
    assign exp = (!sm[11:4]) ? 0 : (
        (!sm[11:5]) ? 1 :
        (!sm[11:6]) ? 2 :
        (!sm[11:7]) ? 3 :
        (!sm[11:8]) ? 4 :
        (!sm[11:9]) ? 5 :
        (!sm[11:10]) ? 6 : 7);
        
    assign index = 11-(8-exp);
        
    assign sig = sm[index:index-3];
    assign fifth = sm[index-4];
    
endmodule
    
    
    /*
    // EXPONENT
    // Count leading 0's
    for (index = 0; index < 8; index = index + 1) begin
        if (sm[11 - index])
            break;
        lead_z = lead_z + 'b1;
      end
    
    // If 8+ leading 0's, set exp to 0
    assign exp = ~lead_z[2:0];
    
    // Otherwise set to ~lead_z + 1
    if (~(lead_z[0] & lead_z[1] & lead_z[2] & sm[11-index]))
        assign exp = exp + 'b1;
        

    // SIGNIFICAND
    // Find index of first 1 to extract significand
    while (~sm[11-index])
        index = index + 1;
     
    // Extract significand, the 4 bits after leading zeroes
    for (integer i = 3; i >= 0; i = i - 1) begin
        assign sig[i] = D[11-index];
        index = index - 1;
      end
    
    assign fifth = D[11-index];
    */
