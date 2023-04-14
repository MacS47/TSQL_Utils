/********************************************************************************************
SITUAÇÂO:
	Pode ser utilizada em qualquer situação que se deseje enviar um e-mail com o corpo em HTML
	considerando que se deseja encaminhar dados extraídos via SQL, a partir do banco de dados
	SQL Server. Cabe ressaltar que o ideal é converter o resultado da query em uma tabela no 
	HTML.

OBJETIVO:
    Enviar e-mail a partir do SQL Server, utilizando contas de SMTP pré-cadastradas. Lembre-se
	a conta já deve ter sido cadastrada.

HISTÓRICO
    01/01/2023 - Alexsandre Macaulay

*********************************************************************************************/

-- Declarando variável
DECLARE @HTML  NVARCHAR(MAX),

-- Atribuindo valor à variável  
SET @HTML =  
    N'<style>
		/* Informe aqui o seu código de estilo */
	  </style>
	<body>
	 <table>
        <thead>
            <tr>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th></th>
                <th></th>
                <th></th>
            </tr>
	'+
-- Início da conversão do resultado da query em bloco XML
CAST(
            (
            SELECT      TD = [COLUNA_1], '',
                        TD = [COLUNA_2], '',
                        TD = [COLUNA_3]
              FROM      [NOME_DATABASE].[dbo].[NOME_TABELA]

			-- Ao final de cada linha trazida pelo SELECT, a função CAST realiza o empacotamento
			-- do conteúdo em XML, colocando os valores entre <tr> </tr> (table row tag)
            FOR XML PATH('tr'), TYPE
            )
            AS NVARCHAR(MAX)
      ) +
            
        N'</tbody>
        <tfoot>
            <tr>
                <th class="fim" colspan=3>Equipe BI Paquetá</th>
            </tr>
        </tfoot>
    </table>
</body>';

-- Início da execução do PROCEDURE responsável por enviar e-mails
BEGIN
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Nome_Perfil_Cadastrado',
		@recipients='nome.destinatario@gmail.com',  
		@subject = 'Assunto do E-mail',  
		@body = @HTML,	-- Dados armazenados na variável
		@body_format = 'HTML' -- Formato do e-mail enviado. Existe a possibilidade de ser 
							  -- encaminhdo no formato de texto. Maiores detalhes vide 
							  -- documentação oficial da Microsoft
-- Fim do bloco de código
END
