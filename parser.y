/*
 * Copyright 2012 Google Inc. All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
%token QUOTED UNQUOTED
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "y.tab.h"

int indent = 0;
void yyerror(const char *);

void
prefix()
{
	printf("%*s", indent * 2, "");
}

extern int lineno;
extern FILE *yyin;
extern char *yytext;
%}
%%
protobufs	: protobuf | protobuf protobufs;
protobuf	: key ':' { printf(": "); } message
		| key { printf(" "); } message;
key		: UNQUOTED { prefix(); printf("%s", yytext); };
scalar		: QUOTED | UNQUOTED;
message		: '{' { indent++; printf("{\n"); } protobufs
		  '}' { indent--; prefix(); printf("}\n"); }
                | '<' { indent++; printf("<\n"); } protobufs
		  '>' { indent--; prefix(); printf(">\n"); }
                | '{' '}' { printf("{ }\n"); }
                | '<' '>' { printf("< >\n"); }
		| scalar { printf("%s\n", yytext); }
;
%%

char *filename = "(stdin)";

void
yyerror(const char *message)
{
	fprintf(stderr, "%s:%d:Error: %s (%s).\n", filename, lineno, message, yytext);
	exit(EXIT_FAILURE);
}

int
main(int argc, char *argv[])
{

	if (argc > 2) {
		perror("Usage: pbpp [file].");
		return(EXIT_FAILURE);
	}
	if (argc > 1 && strcmp(argv[1], "-") != 0) {
		filename = argv[1];
		yyin = fopen(filename, "r");
		if (yyin == NULL) {
			fprintf(stderr, "Couldn't open %s\n", filename);
			return(EXIT_FAILURE);
		}
	}
	yyparse();
	return(EXIT_SUCCESS);
}
