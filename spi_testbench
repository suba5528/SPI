`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 11:28:51
// Design Name: 
// Module Name: spi_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for SPI module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module spi_tb;
    // Declare inputs and outputs
    reg rs;              // Reset signal
    reg clock_in;        // Input clock
    reg mosi;            // Master-to-slave data
    wire miso;           // Slave-to-master data
    wire sclk;           // SPI clock
    reg cs;             // Chip select

    // Instantiate the SPI module
    spi uut (
        .rs(rs),
        .clock_in(clock_in),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk),
        .cs(cs)
    );

    // Generate clock signal for the simulation
    initial begin
        clock_in = 0;
        forever #5 clock_in = ~clock_in; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rs = 1;       // Assert reset
        cs = 1;     // Deassert CS (inactive high)
        mosi = 0;    // Default idle state for MOSI

        #10 rs = 0; // Release reset after 10 time units

        // Begin SPI communication
        #10 cs = 0; // Assert CS (active low)
        // Simulate sending 8 bits from master to slave (via MOSI)
        #20 mosi = 1;  // Send first bit (MSB)
        #10 mosi = 0;  // Send second bit
        #10 mosi = 1;  // Send third bit
        #10 mosi = 0;  // Send fourth bit
        #10 mosi = 1;  // Send fifth bit
        #10 mosi = 1;  // Send sixth bit
        #10 mosi = 0;  // Send seventh bit
        #10 mosi = 0;  // Send eighth bit (LSB)
        // End SPI communication
        #20 cs = 1; // Deassert CS (inactive high)
        mosi=0; // initialize mosi to zero
        
         // Begin 2nd SPI communication
          #20 cs = 0; // Assert CS (active low)
               // Simulate sending 8 bits from master to slave (via MOSI)
          #20 mosi = 0;  // Send first bit (MSB)
          #10 mosi = 0;  // Send second bit
          #10 mosi = 1;  // Send third bit
          #10 mosi = 0;  // Send fourth bit
          #10 mosi = 0;  // Send fifth bit
          #10 mosi = 1;  // Send sixth bit
          #10 mosi = 0;  // Send seventh bit
          #10 mosi = 1;  // Send eighth bit (LSB)
       // End SPI communication
         #20 cs = 1; // Deassert CS (inactive high)
         mosi=0;// initialize mosi to zero
         
         // Begin 3rd SPI communication
          #20 cs = 0; // Assert CS (active low)
        // Simulate sending 8 bits from master to slave (via MOSI)
           #20 mosi = 0;  // Send first bit (MSB)
           #10 mosi = 0;  // Send second bit
           #10 mosi = 0;  // Send third bit
           #10 mosi = 1;  // Send fourth bit
           #10 mosi = 0;  // Send fifth bit
           #10 mosi = 0;  // Send sixth bit
           #10 mosi = 0;  // Send seventh bit
           #10 mosi = 1;  // Send eighth bit (LSB)
       // End SPI communication
           #20 cs = 1; // Deassert CS (inactive high)
           mosi=0; // initialize mosi to zero
           
          // Begin 4th SPI communication
           #20 cs = 0; // Assert CS (active low)
         // Simulate sending 8 bits from master to slave (via MOSI)
           #20 mosi = 1;  // Send first bit (MSB)
           #10 mosi = 0;  // Send second bit
           #10 mosi = 0;  // Send third bit
           #10 mosi = 0;  // Send fourth bit
           #10 mosi = 1;  // Send fifth bit
           #10 mosi = 0;  // Send sixth bit
           #10 mosi = 0;  // Send seventh bit
           #10 mosi = 0;  // Send eighth bit (LSB)
        // End SPI communication
           #20 cs = 1; // Deassert CS (inactive high)
           mosi=0;  // initialize mosi to zero

        // Wait and finish simulation
        #100 $finish;
    end

    // Monitor signals for debugging
    initial begin
        $monitor("Time=%0t | RS=%b | Clock=%b | MOSI=%b | MISO=%b | SCLK=%b | CS=%b | Received_Data=%b",
                 $time, rs, clock_in, mosi, miso, sclk, cs, uut.received_data);
    end

endmodule
