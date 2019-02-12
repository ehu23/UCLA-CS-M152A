`timescale 1ns / 1ps

module twos_to_sm(twos, sm, sign);

    input [11:0]	twos;	// twos complement representation
    output [11:0]	sm;		// sign magnitude representation
    output			sign;

    assign sign = twos[11];
    assign sm = (sign) ? (~twos[11:0] + 1'b1) : twos[11:0];
    
    /*
    if (sign)
        assign sm = ~twos[11:0] + 1'b1;
    else
        assign sm = twos[11:0];
    */
	
endmodule