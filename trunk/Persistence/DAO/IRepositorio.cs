using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using Persistence.Entity;

namespace Persistence.DAO
{
    public interface IRepositorio<T> where T : class 
    {
        void Adicionar(T item);
        void Remover(T item);
        //void Remover(Object id);
        //void Atualizar(T item);
        T FindOne(Object id);
        List<T> FindAll();
    }
}
