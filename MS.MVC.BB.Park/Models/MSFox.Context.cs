﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MS.MVC.BB.Park.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class FOXPRODEVEntities : DbContext
    {
        public FOXPRODEVEntities()
            : base("name=FOXPRODEVEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AGENBALANCFY> AGENBALANCFies { get; set; }
        public virtual DbSet<AGENCCALC> AGENCCALCS { get; set; }
        public virtual DbSet<AGENCy> AGENCIES { get; set; }
        public virtual DbSet<CALTYPE> CALTYPES { get; set; }
        public virtual DbSet<BENEFIT> BENEFITS { get; set; }
        public virtual DbSet<FUNDTYPE> FUNDTYPES { get; set; }
        public virtual DbSet<INTEREST> INTERESTs { get; set; }
        public virtual DbSet<R_CARA_TABLE> R_CARA_TABLE { get; set; }
        public virtual DbSet<TRANSACTIONTYPE> TRANSACTIONTYPES { get; set; }
        public virtual DbSet<YOUTHCREDITTYPE> YOUTHCREDITTYPEs { get; set; }
    }
}
