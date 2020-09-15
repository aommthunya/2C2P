using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(_2C2P_TEST.Startup))]
namespace _2C2P_TEST
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
