Return-Path: <rtc-linux+bncBDS7HNEFSALRBKENYCYAKGQE6IMTUWI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bj4si122718wib.1.2015.10.03.09.47.36
        for <rtc-linux@googlegroups.com>;
        Sat, 03 Oct 2015 09:47:36 -0700 (PDT)
Date: Sat, 3 Oct 2015 18:47:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Wim Van Sebroeck <wim@iguana.be>, rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151003164735.GF2694@piout.net>
References: <1443817082-24370-1-git-send-email-harald@ccbib.org>
 <1443817082-24370-2-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443817082-24370-2-git-send-email-harald@ccbib.org>
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

On 02/10/2015 at 20:18:02 +0000, Harald Geyer wrote :
> +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
> +{
> +	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
> +
> +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> +	       STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR + rtc_data->io);

nitpick: I would put rtc_data->io first here for consistency.

Else, this seems fine to me, I can take that patch with the watchdog
maintainers ack.
-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
