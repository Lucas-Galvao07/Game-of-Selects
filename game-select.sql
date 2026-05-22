DROP DATABASE IF EXISTS game;
create database IF NOT EXISTS game;
use game;

CREATE TABLE batalha (
    id_batalha INT PRIMARY KEY AUTO_INCREMENT,
    local_batalha VARCHAR(100),
    data_batalha DATE
);

CREATE TABLE artefato (
    id_artefato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dano INT,
    tipo VARCHAR(50)
);

CREATE TABLE reino (
    id_reino INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    populacao INT
);

CREATE TABLE mar (
    id_mar INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE magia (
    id_magia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dano INT,
    elemento VARCHAR(50)
);

CREATE TABLE treinamento (
    id_treinamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    duracao_meses INT,
    dificuldade INT,
    data_inicio DATE
);

CREATE TABLE galaxia (
    id_galaxia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE planeta (
    id_planeta INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    populacao INT,
    galaxia_id_galaxia INT,
    FOREIGN KEY (galaxia_id_galaxia) REFERENCES galaxia(id_galaxia)
);

CREATE TABLE personagem (
    id_personagem INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dtNasc DATETIME,
    raca VARCHAR(50),
    data_nascimento DATE,
    stats_vida TINYINT(1),
    mar_id_navio INT,
    galaxia_id_galaxia INT,
    reino_id_reino INT,
    FOREIGN KEY (mar_id_navio) REFERENCES mar(id_mar),
    FOREIGN KEY (galaxia_id_galaxia) REFERENCES galaxia(id_galaxia),
    FOREIGN KEY (reino_id_reino) REFERENCES reino(id_reino)
);

CREATE TABLE tesouro (
    id_tesouro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    valor DECIMAL(10,2),
    fkPersonagem INT,
    FOREIGN KEY (fkPersonagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE inventario (
    id_personagem INT,
    id_arma INT,
    data_obtencao DATE,
    PRIMARY KEY (id_personagem, id_arma),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE embate (
    id_batalha INT,
    fkPersonagem_A INT,
    fkPersonagem_B INT,
    venceu TINYINT(1),
    PRIMARY KEY (id_batalha, fkPersonagem_A, fkPersonagem_B),
    FOREIGN KEY (id_batalha) REFERENCES batalha(id_batalha),
    FOREIGN KEY (fkPersonagem_A) REFERENCES personagem(id_personagem),
    FOREIGN KEY (fkPersonagem_B) REFERENCES personagem(id_personagem)
);

CREATE TABLE personagem_magia (
    id_personagem INT,
    id_magia INT,
    nivel_magia INT,
    PRIMARY KEY (id_personagem, id_magia),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (id_magia) REFERENCES magia(id_magia)
);

CREATE TABLE objetivo (
    id_personagem INT,
    id_treinamento INT,
    licao VARCHAR(300),
    PRIMARY KEY (id_personagem, id_treinamento),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (id_treinamento) REFERENCES treinamento(id_treinamento)
);

CREATE TABLE poder (
    idpoder INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    personagem_id_personagem INT,
    FOREIGN KEY (personagem_id_personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE relacionamento (
    personagem_id_personagem INT,
    personagem_id_personagem1 INT,
    relacao VARCHAR(45),
    PRIMARY KEY (personagem_id_personagem, personagem_id_personagem1),
    FOREIGN KEY (personagem_id_personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (personagem_id_personagem1) REFERENCES personagem(id_personagem)
);

INSERT INTO galaxia (id_galaxia, nome) VALUES
(1, 'C-137'),
(2, 'Galáxia da Bruxa');

INSERT INTO reino (id_reino, nome, populacao) VALUES
(1, 'Vila Distante', 500);

INSERT INTO mar (id_mar, nome) VALUES
(1, 'Mar da Costa do Marfim');

INSERT INTO treinamento (id_treinamento, nome, duracao_meses, dificuldade, data_inicio) VALUES
(1, 'Desenvolvimento Socioemocional', 3, 2, '1994-01-01'),
(2, 'Meditação Profunda e Artes Marciais', 12, 4, '1994-04-01');


INSERT INTO magia (id_magia, nome, dano, elemento) VALUES
(1, 'Maldição de sono', 0, 'Hipnose'),
(2, 'Tempestade Mágica', 90, 'Água'),
(3, 'Demônios', 70, 'Ilusão'),
(4, 'Encantamento', 50, 'Psicologico');


INSERT INTO artefato (id_artefato, nome, dano, tipo) VALUES
(1, 'Espada Mágica', 95, 'Arma'),
(2, 'Faca', 80, 'Arma'),
(3, 'Porta Retrato Marrom', 0, 'Item');

INSERT INTO personagem (id_personagem, nome, dtNasc, raca, data_nascimento, stats_vida, mar_id_navio, galaxia_id_galaxia, reino_id_reino) VALUES
(1, 'Yuri Pardinho','1970-01-01 22:00:00', 'Humano','2000-06-10', 1, 1, 1, 1),
(2, 'Nicki Minaj','1950-01-01 00:00:00', 'Bruxa', '1978-01-01', 0, NULL, 2, 1),
(3, 'Ademir','1940-01-01 10:00:00', 'Humano', '1975-03-20', 0, NULL, 1, 1),
(4, 'Zara', '1980-01-01 09:45:00', 'Fada','2000-09-25', 1, NULL, 1, 1),
(5, 'Cirilo','1955-01-01 02:30:00', 'Humano','1955-10-10', 0, 1, 1, 1),
(6, 'Marisa Monte','1965-01-01 09:22:00', 'Sereia', '2000-01-01', 1, NULL, 1, 1),
(7, 'Jim Mori','1945-01-01 17:10:00', 'Monge-Samurai','1955-12-28', 1, NULL, 1, 1),
(8, 'Rick Sanchez','1948-01-01 12:20:00', 'Humano Intergalático','1948-07-07', 0, NULL, 1, 1);

INSERT INTO tesouro (id_tesouro, nome, valor, fkPersonagem) VALUES
(1, 'Tesouro de Ademir', 999999.99, 3);

INSERT INTO inventario (id_personagem, id_arma, data_obtencao) VALUES
(1, 2, '2040-06-01'),
(8, 1, '2040-06-01');

INSERT INTO personagem_magia (id_personagem, id_magia, nivel_magia) VALUES
(2, 1, 10),
(2, 2, 9),
(2, 3, 8),
(2, 4, 7);


INSERT INTO magia (id_magia, nome, dano, elemento) VALUES
(5, 'Meditação Profunda', 60, 'Espiritual'),
(6, 'Inteligência Socioemocional', 55, 'Mental');

INSERT INTO personagem_magia (id_personagem, id_magia, nivel_magia) VALUES
(1, 5, 8),
(1, 6, 9);

INSERT INTO batalha (id_batalha, local_batalha, data_batalha) VALUES
(1, 'Vila Distante','2039-05-01'),
(2, 'Mar', '2040-03-01'),
(3, 'Casa de Ademir no Japão','2040-06-29'), 
(4, 'Fortaleza da Bruxa','2040-06-31');

INSERT INTO embate (id_batalha, fkPersonagem_A, fkPersonagem_B, venceu) VALUES
(1, 3, 2, 0), 
(2, 5, 2, 0),
(3, 1, 2, 1),
(4, 1, 2, 1); 

INSERT INTO objetivo (id_personagem, id_treinamento, licao) VALUES
(1, 1, 'Desenvolver resiliência e confiança com a sereia'),
(1, 2, 'Alcançar a iluminação e aprender artes marciais com o samurai');

INSERT INTO poder (idpoder, nome, personagem_id_personagem) VALUES
(1, 'Feitiçaria', 2),  
(2, 'Tempestade', 2),  
(3, 'Experiência Marítima', 5),  
(4, 'Cura e Comunicação', 6),  
(5, 'Meditação e Iluminação', 7), 
(6, 'Viagem Multiversal', 8), 
(7, 'Resiliência Socioemocional', 1), 
(8, 'Meditação Profunda', 1);  

INSERT INTO relacionamento (personagem_id_personagem, personagem_id_personagem1, relacao) VALUES
(1, 3, 'Filho'),          
(1, 5, 'Companheiro'),    
(1, 6, 'Aprendiz'),       
(1, 7, 'Aprendiz'),       
(1, 8, 'Aliado'),         
(2, 3, 'Ex-amante'),      
(2, 8, 'Ex-amante'),      
(7, 8, 'Amigos'),         
(1, 4, 'Salvo por');      

SELECT * FROM personagem;