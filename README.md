# Smart Roads and Traffic Simulation using SUMO & MATLAB

## Overview
This project focuses on modeling and analyzing urban traffic flow using SUMO (Simulation of Urban Mobility) and MATLAB. The objective is to study traffic dynamics, identify bottlenecks, and evaluate the relationship between speed, flow, and density under different traffic conditions.

## Objective
- Simulate urban traffic under varying flow conditions (low, medium, high)
- Analyze traffic parameters such as speed, flow, and density
- Identify congestion patterns and bottlenecks in road networks

## Tools & Technologies
- SUMO (Simulation of Urban Mobility)
- MATLAB
- TraCI (Traffic Control Interface)

## Traffic Network Design
- Multi-section road network with lane transitions:
  - 3-lane upstream section → 2-lane downstream section  
- Junctions:
  - Zipper junction for smooth merging  
  - Priority junction for downstream flow  
- Road sections divided into 4 segments for analysis :contentReference[oaicite:1]{index=1}  

## Traffic Simulation Setup

### Traffic Flow Scenarios
- Low Flow (moderate density)
- Medium Flow (high density)
- High Flow (congested conditions)

Traffic density controlled using probability-based vehicle generation.

### Vehicle Models
- Multiple vehicle types with varying speed and acceleration
- Car-following model: Krauss

## Data Collection

- Used **E1 detectors (induction loops)** placed across the network  
- Measured:
  - Vehicle count  
  - Speed  
  - Occupancy  

- Data collected at:
  - Upstream  
  - Midstream  
  - Downstream sections :contentReference[oaicite:2]{index=2}  

## Methodology

### Simulation Execution
- Simulation time: **3600 seconds (1 hour)**  
- Data aggregation interval: **5 minutes**  
- Controlled using MATLAB via TraCI interface  

### Data Processing
- Extracted traffic metrics from SUMO  
- Computed:
  - Mean speed  
  - Harmonic mean speed  
  - Traffic flow (vehicles/hour)  
  - Vehicle density (vehicles/km)  

### Analysis
- Compared traffic behavior across different flow scenarios  
- Identified congestion zones and bottlenecks  
- Evaluated relationships between:
  - Speed vs Density  
  - Flow vs Density  

## Results
- Traffic flow increases until reaching maximum capacity, after which congestion occurs  
- Lane reduction (3 → 2 lanes) creates bottlenecks  
- High-density scenarios lead to reduced speed and increased congestion  
- Visualization clearly shows transition from free-flow to congested conditions  

## Key Features
- Realistic traffic simulation using SUMO  
- Integration with MATLAB for advanced analysis  
- Multi-scenario evaluation (low to high traffic density)  
- Data-driven insights into traffic dynamics  

## Applications
- Smart city traffic management  
- Autonomous vehicle simulation environments  
- Traffic planning and infrastructure optimization  

## Future Work
- Integration with real-time traffic data  
- Implementation of adaptive traffic control strategies  
- Extension to multi-intersection urban networks  

## Author
Sudip Kishan Sarker  
MSc Autonomous Vehicle Engineering  
University of Naples Federico II
