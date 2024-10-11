import numpy as np
import matplotlib.pyplot as plt
from time import time

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def sigmoid_approx_linear(x):
    return np.clip((x + 1) / 2, 0, 1)

def sigmoid_approx_poly(x):
    return 0.5 + 0.197 * x - 0.004 * x**3

def relu(x):
    return np.maximum(0, x)

# Generate 1 million points between -5 and 5 as float32
num_points_calc = 1000000
x_calc = np.linspace(-5, 5, num_points_calc, dtype=np.float32)

functions = [
    ("Sigmoid Original", sigmoid),
    ("Linear Approximation", sigmoid_approx_linear),
    ("Polynomial Approximation", sigmoid_approx_poly),
    ("ReLU", relu)
]

print(f"Calculating for {num_points_calc:,} elements with NumPy (repeated 10,000 times), please wait...\n")

results = []
num_repeats = 100000  # Number of times to repeat the calculation

for name, func in functions:
    start = time()

    # Repeat the calculation num_repeats times
    for _ in range(num_repeats):
        y = func(x_calc)  

    end = time()
    calculation_time = end - start


    # Write results to file only once after calculation
    start_writing = time()
    with open("results.txt", "w") as f:
        for i in range(num_points_calc):
            # Format the output as requested
            f.write(f"x={x_calc[i]:.6f}, e^x={y[i]:.20f}\n") 
    end_writing = time()
    writing_time = end_writing - start_writing
    
    total_time = calculation_time + writing_time

    results.append((name, total_time, y))

    # Calculate MSE for non-original functions
    if name != "Sigmoid Original":
        y_true = sigmoid(x_calc)
        mse = np.mean((y_true - y) ** 2)
        print(f"{name} - Time: {total_time:.6f} s - Error (MSE): {mse:.6f}")
    else:
        print(f"{name} - Time: {total_time:.6f} s")

# Visualization: Downsample to 1000 points for plotting
num_points_plot = 1000
x_plot = np.linspace(-5, 5, num_points_plot)

plt.figure(figsize=(12, 6))
for name, execution_time, y in results:
    # Interpolate the calculated y-values to match the plotting x-values
    y_plot = np.interp(x_plot, x_calc, y) 
    plt.plot(x_plot, y_plot, label=f"{name} ({execution_time:.6f} s)")

plt.legend()
plt.title("Comparison of Activation Functions")
plt.xlabel("x")
plt.ylabel("y")
plt.show()



