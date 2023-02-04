#ifndef __METEO_H_
#define __METEO_H_

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <limits.h>

#define RAM 100000
#define MEMORY_ERR() fprintf(stderr, "Malloc error\n")
#define ERROR(format, args) fprintf(stderr, format, args)
#define ERROR_MSG(format) fprintf(stderr, format)


typedef struct data_s {
    char **value;
    double key;
    int nb;
} data_t;

typedef struct external_s {
    FILE *file;
    char filename[10];
    int index;
    char *value;
    double key;
    int empty;
    int nb;
} external_t;

typedef struct options_s {
    FILE *input;
    FILE *output;
    int (*f)(FILE  *file, char buffer[RAM], int reverse);
    int reverse;
} options_t;

typedef struct function_pointer_s {
    const char *name;
    int (*f)(FILE  *file, char buffer[RAM], int reverse);
} function_pointer_t;

typedef struct linked_list_s {
    data_t *data;
    struct linked_list_s *next;
} linked_list_t;

typedef struct avl_node_s {
	struct avl_node_s *left;
	struct avl_node_s *right;
    data_t *data;
} avl_node_t;

typedef struct avl_tree_s {
	struct avl_node_s *root;
} avl_tree_t;



void free_options(options_t *options);
int functions_contains(function_pointer_t **functions, const char *key);
void free_functions(function_pointer_t **functions);
function_pointer_t **get_functions(int nb, ...);

int merge_sort(options_t *options);
int sort_files(external_t **files, options_t *options);
external_t **create_files(int file_nb);
void free_files(external_t **files);

int add_to_array(char ***array, char *msg);
void free_array(char **array);

int list(FILE *file, char buffer[RAM], int reverse);
void list_save(linked_list_t *list, FILE *f);

double str_to_double(double *result, const char* str);
data_t *create_data(double key, char *value);
int compare(double a, double b, int reverse);

int avl(FILE *file, char buffer[RAM], int reverse);
int abr(FILE *file, char buffer[RAM], int reverse);



#endif
