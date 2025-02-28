/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_preethika_lfsr (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire rst = ! rst_n;
    assign uio_oe = 8'b00000000;
    assign uio_out = 8'b00000000;
    assign uo_out[7:3] = 5'b00000;

    wb_LFSR wb_lfsr(
      .i_clk(clk), 
      .i_reset(rst), 
      .i_wb_cyc(uio_in[0]), 
      .i_wb_stb(uio_in[1]), 
      .i_wb_we(uio_in[2]), 
      .i_wb_addr(uio_in[5:3]), 
      .i_wb_data(ui_in), 
      .o_wb_stall(uo_out[0]),
      .o_wb_data(uo_out[1]),
      .o_wb_ack(uo_out[2])
);

endmodule
