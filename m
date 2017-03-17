Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFXZV7DAKGQEWI73OVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n128si160645wmf.2.2017.03.17.08.11.18
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 08:11:18 -0700 (PDT)
Date: Fri, 17 Mar 2017 16:11:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/5] rtc: rtc-sh: add support for rza series
Message-ID: <20170317151117.a7q4fz4ucqg5ngdi@piout.net>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-2-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170316175112.27913-2-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Mostly good, one nitpick:

On 16/03/2017 at 13:51:08 -0400, Chris Brandt wrote:
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (res == NULL)

if (!res) is preferred here

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
