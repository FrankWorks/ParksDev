using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MS.MVC.BB.Park.Models;
using Microsoft.AspNet.Identity.EntityFramework;

namespace MS.MVC.BB.Park.Context
{
    public class ApplicationDataContext : IdentityDbContext<AppUser>
    {
        public ApplicationDataContext()
            : base("DefaultConnection")
        { }

        public System.Data.Entity.DbSet<AppUser> AppUsers { get; set; }
    }
}