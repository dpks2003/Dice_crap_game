// this module contins the state of the crap 



module crap_fsm ( input clk , reset ,  btn'
                  input reg [3:0] sum,
                  output win, loose , press
    
);

 // internal states 

 localparam  IDEL = 3'b001,
             First_roll = 3'b010,
             Keep_rolling = 3'b011,
             Win = 3'b100,
             Loose = 3'b101;


// internal register 

 wire  win_w ,loose_w , press_again ;
 reg [3:0] points ; 
 reg [2:0] state_reg


 always @ (posedge) begin
    
    if (reset) begin
        win_w <= 0;
        loose_W <=0;
        points <= 0;
        state_reg <= IDEL  ;
        press_again <=1'b0;
    end

    else begin



        
        case  (state_reg) begin

            IDEL : begin

                press_again <= 1b1; 

                if (btn) begin
                  state_reg <= First_roll ;  
                end
                
                
            end
            
            First_roll : begin
                
                if ( sum == 7 || sum == 11 ) begin
                    
                    state_reg <= Win ;
                end

                else if ( sum == 2 ||sum == 3 ||sum == 12 ) begin
                    
                    state_reg <= Loose ;
                end

                else begin
                    points <= sum ;
                    state_reg <= Keep_rolling ;
                    press_again <= 1'b1;
                end
            end

            Keep_rolling : begin

                if ( sum == points ) begin 

                    state_reg <= Win ;
                end 

                if ( sum == 7) begin
                    state_reg <= Loose;
                end

                else begin
                    state_reg <= Keep_rolling ;
                    press_again <= 1'b1;
                end
                
            end

            Win : begin
                win_w <= 1'b1;
                if (reset) begin
                    state_reg <= IDEL;
                end
                else begin
                    state_reg <= Win;
                end
            end

            Loose : begin
                loose_W <= 1'b1;
                if(reset) begin
                state_reg <= IDEL ;
                end

                else begin
                    state_reg <= Loose
                end
            end
        end

        endcase
    end
 end

 assign win = win_w;
 assign loose= loose_W;
 assign press = press_again;
    
endmodule