using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using Persistence.Entity;

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
            this.context = new BDSysCadContext();
        }

        public virtual void Adicionar(T item)
        {
            context.AddObject(EntitySetName, item);
        }

        public virtual void Remover(T item)
        {
            context.DeleteObject(item);
        }

        /*
        public virtual void Atualizar(T item)
        {
            EntityKey key;
            object originalItem;

            if ((item.EntityKey == null)
                // Obtém o entity key do objeto que será atualizado
                key = context.CreateEntityKey(EntitySetName, item);
            else
                key = item.EntityKey;
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
        }*/

        /// Retorna um IQueryable com todos os objetos usando paginação
        public IQueryable<T> QueryAll(int maximumRows, int startRowIndex)
        {
            return context.CreateQuery<T>(EntitySetName).Skip<T>(startRowIndex).Take(maximumRows);
        }

        public T FindOne(object id)
        {
            return context.CreateQuery<T>(EntitySetName, new ObjectParameter("key", id)).First<T>();
        }

        public List<T> FindAll()
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
