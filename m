Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCHXYPCAKGQETMJZIZQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 14si1093779wmn.2.2017.01.31.13.03.04
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Jan 2017 13:03:04 -0800 (PST)
Date: Tue, 31 Jan 2017 22:03:04 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: bq32000: add support to enable disable
 the trickle charge FET bypass.
Message-ID: <20170131210304.duztjh4k55yvxrvs@piout.net>
References: <20170127174346.30131-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170127174346.30131-1-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27/01/2017 at 18:43:46 +0100, Enric Balletbo i Serra wrote:
> The bq32000 includes a trickle charge circuit to maintain the charge of the
> backup supply when a super capacitor is used.
> 
> You can enable the charging circuit by setting 'trickle-resistor-ohms',
> additionally you can set TCFE to 1 to bypass the internal diode and boost
> the charge voltage of the backup supply. You might want to enable/disable
> the TCFE switch from userspace (e.g when device is only connected to a
> battery)
> 
> This patch introduces a new sysfs entry to enable and disable this FET
> form userspace.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  .../ABI/testing/sysfs-bus-i2c-devices-bq32k        |  7 ++
>  drivers/rtc/rtc-bq32k.c                            | 76 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k
> 
Applied, thanks.

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
