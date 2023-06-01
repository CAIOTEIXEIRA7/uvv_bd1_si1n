-- ALUNO: CAIO CHERUBINO TEIXEIRA
-- TURMA: SI1N

-- Excluir o banco de dados 

DROP DATABASE IF EXISTS uvv;

-- Apagar o usuário (caio)

DROP ROLE IF EXISTS caio;

-- Usuário com as permissões necessarias 

CREATE USER caio WITH ENCRYPTED PASSWORD '157'
CREATEDB
CREATEROLE;

-- Banco de Dados

CREATE DATABASE uvv WITH
OWNER=caio
ENCODING 'UTF8'
TEMPLATE template0
LC_CTYPE 'pt_BR.UTF-8'
LC_COLLATE 'pt_BR.UTF-8'
ALLOW_CONNECTIONS TRUE;

-- Conectar-se no Banco de dados

\c "dbname=uvv user=caio password=157"


-- Criando o Schema

CREATE SCHEMA lojas;
SET SEARCH_PATH TO lojas, "$user", public;

-- Alterando o user
 
ALTER USER caio
SET SEARCH_PATH TO lojas, "$user", public;


-- TABELA CLIENTES (CRIAÇÃO)

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE clientes IS 'Tabela dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Identificação do cliente';
COMMENT ON COLUMN clientes.email IS 'Email do cliente';
COMMENT ON COLUMN clientes.nome IS 'Nome do Cliente.';
COMMENT ON COLUMN clientes.telefone1 IS 'Telefone principal do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'Telefone secundario';
COMMENT ON COLUMN clientes.telefone3 IS 'Telefone terciario';


-- TABELA ENVIOS (CRIAÇÃO)

CREATE TABLE Envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios IS 'Tabela dos envios';
COMMENT ON COLUMN envios.envio_id IS 'Identificação dos envio';
COMMENT ON COLUMN envios.loja_id IS 'Identificação da loja ';
COMMENT ON COLUMN envios.cliente_id IS 'Identificação do cliente';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço de entrega.';
COMMENT ON COLUMN envios.status IS 'Status do Envio.';

-- TABELA PEDIDOS (CRIAÇÃO)

CREATE TABLE Pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS 'Tabela pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Identificação do pedido';
COMMENT ON COLUMN pedidos.data_hora IS 'Horario e Data do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'Identificação do cliente';
COMMENT ON COLUMN pedidos.status IS 'Status do pedido.';
COMMENT ON COLUMN pedidos.loja_id IS 'Identificação do pedido';


-- TABELA LOJAS (CRIAÇÃO)

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas IS 'Tabela das lojas';
COMMENT ON COLUMN lojas.loja_id IS 'Identificação da loja';
COMMENT ON COLUMN lojas.nome IS 'Nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'Endereço web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Endereço físico da loja';
COMMENT ON COLUMN lojas.latitude IS 'Latitude loja';
COMMENT ON COLUMN lojas.longitude IS 'Longitude loja';
COMMENT ON COLUMN lojas.logo IS 'Logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Mimetype da logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivo da logo.';
COMMENT ON COLUMN lojas.logo_charset IS 'CHARSET da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo';


-- TABELA PRODUTOS (CRIAÇÃO)

CREATE TABLE Produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos IS 'Tabela de produtos';
COMMENT ON COLUMN produtos.produto_id IS 'Identificação dos produtos';
COMMENT ON COLUMN produtos.nome IS 'Nome do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'Imagens do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'MimeType da imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquiva da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'Charset da imagem' ;
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Data da última atualização do produto';


-- TABELA ESTOQUES (CRIAÇÃO)

CREATE TABLE Estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE Estoques IS 'Tabela dos estoques';
COMMENT ON COLUMN Estoques.estoque_id IS 'Identificação do estoque';
COMMENT ON COLUMN Estoques.loja_id IS 'Identificação da loja';
COMMENT ON COLUMN Estoques.quantidade IS 'Quantidade do produto em estoque';
COMMENT ON COLUMN Estoques.produto_id IS 'Identificação do produto';

-- TABELA PEDIDOS_ITENS (CRIAÇÃO)

CREATE TABLE pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (produto_id, pedido_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabelas do Itens pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Identificação do produto';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Identificação do pedido';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Numero da linha dos pedidos';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Preço unitario do produto';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Identificação dos envios';

--PK E FK

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Costraints de checagem

ALTER TABLE pedidos 
ADD CONSTRAINT verificacao_pedidos
CHECK (status IN ('COMPLETO', 'ABERTO', 'CANCELADO', 'PAGO', 'ENVIADO', 'REEMBOLSADO'));

ALTER TABLE envios
ADD CONSTRAINT verificacao_envios
CHECK (status IN ('ENTREGUE', 'CRIADO', 'TRANSITO', 'ENVIADO'));

ALTER TABLE lojas
ADD CONSTRAINT verificacao_enderecos
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));


