Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXGOSS6AKGQEXOMHGLQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 65si172947wmr.3.2016.07.12.10.22.36
        for <rtc-linux@googlegroups.com>;
        Tue, 12 Jul 2016 10:22:36 -0700 (PDT)
Date: Tue, 12 Jul 2016 19:22:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	devicetree@vger.kernel.org, narmstrong@baylibre.com,
	frowand.list@gmail.com, khilman@baylibre.com
Subject: [rtc-linux] Re: [PATCH v3 1/4] rtc: support for amlogic meson rtc
Message-ID: <20160712172235.GU22202@piout.net>
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467748122-14833-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467748122-14833-3-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Very few comments below

On 05/07/2016 at 20:48:41 +0100, Ben Dooks wrote :
> +/* registers accessed from cpu bus */
> +#define RTC_REG(x)		((x) * 4)	/* rtc registers 0-4 */
> +
> +#define LINE_SDI		(1 << 2)
> +#define LINE_SEN		(1 << 1)
> +#define LINE_SCLK		(1 << 0)
> +

Maybe use BIT() here.

> +/* RTC interface layer functions */
> +
> +static int meson_rtc_gettime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct meson_rtc *rtc = dev_get_drvdata(dev);
> +	int ret;
> +	u32 time;
> +
> +	mutex_lock(&rtc->lock);
> +
> +	ret = meson_rtc_read(rtc, RTC_COUNTER, &time);
> +	if (!ret) {
> +		rtc_time_to_tm(time, tm);

Can you use the 64bit version?

> +		dev_dbg(dev, "read time %lu\n", (unsigned long)time);
> +	}
> +
> +	mutex_unlock(&rtc->lock);
> +	return ret;
> +}
> +
> +static int meson_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct meson_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned long time;
> +	int ret;
> +
> +	mutex_lock(&rtc->lock);
> +
> +	rtc_tm_to_time(tm, &time);

Ditto.


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
