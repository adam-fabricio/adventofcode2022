#!/bin/bash

# Declare an array to store the valve flow rate values
declare -A flow_rates
flow_rates=([AA]=0 [BB]=13 [CC]=2 [DD]=20 [EE]=3 [FF]=0 [GG]=0 [HH]=22 [II]=0 [JJ]=21)

# Declare an associative array to store the tunnels between valves
declare -A tunnels
tunnels=([AA]="DD II BB" [BB]="CC AA" [CC]="DD BB" [DD]="CC AA EE" [EE]="FF DD" [FF]="EE GG" [GG]="FF HH" [HH]="GG" [II]="AA JJ" [JJ]="II")

# Function to get the maximum flow rate of all the valves
function get_max_flow_rate {
  local current_valve=$1
  local current_flow_rate=$2
  local max_flow_rate=$3

  # If the current flow rate is greater than the maximum flow rate
  if ((current_flow_rate > max_flow_rate)); then
    max_flow_rate=$current_flow_rate
  fi

  # Get the list of valves connected to the current valve
  local connected_valves=($(echo ${tunnels[$current_valve]}))

  # Loop through the connected valves
  for valve in "${connected_valves[@]}"; do
    # Get the flow rate of the connected valve
    local valve_flow_rate=${flow_rates[$valve]}

    # Recursively call the function with the connected valve and its flow rate
    max_flow_rate=$(get_max_flow_rate $valve $(($current_flow_rate + $valve_flow_rate)) $max_flow_rate)
  done

  # Return the maximum flow rate
  echo $max_flow_rate
}

# Call the function to get the maximum flow rate starting from valve AA
max_flow_rate=$(get_max_flow_rate AA ${flow_rates[AA]} 0)

# Print the maximum flow rate
echo "The maximum flow rate is: $max_flow_rate"

