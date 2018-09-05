-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "09/04/2018 14:43:55"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Adder8 IS
    PORT (
	a : IN std_logic_vector(7 DOWNTO 0);
	b : IN std_logic_vector(7 DOWNTO 0);
	carry_in : IN std_logic;
	sum : OUT std_logic_vector(7 DOWNTO 0);
	carry_out : OUT std_logic
	);
END Adder8;

-- Design Ports Information
-- sum[0]	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[1]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[2]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[3]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[4]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[5]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[6]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sum[7]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- carry_out	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[0]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[0]	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- carry_in	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[1]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[1]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[2]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[2]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[3]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[3]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[4]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[4]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[5]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[5]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[6]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[6]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[7]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[7]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Adder8 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_a : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_b : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_carry_in : std_logic;
SIGNAL ww_sum : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_carry_out : std_logic;
SIGNAL \sum[0]~output_o\ : std_logic;
SIGNAL \sum[1]~output_o\ : std_logic;
SIGNAL \sum[2]~output_o\ : std_logic;
SIGNAL \sum[3]~output_o\ : std_logic;
SIGNAL \sum[4]~output_o\ : std_logic;
SIGNAL \sum[5]~output_o\ : std_logic;
SIGNAL \sum[6]~output_o\ : std_logic;
SIGNAL \sum[7]~output_o\ : std_logic;
SIGNAL \carry_out~output_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \carry_in~input_o\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \RA0|f0|sum~0_combout\ : std_logic;
SIGNAL \RA0|f0|cout~0_combout\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \RA0|f1|sum~combout\ : std_logic;
SIGNAL \RA0|f1|cout~0_combout\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \RA0|f2|sum~combout\ : std_logic;
SIGNAL \RA0|f2|cout~0_combout\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \RA0|f3|sum~combout\ : std_logic;
SIGNAL \b[4]~input_o\ : std_logic;
SIGNAL \a[4]~input_o\ : std_logic;
SIGNAL \RA0|f3|cout~0_combout\ : std_logic;
SIGNAL \sum~0_combout\ : std_logic;
SIGNAL \b[5]~input_o\ : std_logic;
SIGNAL \a[5]~input_o\ : std_logic;
SIGNAL \RA1|f1|sum~0_combout\ : std_logic;
SIGNAL \sum~1_combout\ : std_logic;
SIGNAL \RA2|f1|cout~0_combout\ : std_logic;
SIGNAL \RA1|f1|cout~0_combout\ : std_logic;
SIGNAL \a[6]~input_o\ : std_logic;
SIGNAL \b[6]~input_o\ : std_logic;
SIGNAL \RA1|f2|sum~0_combout\ : std_logic;
SIGNAL \sum~2_combout\ : std_logic;
SIGNAL \RA1|f2|cout~0_combout\ : std_logic;
SIGNAL \RA2|f2|cout~0_combout\ : std_logic;
SIGNAL \b[7]~input_o\ : std_logic;
SIGNAL \a[7]~input_o\ : std_logic;
SIGNAL \RA1|f3|sum~0_combout\ : std_logic;
SIGNAL \sum~3_combout\ : std_logic;
SIGNAL \carry_out~0_combout\ : std_logic;
SIGNAL \carry_out~1_combout\ : std_logic;

BEGIN

ww_a <= a;
ww_b <= b;
ww_carry_in <= carry_in;
sum <= ww_sum;
carry_out <= ww_carry_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X33_Y22_N2
\sum[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RA0|f0|sum~0_combout\,
	devoe => ww_devoe,
	o => \sum[0]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\sum[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RA0|f1|sum~combout\,
	devoe => ww_devoe,
	o => \sum[1]~output_o\);

-- Location: IOOBUF_X22_Y31_N2
\sum[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RA0|f2|sum~combout\,
	devoe => ww_devoe,
	o => \sum[2]~output_o\);

-- Location: IOOBUF_X33_Y22_N9
\sum[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RA0|f3|sum~combout\,
	devoe => ww_devoe,
	o => \sum[3]~output_o\);

-- Location: IOOBUF_X14_Y31_N9
\sum[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sum~0_combout\,
	devoe => ww_devoe,
	o => \sum[4]~output_o\);

-- Location: IOOBUF_X29_Y31_N9
\sum[5]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sum~1_combout\,
	devoe => ww_devoe,
	o => \sum[5]~output_o\);

