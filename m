Return-Path: <rtc-linux+bncBCU2BBWH4IORBUOP2LIQKGQESEF3HXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com. [2607:f8b0:4001:c06::236])
        by gmr-mx.google.com with ESMTPS id s6si427162ybg.2.2017.12.15.20.57.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 20:57:53 -0800 (PST)
Received: by mail-io0-x236.google.com with SMTP id e204so4728367iof.12
        for <rtc-linux@googlegroups.com>; Fri, 15 Dec 2017 20:57:53 -0800 (PST)
Date: Fri, 15 Dec 2017 20:57:50 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20171216045750.GB52366@google.com>
References: <20171110215553.20696-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20171110215553.20696-3-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Nov 10, 2017 at 10:55:53PM +0100, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
> 
> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> Add a basic driver with this functionality.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Benson Leung <bleung@chromium.org>
> ---
>  drivers/rtc/Kconfig       |  10 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-cros-ec.c | 413 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cros-ec.c

This isn't quite super-helpful without the CrOS-EC / MFD additions to
actually create the device, but it's a good start, and I don't see any
problems with it. Any reason this isn't merged? Are the RTC maintainers
intendending to merge this, or should Lee (for the MFD header)? I
thought normally Lee deferred to other subsystem maintainers when the
only "MFD" stuff was a simple header change (such as in patch 1).

Anyway, FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
