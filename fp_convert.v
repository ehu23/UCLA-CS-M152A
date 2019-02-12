`timescale 1ns / 1ps

module fp_convert(
    // Input
    D,
    // Outputs
    S,E,F
    );
    
    input [11:0]    D;  // two's complement
    output          S;  // sign bit
    output [2:0]    E;  // exponent bit
    output [3:0]    F;  // significand
    
    reg [11:0]      sm;     // sign magnitude representation
    reg [2:0]       temp_E;
    reg [3:0]       temp_F;
    reg             fifth;  // fifth bit after leading zeroes
    
    // Convert from two's complement to sign magnitude
    twos_to_sm to_sm(
            .twos(D),
            .sm(sm),
            .sign(S)
        );
    
    // Linear to floating point
    lin_to_fp to_fp(
            .sm(sm),
            .exp(temp_E),
            .sig(temp_F),
            .fifth(fifth)
        );
    
    // Adjust for rounding
    rounding round(
            .fifth(fifth),
            .exp(temp_E),
            .sig(temp_F),
            .new_exp(E),
            .new_sig(F)
        );
    
    
endmodule
    
    
    
    
    
    /*
    
    integer         index;  
    reg [2:0]       lead_z;
    reg [2:0]       exp;
    reg [3:0]       sig;
    reg             round;
    
    always @(posedge clk) begin
    
        // If linear encoding is negative, convert to sign-magnitude
        if (S)
            sign_mag = ~D[11:0] + 'b1;
        
        
        
        
        // ******* we should put these in separate blocks ********
        
        
        // EXPONENT
        // Count leading 0's
        for (index = 0; index < 8; index = index + 1) begin
            if (D[11 - index])
                break;
            lead_z = lead_z + 'b1;
          end
        
        // If 8+ leading 0's, set exp to 0
        exp = ~lead_z[2:0];
        
        // Otherwise set to ~lead_z + 1
        if (~(lead_z[0] & lead_z[1] & lead_z[2] & D[11-index]))
            exp = exp + 'b1;
            
            
            
        // SIGNIFICAND
        // Find index of first 1 to extract significand
        while (~D[11-index])
            index = index + 1;
         
        // Extract significand, the 4 bits after leading zeroes
        for (integer i = 3; i >= 0; i = i - 1) begin
            sig[i] = D[11-index];
            index = index - 1;
          end
        
        
        
        // ROUNDING
        round = D[11 - index];
        
        // Check whether exp needs to be rounded up
        if (round)
            if (sig[0] & sig[1] & sig[2] & sig[3])
                if (~(exp[0] & exp[1] & exp[2]))
                  begin
                    exp = exp + 'b1;
                    sig[3:0] = 4'b1000;
                  end
            else
                sig = sig + 'b1;
        
      end
      
    assign E = exp[2:0];
    assign F = sig[3:0];
    
    */
