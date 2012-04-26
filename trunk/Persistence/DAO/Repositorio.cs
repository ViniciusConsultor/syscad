using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using Persistence.Entity;
using System.Linq.Expressions;

namespace Persistence.DAO
{
    public class Repositorio<T> : IRepositorio<T> where T : class
    {
        protected readonly BDSysCadContext context;
        protected string entitySetName;

        protected string EntitySetName
        {
            get
            {
                if (String.IsNullOrEmpty(entitySetName))
                    entitySetName = GetEntitySetName();

                return entitySetName;
            }
        }

        public Repositorio()
        {
            this.context = new BDSysCadContext(true);
        }

        public Repositorio(bool LazyEnable)
        {
            this.context = new BDSysCadContext(LazyEnable);
        }

        public virtual void Adicionar(T item)
        {
            context.AddObject(EntitySetName, item);
        }

        public virtual void Remover(T item)
        {
            context.DeleteObject(item);
        }

        
        public virtual void Atualizar(T item)
        {
            EntityKey key;
            object originalItem;
            key = context.CreateEntityKey(EntitySetName, item);

            try
            {
                // Obtém o objeto original
                if (context.TryGetObjectByKey(key, out originalItem))
                {
                    if (originalItem is EntityObject &&
                        ((EntityObject)originalItem).EntityState != EntityState.Added)
                    {
                        // Autaliza o objeto
                        context.ApplyCurrentValues<T>(key.EntitySetName, item);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public virtual T FindOne(Expression<Func<T, bool>> where)
        {
            return context.CreateQuery<T>(EntitySetName).Where(where).FirstOrDefault();
        }

       // public T FindOne(object id)
       // {
       //     return context.CreateQuery<T>(EntitySetName, new ObjectParameter("idUsuario", id)).First<T>();
      //  }

        public virtual List<T> FindAll()
        {
            return context.CreateQuery<T>(EntitySetName).ToList<T>();
        }

        private string GetEntitySetName()
        {
            return String.Format("{0}Set",typeof(T).Name);
        }

        public void SaveChanges()
        {
            context.SaveChanges();
        }
    }
}
