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
        private ObjectSet<Curso> _curso;
        public BDSysCadContext()
            : base("name=BDSysCadEntities", "BDSysCadEntities")
        {
            base.ContextOptions.ProxyCreationEnabled = true;
            base.ContextOptions.LazyLoadingEnabled = true;
            _curso = base.CreateObjectSet<Curso>();
        }

        public ObjectSet<Curso> Curso
        {
            get
            {
                return _curso;
            }
        }
    }
}
