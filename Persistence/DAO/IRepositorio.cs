using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistence.DAO
{
    public interface IRepositorio<T> where T : class 
    {
        void Adicionar(T item);
        void Remover(T item);
        void Remover(Object id);
        void Atualizar(T item);
        T FindOne(Object id);
        IQueryable FindAll();
    }
}
