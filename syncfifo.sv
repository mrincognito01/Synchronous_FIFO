module syncfifo #(parameter WIDTH=8,DEPTH=16)
    (
        input logic [WIDTH-1:0]in,
        input logic clk,
        input logic reset_n,
        input logic wr_en,
        input logic rd_en,
        output logic full,
        output logic empty,
        output logic [WIDTH-1:0]out

    );
    
    logic [WIDTH-1:0]mem[DEPTH-1:0];
    logic [$clog2(DEPTH):0]wr_ptr,rd_ptr;


    assign full         = (wr_ptr[$clog2(DEPTH)] == ~rd_ptr[$clog2(DEPTH)] && wr_ptr[$clog2(DEPTH)-'b1:0]==rd_ptr[$clog2(DEPTH)-'b1:0]);
    assign empty        = (wr_ptr == rd_ptr ? 'b1: 'b0);

   

    always_ff@(posedge clk) 
    begin
        if(!reset_n)
        begin
            wr_ptr          <='d0;
            rd_ptr          <='d0;
            mem             <='{default:'d0};
            out             <= 'd0;
        end

        if(wr_en && !full) //WRITE INTO FIFO
        begin
            mem[wr_ptr[$clog2(DEPTH)-'b1:0]]     <=in;
            wr_ptr          <=wr_ptr+'b1;
        end

        if(rd_en && !empty) //READ FROM FIFO
        begin  
               out          <=mem[rd_ptr[$clog2(DEPTH)-'b1:0]];
               rd_ptr       <=rd_ptr+'b1;
        end

    end

   endmodule

   /*
always_ff@(posedge clk) //WRITE & READ WILL NOT HAPPEN AT SAME TIME
    begin
        if(!reset)
        begin
            wr_ptr          <='d0;
            rd_ptr          <='d0;
            mem             <='{default:'d0};
            out             <= 'd0;
        end

        else if(wr_en && !full) //WRITE INTO FIFO
        begin
            mem[wr_ptr[$clog2(DEPTH)-'b1:0]]     <=in;
            wr_ptr          <=wr_ptr+'b1;
        end

        else if(rd_en && !empty) //READ FROM FIFO
        begin  
               out          <=mem[rd_ptr[$clog2(DEPTH)-'b1:0]];
               rd_ptr       <=rd_ptr+'b1;
        end

    end

   endmodule

   */

















