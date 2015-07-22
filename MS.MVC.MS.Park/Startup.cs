using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MS.MVC.MS.Park.Startup))]
namespace MS.MVC.MS.Park
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
