Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCHOWHCQKGQEQDE4GSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si1169865wmf.0.2017.02.21.09.21.12
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 09:21:12 -0800 (PST)
Date: Tue, 21 Feb 2017 18:21:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hartley Sweeten <HartleyS@visionengravers.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"alex@digriz.org.uk" <alex@digriz.org.uk>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 1/5] rtc: m48t86: verify that the RTC is
 actually present
Message-ID: <20170221172101.2zde3z7hkpblennl@piout.net>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
 <20170215163527.5697-2-hsweeten@visionengravers.com>
 <20170221163720.m6hp27t4z7q4pgwl@piout.net>
 <SN1PR0101MB15652C26018F5BE5369DE4C7D0510@SN1PR0101MB1565.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <SN1PR0101MB15652C26018F5BE5369DE4C7D0510@SN1PR0101MB1565.prod.exchangelabs.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/02/2017 at 17:04:07 +0000, Hartley Sweeten wrote:
> On Tuesday, February 21, 2017 9:37 AM, Alexandre Belloni wrote:
> > On 15/02/2017 at 09:35:23 -0700, H Hartley Sweeten wrote:
> >> The RTC is an optional feature at purchase time on some Technologic
> >> Systems boards. Verify that it actually exists by checking if the
> >> last two bytes of the NVRAM can be changed.
> >> 
> >> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >> Cc: Alessandro Zummo <a.zummo@towertech.it>
> >> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> Cc: Alexander Clouter <alex@digriz.org.uk>
> >> ---
> >>  drivers/rtc/rtc-m48t86.c | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >> 
> >
> > I've applied that one. Alex, if you are fine with the mach-orion5x
> > changes, I can take them for 4.11. Else, this will wait for 4.12.
> 
> Hello,
> 
> Thanks. The change to mach-ep93xx is ok if you want to take that one.
> 

Ok, I took it.

> In order to address the last two bytes, these two offsets should actually be:
> 
> +	unsigned int offset0 = M48T86_NVRAM(M48T86_NVRAM_LEN - 2);
> +	unsigned int offset1 = M48T86_NVRAM(M48T86_NVRAM_LEN - 1);
> 
> As they are right now, they are both off by 14 bytes (0x0e).
> 
> I can send a patch to fix it or you can do it if you prefer.
> 

I fixed it up directly in rtc-next


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
