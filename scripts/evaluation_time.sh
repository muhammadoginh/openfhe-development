#!/bin/bash


# Output file
output_file="ckks_operations_output.txt"
# output_file="bfv_operations_output.txt"
# output_file="bgv_operations_output.txt"

# Clear the output file
> $output_file

# Execute the program 30 times and save the output to the file
for ((i = 1; i <= 30; i++)); do
    echo "Execution $i:" >> $output_file
    ./bin/examples/pke/simple-ckks >> $output_file
    # ./bin/examples/pke/simple-bfv >> $output_file
    # ./bin/examples/pke/simple-bgv >> $output_file
    echo "-------------------------------------------" >> $output_file
done

echo "Results saved to $output_file"

# Calculate average time for each operation
echo "Calculating average times..."

# Function to extract times for each operation
extract_time() {
    operation="$1"
    awk -v op="$operation" '$0 ~ op {print $(NF-1)}' $output_file
}


# Addition
add_times=($(extract_time "addition"))
add_total=0
if [ ${#add_times[@]} -gt 0 ]; then
    for time in "${add_times[@]}"; do
        add_total=$(echo "scale=4; $add_total + $time" | bc)  # Perform floating-point addition
    done
    add_avg=$(echo "scale=4; $add_total / ${#add_times[@]}" | bc)  # Perform floating-point division
    add_avg_rounded=$(printf "%.2f" $add_avg)  # Round to two decimal places
    echo "Average time for addition: $add_avg_rounded nanoseconds"
else
    echo "No times extracted for addition."
fi

# Subtraction
sub_times=($(extract_time "subtraction"))
sub_total=0
if [ ${#sub_times[@]} -gt 0 ]; then
    for time in "${sub_times[@]}"; do
        sub_total=$(echo "scale=4; $sub_total + $time" | bc)  # Perform floating-point addition
    done
    sub_avg=$(echo "scale=4; $sub_total / ${#sub_times[@]}" | bc)  # Perform floating-point division
    sub_avg_rounded=$(printf "%.2f" $sub_avg)  # Round to two decimal places
    echo "Average time for subtraction: $sub_avg_rounded nanoseconds"
else
    echo "No times extracted for subtraction."
fi

# Multiplication
mul_times=($(extract_time "multiplication"))
mul_total=0
if [ ${#mul_times[@]} -gt 0 ]; then
    for time in "${mul_times[@]}"; do
        mul_total=$(echo "scale=4; $mul_total + $time" | bc)  # Perform floating-point addition
    done
    mul_avg=$(echo "scale=4; $mul_total / ${#mul_times[@]}" | bc)  # Perform floating-point division
    mul_avg_rounded=$(printf "%.2f" $mul_avg)  # Round to two decimal places
    echo "Average time for multiplication: $mul_avg_rounded nanoseconds"
else
    echo "No times extracted for multiplication."
fi

# Make sure to give execute permission to the script:
# chmod +x run_script.sh
# run the script:
# ./run_script.sh
