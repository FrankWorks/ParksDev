using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MS.MVC.BB.Park.Startup))]
namespace MS.MVC.BB.Park
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
