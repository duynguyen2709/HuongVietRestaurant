using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Utilities
{
    public class StoreProcName
    {
        public static Dictionary<StoreProcEnum, String> map = new Dictionary<StoreProcEnum, string>();

        static StoreProcName()
        {
            foreach (StoreProcEnum e in (StoreProcEnum[])Enum.GetValues(typeof(StoreProcEnum)))
            {
                map.Add(e, e.ToString());
            }
        }
    }
}
