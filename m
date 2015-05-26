Return-Path: <rtc-linux+bncBAABBX5YSOVQKGQEGPXTHAY@googlegroups.com>
Received: from mxadeneo.adeneo-embedded.us (vpnchicago.adeneo-embedded.us. [65.182.180.190])
        by gmr-mx.google.com with ESMTPS id jr5si1573670pbb.1.2015.05.26.13.49.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 May 2015 13:49:35 -0700 (PDT)
Date: Tue, 26 May 2015 13:49:32 -0700
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc-isl1208: add device tree support
Message-ID: <20150526134932.26c2b81560deb49d1e8efeed@adeneo-embedded.us>
In-Reply-To: <20150526202032.GK3199@piout.net>
References: <1432667550-24272-1-git-send-email-jtheou@adeneo-embedded.us>
	<1432667550-24272-2-git-send-email-jtheou@adeneo-embedded.us>
	<20150526202032.GK3199@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

Indeed. Sorry for the noise.

Best regards

On Tue, 26 May 2015 22:20:32 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> On 26/05/2015 at 12:12:30 -0700, Jean-Baptiste Theou wrote :
> > Add a basic device tree support for isl1208 driver
> > 
> > Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> > ---
> >  drivers/rtc/rtc-isl1208.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> > index c3c549d..b47a3f9 100644
> > --- a/drivers/rtc/rtc-isl1208.c
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -692,6 +692,14 @@ isl1208_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id isl1208_dt_match[] = {
> > +	{ .compatible = "isil,isl1208" },
> > +	{ .compatible = "isil,isl1218" },
> > +	{ },
> > +};
> > +#endif
> > +
> >  static const struct i2c_device_id isl1208_id[] = {
> >  	{ "isl1208", 0 },
> >  	{ "isl1218", 0 },
> > @@ -702,6 +710,7 @@ MODULE_DEVICE_TABLE(i2c, isl1208_id);
> >  static struct i2c_driver isl1208_driver = {
> >  	.driver = {
> >  		   .name = "rtc-isl1208",
> > +		   .of_match_table = of_match_ptr(isl1208_dt_match),
> 
> This patch is unnecessary as the i2c subsystem will already match
> isil,isl1208 or isil,isl1218 with the i2c_device_id array.
> 
> >  		   },
> >  	.probe = isl1208_probe,
> >  	.remove = isl1208_remove,
> > -- 
> > 2.4.0
> > 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


-- 
Jean-Baptiste Theou <jtheou@adeneo-embedded.us>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
