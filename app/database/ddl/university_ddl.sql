CREATE SCHEMA university;

CREATE TABLE university.alunos (
    mat_alu       NUMERIC(10) NOT NULL,
    nome          VARCHAR(100) NOT NULL,
    dat_entrada   DATE NOT NULL,
    cod_curso     NUMERIC(3) NOT NULL,
    cotista       CHAR(1) NOT NULL
);

ALTER TABLE university.alunos ADD CONSTRAINT alu_fk PRIMARY KEY ( mat_alu );

CREATE TABLE university.cursos (
    cod_curso   NUMERIC(4) NOT NULL,
    nom_curso   VARCHAR(80) NOT NULL,
    cod_dpto    NUMERIC(3) NOT NULL
);

ALTER TABLE university.cursos ADD CONSTRAINT cur_pk PRIMARY KEY ( cod_curso );

CREATE TABLE university.departamentos (
    cod_dpto    NUMERIC(3) NOT NULL,
    nome_dpto   VARCHAR(50) NOT NULL
);

ALTER TABLE university.departamentos ADD CONSTRAINT departamentos_pk PRIMARY KEY ( cod_dpto );

CREATE TABLE university.disciplinas (
    cod_disc        NUMERIC(5) NOT NULL,
    nome_disc       VARCHAR(60) NOT NULL,
    carga_horaria   NUMERIC(5, 2) NOT NULL
);

ALTER TABLE university.disciplinas ADD CONSTRAINT disc_pk PRIMARY KEY ( cod_disc );

CREATE TABLE university.matriculas (
    semestre   NUMERIC(6) NOT NULL,
    mat_alu    NUMERIC(10) NOT NULL,
    cod_disc   NUMERIC(5) NOT NULL,
    nota       NUMERIC(5, 2),
    faltas     NUMERIC(3),
    status     CHAR(1)
);

ALTER TABLE university.matriculas ADD CONSTRAINT mat_pk PRIMARY KEY ( mat_alu,
                                                           semestre );

CREATE TABLE university.matrizes_cursos (
    cod_curso   NUMERIC(4) NOT NULL,
    cod_disc    NUMERIC(5) NOT NULL,
    periodo     NUMERIC(2) NOT NULL
);

ALTER TABLE university.matrizes_cursos ADD CONSTRAINT mcu_pk PRIMARY KEY ( cod_curso,
                                                                cod_disc );

ALTER TABLE university.alunos
    ADD CONSTRAINT alu_cur_fk FOREIGN KEY ( cod_curso )
        REFERENCES cursos ( cod_curso );

ALTER TABLE university.cursos
    ADD CONSTRAINT cur_der_fk FOREIGN KEY ( cod_dpto )
        REFERENCES departamentos ( cod_dpto );

ALTER TABLE university.matriculas
    ADD CONSTRAINT mat_alu_fk FOREIGN KEY ( mat_alu )
        REFERENCES alunos ( mat_alu );

ALTER TABLE university.matriculas
    ADD CONSTRAINT mat_dis_fk FOREIGN KEY ( cod_disc )
        REFERENCES disciplinas ( cod_disc );

ALTER TABLE university.matrizes_cursos
    ADD CONSTRAINT mcu_cur_fk FOREIGN KEY ( cod_curso )
        REFERENCES cursos ( cod_curso );

ALTER TABLE university.matrizes_cursos
    ADD CONSTRAINT mcu_dis_fk FOREIGN KEY ( cod_disc )
        REFERENCES disciplinas ( cod_disc );

