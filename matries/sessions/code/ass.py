print("Welcome to the Simple Calculator!")
print("Select an operation:")
print("1. Addition (+)")
print("2. Subtraction (-)")
print("3. Multiplication (*)")
print("4. Division (/)")

while True:
    choice = input("Enter your choice (1/2/3/4) or 'exit' to quit: ")

    if choice == 'exit':
        print("Exiting the calculator")
        break

    if choice not in ['1', '2', '3', '4']:
        print("Invalid input. Please enter 1, 2, 3, 4 or 'exit'.")
        continue

    try:
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
    except ValueError:
        print("Invalid input. Please enter numeric values.")
        continue

    if choice == '1':
        result = num1 + num2
        print(f"{num1} + {num2} = {result}")
    elif choice == '2':
        result = num1 - num2
        print(f"{num1} - {num2} = {result}")
    elif choice == '3':
        result = num1 * num2
        print(f"{num1} * {num2} = {result}")
    elif choice == '4':
        if num2 == 0:
            print("Error: Cannot divide by zero.")
            continue
        result = num1 / num2
        print(f"{num1} / {num2} = {result}")
