# Strings

a = " Hello, World "
print(a.strip())
print(len(a))
print(a.lower())
print(a.upper())
print(a.replace("H", "J"))
print(a.split(","))

# Lists

list = ["apple", "banana", "cherry"]

list[1] = "strawberry"

for i in list:
	print(i)

if "apple" in list:
	print("Yes, apple is in this list.")

print(len(list))

list.append("orange")
print(list)

list.insert(1, "orange")
print(list)

list.remove("banana")
print(list)

list.pop()
print(list)

del list[0]
print(list)

list.clear()

# all methods for lists: append(), clear(), copy(), count(), extend(),
# index(), insert(), pop(), remove(), reverse(), sort()


# Tuples

tuple = ("apple", "banana", "cherry")

for i in tuple:
	print(i)

if "apple" in tuple:
	print("Yes, apple is in this tuple.")

print(len(tuple))

# all methods for tuples: count(), index()


# Sets

set = {"apple", "banana", "cherry"}

for i in set:
	print(i)

print("banana" in set)

set.add("orange")
print(set)

set.update(["orange", "mango", "grapes"])
print(set)

print(len(set))

set.remove("banana") # will raise an error if banana not present
print(set)

set.discard("banana") # will NOT raise an error if banana not present
print(set)

set.pop() # sets are unordered, so we do not know what is deleted
print(set) 

set.clear()

del set

# all methods for sets: add(), clear(), copy(), difference(), difference_update(),
# discard(), intersection(), intersection_update(), isdisjoint(), issubset(),
# issuperset(), pop(), remove(), symmetric_difference(), symmetric_difference_update(),
# union(), update()


# Dictionaries

dict = {"brand": "Ford",
		"model": "Mustang",
		"year": 1964}

print(dict)

print(dict["model"])

print(dict.get("model"))

dict["year"] = 2018

for i in dict:
	print(i)

for i in dict:
	print(dict[i])

for i in dict.values():
	print(i)

for x, y in dict.items():
	print(x, y)

if "model" in dict:
	print("Yes, model is in this dictionary.")

print(len(dict))

dict["color"] = "red"

dict.pop("model")

dict.popitem()

del dict["model"]

dict.clear()

# all methods for dict: clear(), copy(), fromkeys(), get(), items(), keys(),
# pop(), popitem(), setdefault(), update(), values()