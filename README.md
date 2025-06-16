# UART Design and Verification in Verilog

## 📌 Overview
This project involves the design and functional verification of a **Universal Asynchronous Receiver/Transmitter (UART)** using Verilog. UART is a widely used protocol for asynchronous serial communication between digital systems. The project covers UART transmission, reception, baud rate generation, and thorough testbench verification.

---

## 🎯 Objective
- Design a UART Transmitter and Receiver in Verilog.
- Generate appropriate baud rate clock.
- Verify UART functionality using a self-checking testbench.
- (Optional) Implement and test on FPGA using a serial terminal like TeraTerm or PuTTY.

---

## ⚙️ Specifications

| Parameter        | Value                     |
|------------------|---------------------------|
| Baud Rate        | 9600 / 115200 (configurable) |
| Data Bits        | 8                         |
| Stop Bit         | 1                         |
| Parity           | None                      |
| Start Bit        | 1 (Low)                   |
| Clock Frequency  | 50 MHz                    |

---

## 🧩 Module Descriptions

### `uart_tx.v` – UART Transmitter
- Transmits 8-bit parallel data serially.
- Adds start and stop bits.
- Uses baud clock for timing.

### `uart_rx.v` – UART Receiver
- Receives serial data, samples at mid-bit.
- Extracts 8-bit data from serial stream.
- Validates start and stop bits.

### `baud_gen.v` – Baud Rate Generator
- Divides input clock to desired baud rate.
- Used to time both transmitter and receiver.

### `uart_top.v` – Top Module
- Integrates TX, RX, and baud generator.
- Acts as the complete UART core.

---

## 🧪 Testbench

### `uart_tb.v` – UART Testbench
- Provides test inputs to the UART TX.
- Internally loops back TX to RX.
- Compares transmitted and received data.
- Logs results and displays waveform in simulator.

---

## 🧰 Tools Used

- **Language**: Verilog HDL  
- **Simulator**: Icarus Verilog + GTKWave / ModelSim / Vivado Simulator  
- **FPGA (Optional)**: Xilinx Basys 3 or Nexys A7  
- **Serial Terminal**: TeraTerm / PuTTY  

---

## 🧠 How to Run

### 🚀 Simulation

1. Compile the design and testbench using Icarus Verilog:
    ```bash
    iverilog -o uart_sim uart_tx.v uart_rx.v baud_gen.v uart_top.v uart_tb.v
    ```

2. Run simulation:
    ```bash
    vvp uart_sim
    ```

3. View waveforms:
    ```bash
    gtkwave dump.vcd
    ```

### 🔧 FPGA (Optional)

1. Generate bitstream using Vivado or your preferred tool.  
2. Connect USB-to-Serial module or onboard UART port.  
3. Send and receive data via serial terminal.  

---

## 📈 Results

- Transmitted and received data matched in simulation.  
- FSM behavior validated through waveform.  
- (Optional) Verified communication on FPGA using TeraTerm.  

---

## ✅ Future Enhancements

- Add support for:
  - Parity bit
  - Configurable stop bits
  - Framing error detection
- AXI/AMBA-based UART interface
- FIFO buffers for TX and RX

---

## 📚 References

- Xilinx UART IP Documentation  
- [Wikipedia - UART](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter)  
- [ASIC-World Verilog UART Tutorial](https://www.asic-world.com/verilog/art_uart.html)  

---

## 👨‍💻 Author
- **Saksham Sinha** –  ECE Undergraduate, Interested in Digital Design, VLSI, and Embedded Systems 
- **Aaditya Chauhan** – ECE Undergraduate, Interested in Digital Design, VLSI, and Embedded Systems
