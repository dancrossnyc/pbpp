# Copyright 2012 Google Inc. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

YFLAGS=		-d
PROG=		pbpp
OBJS=		lexer.o parser.o
LIBS=		-ly -ll

$(PROG):	$(OBJS)
		$(CC) -o $(PROG) $(OBJS) $(LIBS)

lexer.o:	parser.o

test:		$(PROG)
		./$(PROG) < test.data | diff - test.expected

clean:
		rm -f $(PROG) $(OBJS) y.tab.h
