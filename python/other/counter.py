import collections

wordlist = []
text = input()

for line in text.split():
    word = ""
    for letter in line:
        if letter.isalpha():
            word += letter
    word.islower()
    wordlist.append(word)
print(collections.Counter(wordlist))