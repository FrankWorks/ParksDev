﻿using System.Web;
using System.Web.Mvc;

namespace MS.MVC.Park
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
