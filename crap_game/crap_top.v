// top module for crap 


module top_crap ( input reset , clk , btn ,
                  output Win , Loose , Press,
                  output reg [6:0] seg1,seg2;
                
);
    

    // internal register 

    reg [3:0] sum ;
    reg [3:0] diceout1 = 4'b0 ;
    reg [3:0] diceout2 = 4'b0 ;
    reg [3:0] sum;
    reg cout; 
    


    // instantialtion 


    // dice gen

    dice_gen dice1 ( reset , clk , btn
                    diceout1
    );

    dice_gen dice2 ( reset , clk , btn
                    diceout2
    );

    // sum 

    ripple_carry_adder  sum (
    diceout1, diceout2 , // 4-bit operands
    1'b0,        // Carry-in
    sum, // 4-bit sum
    cout       // Carry-out
    );

    /// seven segment 

    seven_seg_decoder seg1 (sum , seg1 );

    if (sum >= 10) begin
        
        seven_seg_decoder seg1 ({0,sum[2:0]}, seg1 );

        seg2 <= 7'b0110000;
    end

    // fsm instatinatom

    crap_fsm  fsm ( clk , reset ,  btn'
                  sum,
                  Win, Loose , Press
    
);




endmodule