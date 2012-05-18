using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data.EntityClient;

namespace Persistence.Entity
{
    public class Status
    {
        public int idStatus { get; set; }
        public string descricao { get; set; }
    }
}
