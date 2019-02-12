`timescale 1ns / 1ps

module rounding(fifth, exp, sig, new_exp, new_sig);

    input           fifth;  // fifth bit after leading zeroes
    input [2:0]     exp;
    input [3:0]     sig;
    output [2:0]    new_exp;
    output [3:0]    new_sig;
    
    reg [2:0]    out_exp;
    reg [3:0]    out_sig;
    
    always @*
      begin
        if (fifth)
          begin
            if (sig[0] & sig[1] & sig[2] & sig[3])
                if (~(exp[0] & exp[1] & exp[2]))
                  begin
                    out_exp = exp + 'b1;
                    out_sig[3:0] = 4'b1000;
                  end
            else
                out_sig = sig + 'b1;
           end
         else
          begin
            out_exp = exp;
            out_sig = sig;
          end
      end
      
    assign new_sig = out_sig;
    assign new_exp = out_exp;

endmodule
