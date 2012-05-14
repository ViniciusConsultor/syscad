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
            base.ContextOptions.ProxyCreationEnabled = false;
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
            set
            {
                _aluno = value;
            }
        }

        public ObjectSet<Cargo> Cargo
        {
            get
            {
                return _cargo;
            }
            set
            {
                _cargo = value;
            }
        }

        public ObjectSet<Cobranca> Cobranca
        {
            get
            {
                return _cobranca;
            }
            set
            {
                _cobranca = value;
            }
        }

        public ObjectSet<Curso> Curso
        {
            get
            {
                return _curso;
            }
            set
            {
                _curso = value;
            }
        }

        public ObjectSet<Endereco> Endereco
        {
            get
            {
                return _endereco;
            }
            set
            {
                _endereco = value;
            }
        }

        public ObjectSet<Funcionario> Funcionario
        {
            get
            {
                return _funcionario;
            }
            set
            {
                _funcionario = value;
            }
        }

        public ObjectSet<Matricula> Matricula
        {
            get
            {
                return _matricula;
            }
            set
            {
                _matricula = value;
            }
        }

        public ObjectSet<MatriculaTurma> MatriculaTurma
        {
            get
            {
                return _matriculaTurma;
            }
            set
            {
                _matriculaTurma = value;
            }
        }

        public ObjectSet<Modulo> Modulo
        {
            get
            {
                return _modulo;
            }
            set
            {
                _modulo = value;
            }
        }

        public ObjectSet<NotaFalta> NotaFalta
        {
            get
            {
                return _notaFalta;
            }
            set
            {
                _notaFalta = value;
            }
        }

        public ObjectSet<Perfil> Perfil
        {
            get
            {
                return _perfil;
            }
            set
            {
                _perfil = value;
            }
        }

        public ObjectSet<Pessoa> Pessoa
        {
            get
            {
                return _pessoa;
            }
            set
            {
                _pessoa = value;
            }
        }

        public ObjectSet<Taxa> Taxa
        {
            get
            {
                return _taxa;
            }
            set
            {
                _taxa = value;
            }
        }

        public ObjectSet<TipoEndereco> TipoEndereco
        {
            get
            {
                return _tipoEndereco;
            }
            set
            {
                _tipoEndereco = value;
            }
        }

        public ObjectSet<Turma> Turma
        {
            get
            {
                return _turma;
            }
            set
            {
                _turma = value;
            }
        }


        public ObjectSet<Usuario> Usuario
        {
            get
            {
                return _usuario;
            }
            set
            {
                _usuario = value;
            }
        }
    }
}