-- Location: IOOBUF_X24_Y31_N2
\sum[6]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sum~2_combout\,
	devoe => ww_devoe,
	o => \sum[6]~output_o\);

-- Location: IOOBUF_X33_Y28_N9
\sum[7]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sum~3_combout\,
	devoe => ww_devoe,
	o => \sum[7]~output_o\);

-- Location: IOOBUF_X20_Y31_N2
\carry_out~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \carry_out~1_combout\,
	devoe => ww_devoe,
	o => \carry_out~output_o\);

-- Location: IOIBUF_X26_Y0_N8
\b[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

-- Location: IOIBUF_X22_Y0_N1
\carry_in~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_carry_in,
	o => \carry_in~input_o\);

-- Location: IOIBUF_X33_Y25_N1
\a[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

-- Location: LCCOMB_X29_Y26_N24
\RA0|f0|sum~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f0|sum~0_combout\ = \b[0]~input_o\ $ (\carry_in~input_o\ $ (\a[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b[0]~input_o\,
	datac => \carry_in~input_o\,
	datad => \a[0]~input_o\,
	combout => \RA0|f0|sum~0_combout\);

-- Location: LCCOMB_X29_Y26_N10
\RA0|f0|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f0|cout~0_combout\ = (\b[0]~input_o\ & ((\carry_in~input_o\) # (\a[0]~input_o\))) # (!\b[0]~input_o\ & (\carry_in~input_o\ & \a[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b[0]~input_o\,
	datac => \carry_in~input_o\,
	datad => \a[0]~input_o\,
	combout => \RA0|f0|cout~0_combout\);

-- Location: IOIBUF_X33_Y24_N1
\b[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

-- Location: IOIBUF_X33_Y27_N8
\a[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

-- Location: LCCOMB_X29_Y26_N12
\RA0|f1|sum\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f1|sum~combout\ = \RA0|f0|cout~0_combout\ $ (\b[1]~input_o\ $ (\a[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA0|f0|cout~0_combout\,
	datac => \b[1]~input_o\,
	datad => \a[1]~input_o\,
	combout => \RA0|f1|sum~combout\);

-- Location: LCCOMB_X29_Y26_N22
\RA0|f1|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f1|cout~0_combout\ = (\RA0|f0|cout~0_combout\ & ((\b[1]~input_o\) # (\a[1]~input_o\))) # (!\RA0|f0|cout~0_combout\ & (\b[1]~input_o\ & \a[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA0|f0|cout~0_combout\,
	datac => \b[1]~input_o\,
	datad => \a[1]~input_o\,
	combout => \RA0|f1|cout~0_combout\);

-- Location: IOIBUF_X33_Y25_N8
\b[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

-- Location: IOIBUF_X26_Y31_N8
\a[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

-- Location: LCCOMB_X29_Y26_N0
\RA0|f2|sum\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f2|sum~combout\ = \RA0|f1|cout~0_combout\ $ (\b[2]~input_o\ $ (\a[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011010010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA0|f1|cout~0_combout\,
	datab => \b[2]~input_o\,
	datac => \a[2]~input_o\,
	combout => \RA0|f2|sum~combout\);

-- Location: LCCOMB_X29_Y26_N2
\RA0|f2|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f2|cout~0_combout\ = (\RA0|f1|cout~0_combout\ & ((\b[2]~input_o\) # (\a[2]~input_o\))) # (!\RA0|f1|cout~0_combout\ & (\b[2]~input_o\ & \a[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA0|f1|cout~0_combout\,
	datab => \b[2]~input_o\,
	datac => \a[2]~input_o\,
	combout => \RA0|f2|cout~0_combout\);

-- Location: IOIBUF_X33_Y14_N1
\a[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

-- Location: IOIBUF_X33_Y14_N8
\b[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

-- Location: LCCOMB_X29_Y26_N4
\RA0|f3|sum\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f3|sum~combout\ = \RA0|f2|cout~0_combout\ $ (\a[3]~input_o\ $ (\b[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RA0|f2|cout~0_combout\,
	datac => \a[3]~input_o\,
	datad => \b[3]~input_o\,
	combout => \RA0|f3|sum~combout\);

-- Location: IOIBUF_X20_Y0_N8
\b[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(4),
	o => \b[4]~input_o\);

-- Location: IOIBUF_X33_Y28_N1
\a[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(4),
	o => \a[4]~input_o\);

-- Location: LCCOMB_X29_Y26_N6
\RA0|f3|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA0|f3|cout~0_combout\ = (\RA0|f2|cout~0_combout\ & ((\a[3]~input_o\) # (\b[3]~input_o\))) # (!\RA0|f2|cout~0_combout\ & (\a[3]~input_o\ & \b[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RA0|f2|cout~0_combout\,
	datac => \a[3]~input_o\,
	datad => \b[3]~input_o\,
	combout => \RA0|f3|cout~0_combout\);

-- Location: LCCOMB_X21_Y29_N8
\sum~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sum~0_combout\ = \b[4]~input_o\ $ (\a[4]~input_o\ $ (\RA0|f3|cout~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b[4]~input_o\,
	datac => \a[4]~input_o\,
	datad => \RA0|f3|cout~0_combout\,
	combout => \sum~0_combout\);

-- Location: IOIBUF_X16_Y31_N8
\b[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(5),
	o => \b[5]~input_o\);

-- Location: IOIBUF_X16_Y31_N1
\a[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(5),
	o => \a[5]~input_o\);

-- Location: LCCOMB_X21_Y29_N26
\RA1|f1|sum~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA1|f1|sum~0_combout\ = \b[5]~input_o\ $ (\a[5]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b[5]~input_o\,
	datac => \a[5]~input_o\,
	combout => \RA1|f1|sum~0_combout\);

-- Location: LCCOMB_X21_Y29_N12
\sum~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sum~1_combout\ = \RA1|f1|sum~0_combout\ $ (((\b[4]~input_o\ & ((\a[4]~input_o\) # (\RA0|f3|cout~0_combout\))) # (!\b[4]~input_o\ & (\a[4]~input_o\ & \RA0|f3|cout~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA1|f1|sum~0_combout\,
	datab => \b[4]~input_o\,
	datac => \a[4]~input_o\,
	datad => \RA0|f3|cout~0_combout\,
	combout => \sum~1_combout\);

-- Location: LCCOMB_X21_Y29_N16
\RA2|f1|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA2|f1|cout~0_combout\ = (\a[5]~input_o\ & ((\b[5]~input_o\) # ((\a[4]~input_o\) # (\b[4]~input_o\)))) # (!\a[5]~input_o\ & (\b[5]~input_o\ & ((\a[4]~input_o\) # (\b[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \a[5]~input_o\,
	datab => \b[5]~input_o\,
	datac => \a[4]~input_o\,
	datad => \b[4]~input_o\,
	combout => \RA2|f1|cout~0_combout\);

-- Location: LCCOMB_X21_Y29_N22
\RA1|f1|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA1|f1|cout~0_combout\ = (\a[5]~input_o\ & ((\b[5]~input_o\) # ((\a[4]~input_o\ & \b[4]~input_o\)))) # (!\a[5]~input_o\ & (\b[5]~input_o\ & (\a[4]~input_o\ & \b[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \a[5]~input_o\,
	datab => \b[5]~input_o\,
	datac => \a[4]~input_o\,
	datad => \b[4]~input_o\,
	combout => \RA1|f1|cout~0_combout\);

-- Location: IOIBUF_X22_Y31_N8
\a[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(6),
	o => \a[6]~input_o\);

-- Location: IOIBUF_X29_Y31_N1
\b[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(6),
	o => \b[6]~input_o\);

-- Location: LCCOMB_X21_Y29_N2
\RA1|f2|sum~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA1|f2|sum~0_combout\ = \a[6]~input_o\ $ (\b[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \a[6]~input_o\,
	datad => \b[6]~input_o\,
	combout => \RA1|f2|sum~0_combout\);

-- Location: LCCOMB_X21_Y29_N4
\sum~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sum~2_combout\ = \RA1|f2|sum~0_combout\ $ (((\RA0|f3|cout~0_combout\ & (\RA2|f1|cout~0_combout\)) # (!\RA0|f3|cout~0_combout\ & ((\RA1|f1|cout~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010011111011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA0|f3|cout~0_combout\,
	datab => \RA2|f1|cout~0_combout\,
	datac => \RA1|f1|cout~0_combout\,
	datad => \RA1|f2|sum~0_combout\,
	combout => \sum~2_combout\);

-- Location: LCCOMB_X21_Y29_N6
\RA1|f2|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA1|f2|cout~0_combout\ = (\a[6]~input_o\ & ((\RA1|f1|cout~0_combout\) # (\b[6]~input_o\))) # (!\a[6]~input_o\ & (\RA1|f1|cout~0_combout\ & \b[6]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \a[6]~input_o\,
	datac => \RA1|f1|cout~0_combout\,
	datad => \b[6]~input_o\,
	combout => \RA1|f2|cout~0_combout\);

-- Location: LCCOMB_X21_Y29_N0
\RA2|f2|cout~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA2|f2|cout~0_combout\ = (\RA2|f1|cout~0_combout\ & ((\a[6]~input_o\) # (\b[6]~input_o\))) # (!\RA2|f1|cout~0_combout\ & (\a[6]~input_o\ & \b[6]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RA2|f1|cout~0_combout\,
	datac => \a[6]~input_o\,
	datad => \b[6]~input_o\,
	combout => \RA2|f2|cout~0_combout\);

-- Location: IOIBUF_X20_Y31_N8
\b[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(7),
	o => \b[7]~input_o\);

-- Location: IOIBUF_X22_Y0_N8
\a[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(7),
	o => \a[7]~input_o\);

-- Location: LCCOMB_X21_Y29_N10
\RA1|f3|sum~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RA1|f3|sum~0_combout\ = \b[7]~input_o\ $ (\a[7]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \b[7]~input_o\,
	datad => \a[7]~input_o\,
	combout => \RA1|f3|sum~0_combout\);

-- Location: LCCOMB_X21_Y29_N20
\sum~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sum~3_combout\ = \RA1|f3|sum~0_combout\ $ (((\RA0|f3|cout~0_combout\ & ((\RA2|f2|cout~0_combout\))) # (!\RA0|f3|cout~0_combout\ & (\RA1|f2|cout~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA1|f2|cout~0_combout\,
	datab => \RA2|f2|cout~0_combout\,
	datac => \RA1|f3|sum~0_combout\,
	datad => \RA0|f3|cout~0_combout\,
	combout => \sum~3_combout\);

-- Location: LCCOMB_X21_Y29_N30
\carry_out~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \carry_out~0_combout\ = (\RA2|f2|cout~0_combout\ & ((\RA1|f2|cout~0_combout\) # (\RA0|f3|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RA1|f2|cout~0_combout\,
	datab => \RA2|f2|cout~0_combout\,
	datad => \RA0|f3|cout~0_combout\,
	combout => \carry_out~0_combout\);

-- Location: LCCOMB_X21_Y29_N24
\carry_out~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \carry_out~1_combout\ = (\carry_out~0_combout\ & ((\b[7]~input_o\) # (\a[7]~input_o\))) # (!\carry_out~0_combout\ & (\b[7]~input_o\ & \a[7]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \carry_out~0_combout\,
	datac => \b[7]~input_o\,
	datad => \a[7]~input_o\,
	combout => \carry_out~1_combout\);

ww_sum(0) <= \sum[0]~output_o\;

ww_sum(1) <= \sum[1]~output_o\;

ww_sum(2) <= \sum[2]~output_o\;

ww_sum(3) <= \sum[3]~output_o\;

ww_sum(4) <= \sum[4]~output_o\;

ww_sum(5) <= \sum[5]~output_o\;

ww_sum(6) <= \sum[6]~output_o\;

ww_sum(7) <= \sum[7]~output_o\;

ww_carry_out <= \carry_out~output_o\;
END structure;


