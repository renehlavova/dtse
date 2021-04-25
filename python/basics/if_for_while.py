# IF

a = 200
b = 10

if b > a:
	print("b is greater than a")
elif b == a:
	print("a and b are equal")
else:
	print("a is greater than b")

if a > b: print("a is greater than b")

print("A") if a > b else print("B")

print("A") if a > b else print("=") if a == b else print("B")


# WHILE

i = 5
while i < 5:
	print(i)
	i += 1

i = 1
while i < 6:
	print(i)
	if i == 3:
		break  # will stop the loop even if the while condition is true
	i += 1

i = 0
while i < 6:
	i += 1
	if i == 3:
		continue  # will stop the current iteration and continue with the new one
	print(i)


# FOR

for x in "banana":
	print(x)


fruits_2 = ["apple", "banana", "cherry"]

for i in fruits_2:
	print(i)
	if i == "banana":
		break

for i in fruits_2:
	if i == "banana":
		break
	print(i)

for i in range(6): ## range 0-5
	print(i)

for i in range(2, 30, 3):
	print(i)
else: 
	print("Finally finished!")


x = {'Christopher Brooks': 'brooksch@umich.edu', 'Bill Gates': 'billg@microsoft.com'}

for name in x:
	print(x[name])

for email in x.values():
	print(email)

for name, email in x.items():
	print(name)
	print(email)

