CREATE DATABASE IF NOT EXISTS `bd_incidentes_ti` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bd_incidentes_ti`;

SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

-- Tabela: acao_tratamento
CREATE TABLE `acao_tratamento` (
  `id_acao` bigint(20) NOT NULL,
  `tipo_acao` varchar(50) NOT NULL,
  `descricao` text NOT NULL,
  `data_acao` datetime NOT NULL,
  `id_incidente` bigint(20) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  PRIMARY KEY (`id_acao`),
  KEY `fk_AÇÃO_TRATAMENTO_INCIDENTE1_idx` (`id_incidente`),
  KEY `fk_AÇÃO_TRATAMENTO_USUARIO1_idx` (`id_usuario`),
  CONSTRAINT `fk_AÇÃO_TRATAMENTO_INCIDENTE1` FOREIGN KEY (`id_incidente`) REFERENCES `incidente` (`id_incidente`),
  CONSTRAINT `fk_AÇÃO_TRATAMENTO_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: ativo
CREATE TABLE `ativo` (
  `id_ativo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `criticidade` varchar(10) NOT NULL,
  `endereco_ip` varchar(50) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_ativo`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: atribuicao_incidente
CREATE TABLE `atribuicao_incidente` (
  `id_atribuicao_incidente` bigint(20) NOT NULL,
  `id_incidente` bigint(20) NOT NULL,
  `id_usuario_responsavel` bigint(20) DEFAULT NULL,
  `id_equipe_responsavel` int(11) DEFAULT NULL,
  `id_usuario_atribuidor` bigint(20) NOT NULL,
  `data_atribuicao` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  `observacao` varchar(500) DEFAULT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `id_equipe` int(11) NOT NULL,
  PRIMARY KEY (`id_atribuicao_incidente`),
  KEY `fk_ATRIBUIÇÃO_INCIDENTE_INCIDENTE1_idx` (`id_incidente`),
  KEY `fk_ATRIBUIÇÃO_INCIDENTE_USUARIO1_idx` (`id_usuario`),
  KEY `fk_ATRIBUIÇÃO_INCIDENTE_EQUIPE1_idx` (`id_equipe`),
  CONSTRAINT `fk_ATRIBUIÇÃO_INCIDENTE_EQUIPE1` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`),
  CONSTRAINT `fk_ATRIBUIÇÃO_INCIDENTE_INCIDENTE1` FOREIGN KEY (`id_incidente`) REFERENCES `incidente` (`id_incidente`),
  CONSTRAINT `fk_ATRIBUIÇÃO_INCIDENTE_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: auditoria
CREATE TABLE `auditoria` (
  `id_auditoria` bigint(20) NOT NULL AUTO_INCREMENT,
  `acao` varchar(100) NOT NULL,
  `entidade` varchar(100) NOT NULL,
  `dados_anteriores` text DEFAULT NULL,
  `dados_novos` text DEFAULT NULL,
  `endereco_ip` varchar(45) DEFAULT NULL,
  `data_acao` datetime DEFAULT NULL,
  `id_usuario` bigint(20) NOT NULL,
  PRIMARY KEY (`id_auditoria`),
  KEY `fk_AUDITORIA_USUARIO1_idx` (`id_usuario`),
  CONSTRAINT `fk_AUDITORIA_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: categoria_incidente
CREATE TABLE `categoria_incidente` (
  `id_categoria_incidente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_categoria_incidente`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: equipe
CREATE TABLE `equipe` (
  `id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: equipe_usuario
CREATE TABLE `equipe_usuario` (
  `id_equipe` int(11) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `data_entrada` datetime NOT NULL,
  `data_saida` datetime DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  KEY `fk_EQUIPE_has_USUARIO_USUARIO1_idx` (`id_usuario`),
  KEY `fk_EQUIPE_has_USUARIO_EQUIPE1_idx` (`id_equipe`),
  CONSTRAINT `fk_EQUIPE_has_USUARIO_EQUIPE1` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`),
  CONSTRAINT `fk_EQUIPE_has_USUARIO_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: historico_incidente
CREATE TABLE `historico_incidente` (
  `id_historico_incidente` bigint(20) NOT NULL,
  `campo_alterado` varchar(100) NOT NULL,
  `valor_anterior` text DEFAULT NULL,
  `valor_novo` text DEFAULT NULL,
  `data_alteracao` datetime NOT NULL,
  `observacao` varchar(500) DEFAULT NULL,
  `id_incidente` bigint(20) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  PRIMARY KEY (`id_historico_incidente`),
  KEY `fk_HISTORICO_INCIDENTE_INCIDENTE1_idx` (`id_incidente`),
  KEY `fk_HISTORICO_INCIDENTE_USUARIO1_idx` (`id_usuario`),
  KEY `idx_historico_usuario` (`id_usuario`),
  CONSTRAINT `fk_HISTORICO_INCIDENTE_INCIDENTE1` FOREIGN KEY (`id_incidente`) REFERENCES `incidente` (`id_incidente`),
  CONSTRAINT `fk_HISTORICO_INCIDENTE_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: incidente
CREATE TABLE `incidente` (
  `id_incidente` bigint(20) NOT NULL,
  `codigo` varchar(35) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descricao` text NOT NULL,
  `data_ocorrencia` datetime NOT NULL,
  `data_registro` datetime NOT NULL,
  `id_origem_incidente` int(11) NOT NULL,
  `id_categoria_incidente` int(11) NOT NULL,
  `id_severidade` int(11) NOT NULL,
  `id_status_incidente` int(11) NOT NULL,
  `id_ativo` bigint(20) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `data_atualizacao` datetime NOT NULL,
  `data_resolucao` datetime DEFAULT NULL,
  `data_encerramento` datetime DEFAULT NULL,
  PRIMARY KEY (`id_incidente`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_INCIDENTE_ORIGEM_INCIDENTE1_idx` (`id_origem_incidente`),
  KEY `fk_INCIDENTE_CATEGORIA_INCIDENTE1_idx` (`id_categoria_incidente`),
  KEY `fk_INCIDENTE_SEVERIDADE1_idx` (`id_severidade`),
  KEY `fk_INCIDENTE_STATUS_INCIDENTE1_idx` (`id_status_incidente`),
  KEY `fk_INCIDENTE_ATIVO1_idx` (`id_ativo`),
  KEY `fk_INCIDENTE_USUARIO1_idx` (`id_usuario`),
  KEY `idx_incidente_ativo` (`id_ativo`),
  KEY `idx_incidente_severidade` (`id_severidade`),
  KEY `idx_incidente_resolucao` (`data_resolucao`),
  CONSTRAINT `fk_INCIDENTE_ATIVO1` FOREIGN KEY (`id_ativo`) REFERENCES `ativo` (`id_ativo`),
  CONSTRAINT `fk_INCIDENTE_CATEGORIA_INCIDENTE1` FOREIGN KEY (`id_categoria_incidente`) REFERENCES `categoria_incidente` (`id_categoria_incidente`),
  CONSTRAINT `fk_INCIDENTE_ORIGEM_INCIDENTE1` FOREIGN KEY (`id_origem_incidente`) REFERENCES `origem_incidente` (`id_origem_incidente`),
  CONSTRAINT `fk_INCIDENTE_SEVERIDADE1` FOREIGN KEY (`id_severidade`) REFERENCES `severidade` (`id_severidade`),
  CONSTRAINT `fk_INCIDENTE_STATUS_INCIDENTE1` FOREIGN KEY (`id_status_incidente`) REFERENCES `status_incidente` (`id_status_incidente`),
  CONSTRAINT `fk_INCIDENTE_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: origem_incidente
CREATE TABLE `origem_incidente` (
  `id_origem_incidente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_origem_incidente`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: perfil
CREATE TABLE `perfil` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador do perfil de cadastro',
  `nome` varchar(30) NOT NULL COMMENT 'nome do perfil',
  `descricao` varchar(260) DEFAULT NULL,
  `ativo` tinyint(4) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: perfil_permissao
CREATE TABLE `perfil_permissao` (
  `id_perfil` int(11) NOT NULL,
  `id_permissao` int(11) NOT NULL,
  KEY `fk_PERFIL_has_PERMISSÃO_PERMISSÃO1_idx` (`id_permissao`),
  KEY `fk_PERFIL_has_PERMISSÃO_PERFIL_idx` (`id_perfil`),
  CONSTRAINT `fk_PERFIL_has_PERMISSÃO_PERFIL` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`),
  CONSTRAINT `fk_PERFIL_has_PERMISSÃO_PERMISSÃO1` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id_permissao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: permissao
CREATE TABLE `permissao` (
  `id_permissao` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_permissao`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: severidade
CREATE TABLE `severidade` (
  `id_severidade` int(11) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `nivel` int(11) NOT NULL,
  `descricao` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_severidade`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  UNIQUE KEY `nivel_UNIQUE` (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: status_incidente
CREATE TABLE `status_incidente` (
  `id_status_incidente` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `ordem` int(11) NOT NULL,
  `status_final` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_status_incidente`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: tentativa_login
CREATE TABLE `tentativa_login` (
  `id_tentativa` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_informado` varchar(255) NOT NULL,
  `sucesso` tinyint(4) NOT NULL,
  `data_tentativa` datetime NOT NULL DEFAULT current_timestamp(),
  `user_agent` varchar(500) DEFAULT NULL,
  `motivo_falha` varchar(255) DEFAULT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `endereco_ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tentativa`),
  KEY `fk_TENTATIVA_LOGIN_USUARIO1_idx` (`id_usuario`),
  KEY `idx_tentativa_login_usuario` (`id_usuario`),
  KEY `idx_tentativa_login_sucesso` (`sucesso`),
  CONSTRAINT `fk_TENTATIVA_LOGIN_USUARIO1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabela: usuario
CREATE TABLE `usuario` (
  `id_usuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `email` varchar(260) NOT NULL,
  `senha_hash` varchar(250) NOT NULL,
  `ativo` tinyint(3) unsigned NOT NULL,
  `ultimo_login` datetime DEFAULT current_timestamp(),
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  `id_perfil` int(11) NOT NULL,
  `data_atualizacao` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  KEY `fk_USUARIO_PERFIL1_idx` (`id_perfil`),
  CONSTRAINT `fk_USUARIO_PERFIL1` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=4001 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
