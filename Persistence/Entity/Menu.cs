using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistence.Entity
{
    public class Menu
    {
        public int idMenu { get; set; }
        public string perfis { get; set; }
        public string titulo { get; set; }
        public string url { get; set; }
        public string grupo { get; set; }
        public string icon { get; set; }
        public string nomeTab { get; set; }
    }
}
