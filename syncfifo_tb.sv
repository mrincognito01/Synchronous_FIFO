module syncfifo_tb;

    parameter WIDTH=8;
    parameter DEPTH=16;

    logic [WIDTH-1:0]in;
    logic clk;
    logic reset_n;
    logic wr_en;
    logic rd_en;
    logic full;
    logic empty;
    logic [WIDTH-1:0]out;

    syncfifo uut(.in(in),.clk(clk),.reset_n(reset_n),.wr_en(wr_en),.rd_en(rd_en),.full(full),.empty(empty),.out(out));


    
    
initial
     begin
         clk=0;
         forever #5 clk=~clk;
     end



initial 
begin
        reset_n='b0;
        #15;
        reset_n='b1;
    
//1st        
        wr_en='b1;
        rd_en='b0;

        repeat(18) 
        begin
            in = $random;
            #10;
        end
         wr_en='b0;
         rd_en='b1;
         #200;

//2nd 
        rd_en ='b0;
         wr_en ='b1;

        repeat(18) 
        begin
            in = $random;
            #10;
        end

        wr_en = 'b0;
        rd_en = 'b1;
        #180;

//3rd
        rd_en = 'b0;
        wr_en = 'b1;

        repeat(20) 
        begin
            in = $random;
            #10;
        end

        wr_en = 'b0;
        rd_en = 'b1;
        #200;

       rd_en = 'b0;
        #20;

    
$finish;               
end
endmodule

        



        
