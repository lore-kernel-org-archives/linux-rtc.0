Return-Path: <rtc-linux+bncBCW4XG6ATMLBBWOOS7BAKGQE7BI5QII@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id e134si73189wmd.3.2016.12.05.14.16.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 14:16:57 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id o141so27207981lff.1
        for <rtc-linux@googlegroups.com>; Mon, 05 Dec 2016 14:16:57 -0800 (PST)
Date: Mon, 5 Dec 2016 23:16:55 +0100
From: Emil Bartczak <emilbart@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: mcp795: fix month write resetting
 date to 1.
Message-ID: <20161205221655.GA15764@emba-laptop>
References: <cover.1480939487.git.emilbart@gmail.com>
 <6a1e8548654fd8a5b65ba98f59b2b5ccb1544f7f.1480939487.git.emilbart@gmail.com>
 <20161205152410.qj64rw67jdccyrab@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161205152410.qj64rw67jdccyrab@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Mon, Dec 05, 2016 at 04:24:10PM +0100, Alexandre Belloni wrote:
> On 05/12/2016 at 14:11:52 +0100, Emil Bartczak wrote :
> > According to Microchip errata some combinations of date and month
> > values may result in the date being reset to 1, even if the date
> > is also written with the month (for example 31-07 or 31-08).
> > As a workaround avoid writing date and month values within the same
> > Write command. Instead, terminate the Write command after loading
> > the date and begin a new command to write the month. In addition,
> > disable the oscillator before loading the new values. This is done
> > by ensuring both the ST and EXTOSC bits are cleared and waiting for
> > the OSCON bit to clear.
> > ---
> >  drivers/rtc/rtc-mcp795.c | 103 +++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 82 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> > index d15072c..c9ad46c 100644
> > --- a/drivers/rtc/rtc-mcp795.c
> > +++ b/drivers/rtc/rtc-mcp795.c
> > @@ -21,25 +21,34 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/rtc.h>
> >  #include <linux/of.h>
> > +#include <linux/delay.h>
> >  
> >  /* MCP795 Instructions, see datasheet table 3-1 */
> > -#define MCP795_EEREAD	0x03
> > -#define MCP795_EEWRITE	0x02
> > -#define MCP795_EEWRDI	0x04
> > -#define MCP795_EEWREN	0x06
> > -#define MCP795_SRREAD	0x05
> > -#define MCP795_SRWRITE	0x01
> > -#define MCP795_READ	0x13
> > -#define MCP795_WRITE	0x12
> > -#define MCP795_UNLOCK	0x14
> > -#define MCP795_IDWRITE	0x32
> > -#define MCP795_IDREAD	0x33
> > -#define MCP795_CLRWDT	0x44
> > -#define MCP795_CLRRAM	0x54
> > -
> > -#define MCP795_ST_BIT	0x80
> > -#define MCP795_24_BIT	0x40
> > -#define MCP795_LP_BIT	0x20
> > +#define MCP795_EEREAD		0x03
> > +#define MCP795_EEWRITE		0x02
> > +#define MCP795_EEWRDI		0x04
> > +#define MCP795_EEWREN		0x06
> > +#define MCP795_SRREAD		0x05
> > +#define MCP795_SRWRITE		0x01
> > +#define MCP795_READ		0x13
> > +#define MCP795_WRITE		0x12
> > +#define MCP795_UNLOCK		0x14
> > +#define MCP795_IDWRITE		0x32
> > +#define MCP795_IDREAD		0x33
> > +#define MCP795_CLRWDT		0x44
> > +#define MCP795_CLRRAM		0x54
> > +
> 
> Please don't reindent, they are a separate block anyway.
Ok,

> 
> > +/* MCP795 RTCC registers, see datasheet table 4-1 */
> > +#define MCP795_REG_SECONDS	0x01
> > +#define MCP795_REG_DAY		0x04
> > +#define MCP795_REG_MONTH	0x06
> > +#define MCP795_REG_CONTROL	0x08
> > +
> > +#define MCP795_ST_BIT		0x80
> > +#define MCP795_24_BIT		0x40
> > +#define MCP795_LP_BIT		0x20
> > +#define MCP795_EXTOSC_BIT	0x08
> > +#define MCP795_OSCON_BIT	0x20
> 
> Please use BIT() and that is valid for the first patch too).
Ok, I will fix it in the next patchset.

> 
> >  
> >  static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
> >  {
> > @@ -94,14 +103,51 @@ static int mcp795_rtcc_set_bits(struct device *dev, u8 addr, u8 mask, u8 state)
> >  	return ret;
> >  }
> >  
> > +static int mcp795_stop_oscillator(struct device *dev)
> > +{
> > +	int retries = 5;
> > +	int ret;
> > +	u8 data;
> > +
> > +	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS, MCP795_ST_BIT, 0);
> > +	if (ret)
> > +		return ret;
> > +	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, 0);
> > +	if (ret)
> > +		return ret;
> > +	do {
> > +		usleep_range(700, 800);
> > +		ret = mcp795_rtcc_read(dev, MCP795_REG_DAY,
> > +					&data, sizeof(data));
> > +		if (ret)
> > +			break;
> > +		if (!(data & MCP795_OSCON_BIT))
> > +			break;
> > +
> > +	} while (--retries);
> > +
> > +	return !retries ? -EIO : ret;
> > +}
> > +
> > +static int mcp795_start_oscillator(struct device *dev)
> > +{
> > +	return mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS,
> > +					MCP795_ST_BIT, MCP795_ST_BIT);
> 
> You probably want to restore EXTOSC to its previous value here.
I came to the conclusion that it is better to remove clearing of bit EXTOSC in function mcp795_stop_oscillator.
Because regarding datasheet, after power up the RTC chip (or reset) that bit has value 0.
What do you think?
 
> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Emil,

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
