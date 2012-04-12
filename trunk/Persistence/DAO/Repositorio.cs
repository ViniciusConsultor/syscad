using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data;

namespace Persistence.DAO
{
    public class Repositorio<T> : IRepositorio<T> where T : class
    {
        protected readonly DbContext context;

        public Repositorio(DbContext context)
        {
            this.context = context;
        }

        public virtual void Adicionar(T item)
        {
            context.Set<T>().Add(item);
            context.SaveChanges();
        }

        public virtual void Remover(T item)
        {
            context.Set<T>().Remove(item);
            context.SaveChanges();
        }

        public virtual void Remover(object id)
        {
            T item = context.Set<T>().Find(id);
            Remover(item);
        }

        public virtual void Atualizar(T item)
        {
            context.Entry<T>(item).State = EntityState.Modified;
            context.SaveChanges();
        }

        public T FindOne(object id)
        {
            return context.Set<T>().Find(id);
        }

        public IQueryable FindAll()
        {
            return context.Set<T>();
        }

    }
}
