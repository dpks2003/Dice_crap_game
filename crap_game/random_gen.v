// this module genrated the random no of the dice needed 

  module dice_gen ( input reset , clk , btn
                    output reg[2:0] dice_out
  );


    // logic for ccreating no 
    // num_gen  is the interanal register used for creating number   

  reg [5:0] num_gen = 5'b01101;

  always @(posedge clk ) begin

    if (reset ) begin
        num_gen <= 5'b01101;
        dice_out <= 0;
    end

    else if (btn) begin
        num_gen <= num_gen ^ (num_gen << 3) ^ (num_gen >> 2);

        dice_out <= ((num_gen[4:2] %6) +1) ;
    end
    

  end

 //  assign dice_out = ((num_gen[4:2] %6) +1) ; 

  endmodule