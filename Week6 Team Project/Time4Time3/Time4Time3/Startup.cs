using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Time4Time3.Startup))]
namespace Time4Time3
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
