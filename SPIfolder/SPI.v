module spi(
    input rs,
    input clock_in,
    input mosi,
    output miso,
    output sclk,
    input cs
);
    reg [7:0] data = 8'b10101001;          // Data to send via MISO
    reg [7:0] received_data;              // Data received from MOSI
    reg [2:0] state_mosi;                 // State for MOSI FSM
    reg [2:0] state_miso;                 // State for MISO FSM
    reg [7:0]  read_data;                    // Data to send via MISO

    // State definitions
    localparam MOSI_IDLE_STATE = 0;
    localparam MOSI_START_STATE = 1;
    localparam READ_STATE = 2;
    localparam MOSI_STOP_STATE = 3;

    localparam MISO_IDLE_STATE = 4;
    localparam MISO_START_STATE = 5;
    localparam WRITE_STATE = 6;
    localparam MISO_STOP_STATE = 7;

    reg [3:0] mosi_counter;
    reg [3:0] miso_counter;
    wire spi_clk;
    reg miso_out;
    
    assign spi_clk=clock_in;

    assign sclk=spi_clk;
    assign miso = miso_out;

    initial begin
        state_mosi = MOSI_IDLE_STATE;
        state_miso = MISO_IDLE_STATE;
        miso_out = 1;
    end

    // SPI clock generation
//    always @ (posedge clock_in) begin
//        if (rs == 1) begin
//            spi_clk = 0;
//        end else begin
//            spi_clk = ~spi_clk;
//        end
//    end

    // MOSI state machine (data reception from master)
    always @(negedge spi_clk) begin
     if (rs == 1) begin
           received_data=0;
           state_mosi=MOSI_IDLE_STATE;
           mosi_counter=7;
     end
        
         case(state_mosi)
            MOSI_IDLE_STATE: begin
                if (cs == 0) begin
                    state_mosi = MOSI_START_STATE;
                end
            end

            MOSI_START_STATE: begin
                if (mosi == 0) begin // Start bit detected
                    state_mosi = READ_STATE;
                    mosi_counter = 7;
                end
            end

            READ_STATE: begin
                received_data[mosi_counter] = mosi; // Store bit from MOSI
                if (mosi_counter == 0) begin
                    state_mosi = MOSI_STOP_STATE;
                end
                mosi_counter = mosi_counter - 1;
            end

            MOSI_STOP_STATE: begin
                state_mosi = MOSI_IDLE_STATE; // Return to idle
            end
        endcase
   end 

    // MISO state machine (data transmission to master)
    always @(posedge spi_clk) begin
    if (rs == 1) begin
               read_data=0;
               state_miso=MISO_IDLE_STATE;
               miso_counter=7;
         end
        case(state_miso)
            MISO_IDLE_STATE: begin
                if (cs == 0) begin
                    state_miso = MISO_START_STATE;
                end
            end

            MISO_START_STATE: begin
                miso_out = 0; // Start bit
                state_miso = WRITE_STATE;
                read_data=received_data;
                miso_counter = 7;
            end

            WRITE_STATE: begin
                miso_out = read_data[miso_counter]; // Send bit to MISO
                if (miso_counter == 0) begin
                    state_miso = MISO_STOP_STATE;
                end
                miso_counter = miso_counter - 1;
            end

            MISO_STOP_STATE: begin
                miso_out = 1; // Stop bit
                state_miso = MISO_IDLE_STATE;
            end
        endcase
    end
endmodule
