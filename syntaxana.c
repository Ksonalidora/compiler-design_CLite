#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100

// Structure to represent a symbol table entry
typedef struct {
    char name[MAX_SIZE];
    int isDeclared;
} SymbolEntry;

// Symbol table to store variable declarations
SymbolEntry symbolTable[MAX_SIZE];
int symbolCount = 0;

// Function to add a variable to the symbol table
void addVariable(char *name) {
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].isDeclared = 1;
    symbolCount++;
}

// Function to check if a variable is declared
int isDeclared(char *name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            return symbolTable[i].isDeclared;
        }
    }
    return 0;
}

int main() {
    // Open the input file
    FILE *file = fopen("file.c", "r");
    if (file == NULL) {
        fprintf(stderr, "Error opening file\n");
        return 1;
    }

    // Read the file line by line
    char line[MAX_SIZE];
    while (fgets(line, sizeof(line), file)) {
        // Tokenize the line
        char *token = strtok(line, " \t\n");
        while (token != NULL) {
            if (strcmp(token, "int") == 0) {
                // Found a variable declaration
                token = strtok(NULL, " \t\n"); // Skip the next token (variable name)
                if (token != NULL) {
                    addVariable(token); // Add the variable to the symbol table
                }
            } else {
                // Check if the token is a variable usage
                if (isDeclared(token)) {
                    printf("%s is declared\n", token);
                } else {
                    printf("%s is not declared\n", token);
                }
            }
            token = strtok(NULL, " \t\n");
        }
    }

    // Close the file
    fclose(file);

    return 0;
}

