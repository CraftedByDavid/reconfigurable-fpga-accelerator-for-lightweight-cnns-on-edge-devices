# Reconfigurable FPGA Accelerator for Lightweight CNNs on Edge Devices

## 📌 Overview
This project presents a **reconfigurable FPGA-based hardware accelerator** designed to accelerate key operations in lightweight convolutional neural networks (CNNs), targeting real-time inference on edge devices.

The accelerator supports **highly parallel computation**, efficient **on-chip memory usage**, and **INT8 quantized processing**, making it suitable for resource-constrained environments.

---

## 🎯 Objectives
- Accelerate convolution and pooling operations on FPGA  
- Enable efficient execution of lightweight CNN models  
- Optimize latency and throughput using parallel architecture  
- Utilize on-chip memory to reduce external memory dependency  

---

## 🧠 Architecture Overview
The hardware accelerator is designed to support:

- **Convolution** (Standard and Depthwise)
- **Max Pooling**
- **Optional ReLU Activation**

The architecture leverages a **lane-based parallel design** and **on-chip BRAM** for high-performance computation.

---

## 🧩 Block Diagram

The following block diagram illustrates the overall architecture of the accelerator, including memory units, compute engine, and control logic.

<p align="center">
  <img src="images/block_diagram.png" alt="FPGA CNN Accelerator Block Diagram" width="700"/>
</p>

### 🔍 Description
The architecture consists of:

- **Input BRAM**: Stores input feature maps (INT8, 128-bit width)  
- **Kernel BRAM**: Stores convolution weights  
- **Convolution Engine**: 16-lane parallel MAC-based compute unit  
- **Activation Unit**: Optional ReLU operation  
- **Pooling Unit**: Max pooling support  
- **Output BRAM**: Stores computed feature maps  
- **Control Unit**: Manages data flow and configuration  

---

## ⚙️ Memory Architecture

All data is stored in **on-chip BRAM**, minimizing latency and improving performance.

- **Memory Width:** 128 bits  
- **Memory Depth:** 1024  
- **Data Type:** INT8 (quantized activations and weights)

Since each value is **8 bits**, a single 128-bit word can store:

👉 **16 values simultaneously (16 parallel lanes)**

---

## 🚀 Parallel Processing (Lane-Based Design)

The accelerator uses a **16-lane parallel architecture**.

### Data Layout:
