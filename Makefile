FLEX=flex
CC=gcc
CFLAGS=
LIBS=

PROGRAMA = lexico
LEXICO = lexico.l

$(PROGRAMA): $(LEXICO)
	$(FLEX) $(LEXICO)
	$(CC) lex.yy.c $(LIBS) -o $(PROGRAMA)

executa_lexico:
	lexico < testes/teste_01.c > saidas/t01.txt
	lexico < testes/teste_02.c > saidas/t02.txt
	lexico < testes/teste_03.c > saidas/t03.txt
	lexico < testes/teste_04.c > saidas/t04.txt
	lexico < testes/teste_05.c > saidas/t05.txt
	lexico < testes/teste_06.c > saidas/t06.txt
	lexico < testes/teste_07.c > saidas/t07.txt
	lexico < testes/teste_08.c > saidas/t08.txt
	lexico < testes/teste_09.c > saidas/t09.txt
	lexico < testes/teste_10.c > saidas/t10.txt

compara_saidas:
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t01.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_01.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t02.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_02.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t03.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_03.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t04.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_04.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t05.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_05.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t06.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_06.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t07.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_07.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t08.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_08.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t09.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_09.c.txt
	fc d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas\t10.txt d:\Arquivos\OneDrive\Documentos\allan\atividades\compiladores\lexico\saidas_padrao\saida_teste_10.c.txt

clean:
	rm -f lex.yy.c
	rm -f lexico.exe lexico

