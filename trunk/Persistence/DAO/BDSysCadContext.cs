using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Objects;
using System.Data.EntityClient;
using Persistence.Entity;

namespace Persistence.DAO
{
    public class BDSysCadContext : ObjectContext
    {
        private ObjectSet<Aluno> _aluno;
        private ObjectSet<Cargo> _cargo;
        private ObjectSet<Cobranca> _cobranca;
        private ObjectSet<Curso> _curso;
        private ObjectSet<Endereco> _endereco;
        private ObjectSet<Funcionario> _funcionario;
        private ObjectSet<Matricula> _matricula;
        private ObjectSet<MatriculaTurma> _matriculaTurma;
        private ObjectSet<Modulo> _modulo;
        private ObjectSet<NotaFalta> _notaFalta;
        private ObjectSet<Perfil> _perfil;
        private ObjectSet<Pessoa> _pessoa;
        private ObjectSet<Taxa> _taxa;
        private ObjectSet<TipoEndereco> _tipoEndereco;
        private ObjectSet<Turma> _turma;
        private ObjectSet<Usuario> _usuario;

        public BDSysCadContext()
            : base("name=BDSysCadEntities", "BDSysCadEntities")
        {
            base.ContextOptions.ProxyCreationEnabled = true;
            base.ContextOptions.LazyLoadingEnabled = true;
            _aluno = base.CreateObjectSet<Aluno>();
            _cargo = base.CreateObjectSet<Cargo>();
            _cobranca = base.CreateObjectSet<Cobranca>();
            _curso = base.CreateObjectSet<Curso>();
            _endereco = base.CreateObjectSet<Endereco>();
            _funcionario = base.CreateObjectSet<Funcionario>();
            _matricula = base.CreateObjectSet<Matricula>();
            _matriculaTurma = base.CreateObjectSet<MatriculaTurma>();
            _modulo = base.CreateObjectSet<Modulo>();
            _notaFalta = base.CreateObjectSet<NotaFalta>();
            _perfil = base.CreateObjectSet<Perfil>();
            _pessoa = base.CreateObjectSet<Pessoa>();
            _taxa = base.CreateObjectSet<Taxa>();
            _tipoEndereco = base.CreateObjectSet<TipoEndereco>();
            _turma = base.CreateObjectSet<Turma>();
            _usuario = base.CreateObjectSet<Usuario>();
            
        }

        public ObjectSet<Aluno> Aluno
        {
            get
            {
                return _aluno;
            }
        }

        public ObjectSet<Cargo> Cargo
        {
            get
            {
                return _cargo;
            }
        }

        public ObjectSet<Cobranca> Cobranca
        {
            get
            {
                return _cobranca;
            }
        }

        public ObjectSet<Curso> Curso
        {
            get
            {
                return _curso;
            }
        }

        public ObjectSet<Endereco> Endereco
        {
            get
            {
                return _endereco;
            }
        }

        public ObjectSet<Funcionario> Funcionario
        {
            get
            {
                return _funcionario;
            }
        }

        public ObjectSet<Matricula> Matricula
        {
            get
            {
                return _matricula;
            }
        }

        public ObjectSet<MatriculaTurma> MatriculaTurma
        {
            get
            {
                return _matriculaTurma;
            }
        }

        public ObjectSet<Modulo> Modulo
        {
            get
            {
                return _modulo;
            }
        }

        public ObjectSet<NotaFalta> NotaFalta
        {
            get
            {
                return _notaFalta;
            }
        }

        public ObjectSet<Perfil> Perfil
        {
            get
            {
                return _perfil;
            }
        }

        public ObjectSet<Pessoa> Pessoa
        {
            get
            {
                return _pessoa;
            }
        }

        public ObjectSet<Taxa> Taxa
        {
            get
            {
                return _taxa;
            }
        }

        public ObjectSet<TipoEndereco> TipoEndereco
        {
            get
            {
                return _tipoEndereco;
            }
        }

        public ObjectSet<Turma> Turma
        {
            get
            {
                return _turma;
            }
        }


        public ObjectSet<Usuario> Usuario
        {
            get
            {
                return _usuario;
            }
        }


    }
}
