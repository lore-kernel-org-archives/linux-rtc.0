Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBG4CSXCAKGQE5UFDGXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id y19si1177571wmd.0.2017.01.22.15.32.43
        for <rtc-linux@googlegroups.com>;
        Sun, 22 Jan 2017 15:32:43 -0800 (PST)
Date: Mon, 23 Jan 2017 00:32:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v2 3/4] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20170122233232.iin6frv7hme2y2jw@piout.net>
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170119123032.24679-3-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/01/2017 at 13:30:31 +0100, Enric Balletbo i Serra wrote :
> From: Stephen Barber <smbarber@chromium.org>
> 
> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> Add a basic driver with this functionality.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Lee, this can go through the mfd tree. Hopefully, nobody will add a new
driver nearby ;)


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
