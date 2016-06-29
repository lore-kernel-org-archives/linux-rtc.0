Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAMBZ25QKGQEOOLBSFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q124si514060wme.3.2016.06.29.01.02.09
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Jun 2016 01:02:09 -0700 (PDT)
Date: Wed, 29 Jun 2016 10:02:08 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	Carsten Resch <Carsten.Resch@de.bosch.com>
Subject: Re: [rtc-linux] [PATCH v2 4/4] rtc: rv8803: Be able to set VDETOFF
 and SWOFF via devcie tree
Message-ID: <20160629080208.GQ29249@piout.net>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
 <1466577742-18824-5-git-send-email-dirk.behme@de.bosch.com>
 <20160624074407.GJ5809@piout.net>
 <57734FFB.4000104@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57734FFB.4000104@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/06/2016 at 06:35:07 +0200, fixed-term.Oleksij.Rempel wrote :
> 
> 
> On 24.06.2016 09:44, Alexandre Belloni wrote:
> > On 22/06/2016 at 08:42:22 +0200, Dirk Behme wrote :
> >> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> >>
> >> There might be designs where the power supply circuit is designed
> >> in a way that VDETOFF and SWOFF is reuqired to be set. Otherwise the
> >> RTC detects a power loss. Add a device tree interface for this.
> >>
> >> Signed-off-by: Carsten Resch <Carsten.Resch@de.bosch.com>
> >> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> >> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> >> Cc: devicetree@vger.kernel.org
> >> ---
> >>  drivers/rtc/rtc-rv8803.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> >> index e122b51..32a5686 100644
> >> --- a/drivers/rtc/rtc-rv8803.c
> >> +++ b/drivers/rtc/rtc-rv8803.c
> >> @@ -50,6 +50,10 @@
> >>  #define RV8803_CTRL_TIE			BIT(4)
> >>  #define RV8803_CTRL_UIE			BIT(5)
> >>  
> >> +#define RX8900_BACKUP_CTRL		0x18
> >> +#define RX8900_FLAG_SWOFF		BIT(2)
> >> +#define RX8900_FLAG_VDETOFF		BIT(3)
> >> +
> >>  struct rv8803_data {
> >>  	struct i2c_client *client;
> >>  	struct rtc_device *rtc;
> >> @@ -423,6 +427,35 @@ static struct rtc_class_ops rv8803_rtc_ops = {
> >>  	.ioctl = rv8803_ioctl,
> >>  };
> >>  
> >> +static int rx8900_trickle_charger_init(struct rv8803_data *rv8803)
> >> +{
> >> +	struct i2c_client *client = rv8803->client;
> >> +	struct device_node *node = client->dev.of_node;
> >> +	int err;
> >> +	u8 flags;
> >> +
> >> +	if (!node)
> >> +		return 0;
> >> +
> >> +	if (!of_device_is_compatible(node, "epson,rx8900"))
> >> +		return 0;
> >> +
> > 
> > Can you use the i2c_device_id instead of of_device_is_compatible to
> > avoid matching on yet another string?
> 
> Sure, ... is it possible that device tree defines rx8900 but i2c will
> detect rv8803?

There is no detection in i2c, it will use the compatible strng to pass
the correct i2c_device_id.

> I assume it is potential source of errors. What would be better way to
> handle it?

i2c is doing the right thing, you just have to use the i2c_device_id.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
