/*
Program	: CO224 Assembler
Author	: Isuru Nawinne
Date	: 14-April-2020

Description:

This program can be used to convert manually-written textual assembly programs into machine code for CO224 laboratory exercises 5 and 6.
(If you feel especially adventurous, you can write the programs in machine code itself by yourself! Too lazy for that? Then use this assembler!)

This simple assembler assumes an ISA containing the following instructions: loadi, mov, add, sub, and, or, j, beq, load, store. 
All instructions are encoded into 32-bit words based on the following format:

Bits 31-24 : OP-CODE		: Given as one of (loadi, mov, add, sub, and, or, j, beq, load, store)
Bits 16-23 : Destination Operand: Given as a register number (0-7), or an 8-bit memory address as an immediate value in hex (e.g. 0xFF)
Bits 08-15 : Source Operand 1	: Given as a register number (0-7)
Bits 00-07 : Source Operand 2	: Given as a register number (0-7), or an 8-bit memory address as an immediate value in hex (e.g. 0xFF)

This assembler will perform some basic error checks on your program. A valid instruction should contain two to four tokens separated by space character (e.g. "add 3 2 1", "load 5 0x1A", "j 0x0A"), corresponding to the details given above. In addition, empty lines and comments are permitted. A valid comment should start with "//".

NOTE	: You must define the op-codes assinged to instructions' opearations, to match the definitions in your instruction set architecture. 
	  Edit the relevant section below.

Compiling the program	: gcc CO224Assembler.c -o CO224Assembler
Using the assembler	: ./CO224Assembler <your_assembly_file_name> (e.g. ./CO224Assembler program.s)
Generated output file	: <your_assembly_file_name>.machine
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define LINE_SIZE 512


int main( int argc, char *argv[] )
{

	//OP-CODE DEIFINITIONS
	//Change these according to op-codes assigned in your processor architecture 
	
	char *op_loadi 	= "00100000";
	char *op_mov 	= "00101000";
	char *op_add 	= "00101001";
	char *op_sub 	= "00111001";
	char *op_and 	= "00101010";
	char *op_or 	= "00101011";

	char *op_j		= "00000000";
	char *op_beq	= "01011001";

	
	char *op_sll 	= "10100101";
	char *op_srl	= "00100101";
	char *op_sra	= "00100110";
	char *op_ror	= "00100111";
	char *op_bne	= "00011001";

	char *op_load 	= "10000001";
	char *op_store 	= "10001001";
	

	/************************************************************************/
	
	const char delim[] = " ";
	FILE *fi, *fo;
	char line[LINE_SIZE];
	long line_count = 0;
	char *in_token;
	char out_token[] = "00000000";
	char out_file[256];

	strcpy(out_file,argv[1]);
	strcat(out_file,".machine");

 	if ((fi = fopen(argv[1],"r")) == NULL){
		printf("Err0r: Cannot open source file!\n");
		exit(1);
	}

	if ((fo = fopen(out_file,"wb")) == NULL){
		printf("Error: Cannot open output file!\n");
		fclose(fi);
		exit(1);
	}

 	while(fgets(line, LINE_SIZE, fi)!=NULL) // Read a line from the input .s file
	{
		/* Preprocess the line and insert "X" for ignored fields where needed
		*************************************************************************/
		char pline[LINE_SIZE]="";
		char tline[LINE_SIZE];
		strcpy(tline,line);		
		in_token = strtok(tline, delim);// Read the first token	(if this is an instruction, first token is the operation)	
		// Only for valid instructions with two or three tokens (ignored SOURCE 1 and/or SOURCE 2 fields)
		if(strcasecmp(in_token,"mov")==0 || strcasecmp(in_token,"loadi")==0 || strcasecmp(in_token,"load")==0 || 
		strcasecmp(in_token,"store")==0 || strcasecmp(in_token,"j")==0) 
		{
			int j = (strcasecmp(in_token,"j")==0)?1:0; //Flag if this is a 'j'
			strcat(pline,in_token); strcat(pline,delim); // Write the operation to the pre-processed line, with a delimiter
			in_token = strtok(NULL, delim); // Read the second token (DESTINATION)
			strcat(pline,in_token); strcat(pline,delim);// Write DESTINATION to the pre-processed line, with a delimiter
			strcat(pline,"X "); // Write 'X' to the pre-processed line (for the ignored SOURCE 1), with a delimiter
			if(j) // If this is a 'j' instruction which has no SOURCE 2 field
				strcat(pline,"X"); // Write 'X' to the pre-processed line (for the ignored SOURCE 2)
			else // Otherwise
			{	
				in_token = strtok(NULL, delim); // Read the third token (SOURCE 2)
				strcat(pline,in_token);// Write SOURCE 2 to the pre-processed line
			}
			while(1)
			{
				in_token = strtok(NULL, delim);// Read any remaining token
				if(in_token != NULL)
				{
					strcat(pline,delim); strcat(pline,in_token); // Write any remaining tokens to the pre-processed line
				}
				else
					break;
			}strcat(pline,"");
		}
		else // The line is either not an instruction, or an instruction with all four tokens
			strcpy(pline,line);

		/* Encode the pre-processed line of assembly code into machine code
		*******************************************************************/
		in_token = strtok(pline, delim);
		line_count++;
		int count = 0;
		while(in_token!=NULL)
		{
			count++;

			// Encoding the op-code
			if(strcasecmp(in_token,"loadi")==0) strcpy(out_token, op_loadi);
			else if(strcasecmp(in_token,"mov")==0) strcpy(out_token, op_mov);
			else if(strcasecmp(in_token,"add")==0) strcpy(out_token, op_add);
			else if(strcasecmp(in_token,"sub")==0) strcpy(out_token, op_sub);
			else if(strcasecmp(in_token,"and")==0) strcpy(out_token, op_and);
			else if(strcasecmp(in_token,"or")==0) strcpy(out_token, op_or);
			else if(strcasecmp(in_token,"j")==0) strcpy(out_token, op_j);
			else if(strcasecmp(in_token,"beq")==0) strcpy(out_token, op_beq);
			else if(strcasecmp(in_token,"load")==0) strcpy(out_token, op_load);
			else if(strcasecmp(in_token,"store")==0) strcpy(out_token, op_store);
			else if(strcasecmp(in_token,"sll")==0) strcpy(out_token, op_sll);
			else if(strcasecmp(in_token,"srl")==0) strcpy(out_token, op_srl);
			else if(strcasecmp(in_token,"sra")==0) strcpy(out_token, op_sra);
			else if(strcasecmp(in_token,"ror")==0) strcpy(out_token, op_ror);
			else if(strcasecmp(in_token,"bne")==0) strcpy(out_token, op_bne);


			// Encoding register numbers
			else if(strcmp(in_token,"0")==0 || strcmp(in_token,"0\n")==0) strcpy(out_token, "00000000");
			else if(strcmp(in_token,"1")==0 || strcmp(in_token,"1\n")==0) strcpy(out_token, "00000001");
			else if(strcmp(in_token,"2")==0 || strcmp(in_token,"2\n")==0) strcpy(out_token, "00000010");
			else if(strcmp(in_token,"3")==0 || strcmp(in_token,"3\n")==0) strcpy(out_token, "00000011");
			else if(strcmp(in_token,"4")==0 || strcmp(in_token,"4\n")==0) strcpy(out_token, "00000100");
			else if(strcmp(in_token,"5")==0 || strcmp(in_token,"5\n")==0) strcpy(out_token, "00000101");
			else if(strcmp(in_token,"6")==0 || strcmp(in_token,"6\n")==0) strcpy(out_token, "00000110");
			else if(strcmp(in_token,"7")==0 || strcmp(in_token,"7\n")==0) strcpy(out_token, "00000111");

			// Encoding ignored operands
			else if(strcasecmp(in_token,"X")==0) strcpy(out_token, "00000000");

			// Encoding immediate values (must be in hex format)
			else if(strstr(in_token,"0x") && (strstr(in_token,"0x") == in_token))
			{
				int i;
				for(i=0;i<2;i++)
				{
					if(toupper(in_token[2+i])=='0') strcpy(out_token+(4*i), "0000");
					if(toupper(in_token[2+i])=='1') strcpy(out_token+(4*i), "0001");
					if(toupper(in_token[2+i])=='2') strcpy(out_token+(4*i), "0010");
					if(toupper(in_token[2+i])=='3') strcpy(out_token+(4*i), "0011");
					if(toupper(in_token[2+i])=='4') strcpy(out_token+(4*i), "0100");
					if(toupper(in_token[2+i])=='5') strcpy(out_token+(4*i), "0101");
					if(toupper(in_token[2+i])=='6') strcpy(out_token+(4*i), "0110");
					if(toupper(in_token[2+i])=='7') strcpy(out_token+(4*i), "0111");
					if(toupper(in_token[2+i])=='8') strcpy(out_token+(4*i), "1000");
					if(toupper(in_token[2+i])=='9') strcpy(out_token+(4*i), "1001");
					if(toupper(in_token[2+i])=='A') strcpy(out_token+(4*i), "1010");
					if(toupper(in_token[2+i])=='B') strcpy(out_token+(4*i), "1011");
					if(toupper(in_token[2+i])=='C') strcpy(out_token+(4*i), "1100");
					if(toupper(in_token[2+i])=='D') strcpy(out_token+(4*i), "1101");
					if(toupper(in_token[2+i])=='E') strcpy(out_token+(4*i), "1110");
					if(toupper(in_token[2+i])=='F') strcpy(out_token+(4*i), "1111");
				}
			}
		
			// Handling comments and empty lines
			else if(strcmp(in_token,"\n")==0||(strstr(in_token,"//") && (strstr(in_token,"//") == in_token))){
				count--;
				break;
			}
			// Handling lines/words which are not part of an instruction
			else
			{
				count = 99;
				break;
			}
			
			fputs(out_token, fo);			
			in_token = strtok(NULL, delim);
		}
		
		if(count==4) // Line contains a valid instruction
			fputs("\n", fo);
		else if(count!=0) // Line is neither a valid instruction, nor a valid comment / empty line
		{
			printf("Error: Incorrect instruction format! (line: %li)\n",line_count);
			fclose(fi);
			fclose(fo);
			exit(1);
		}

	}

	fclose(fi); 
	fclose(fo); 
  
	return 0;
}
