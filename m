Return-Path: <rtc-linux+bncBCJP7WOE5UIBBV6NRCZQKGQEDZPS34I@googlegroups.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com. [2607:f8b0:4002:c07::22e])
        by gmr-mx.google.com with ESMTPS id m7si1330789ywe.1.2015.12.04.15.50.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 15:50:47 -0800 (PST)
Received: by ykfs79 with SMTP id s79so143577317ykf.1
        for <rtc-linux@googlegroups.com>; Fri, 04 Dec 2015 15:50:47 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
Date: Fri, 4 Dec 2015 15:50:47 -0800
Message-ID: <CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Julius,

On Wed, Dec 2, 2015 at 5:53 PM, Julius Werner <jwerner@chromium.org> wrote:
> In Fuzhou, China, the month of November seems to be having 31 days.
> That's nice and all (I'm sure you can get a lot more done in a year that
> way), but back here in other parts of the world we are not so lucky.
> Therefore, if we read that date from the RTC we should correct it to
> December 1st.
>
> This is not a full workaround. Since the RTC actually ticks all the way
> through that imaginary day, there's no easy way to detect and correct
> this issue if the device was offline the whole time and allowed it to
> tick through to December 1st on the Rockchip calendar (which would be
> December 2nd on the Gregorian one). Those edge cases can only really be
> solved by regularly syncing to an external time source (e.g. NTP).
>
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
>  drivers/rtc/rtc-rk808.c | 93 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
> index 91ca0bc..b605b35 100644
> --- a/drivers/rtc/rtc-rk808.c
> +++ b/drivers/rtc/rtc-rk808.c
> @@ -56,6 +56,50 @@ struct rk808_rtc {
>         int irq;
>  };
>
> +/* Set current time and date in RTC */
> +static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> +       struct rk808 *rk808 = rk808_rtc->rk808;
> +       u8 rtc_data[NUM_TIME_REGS];
> +       int ret;
> +
> +       rtc_data[0] = bin2bcd(tm->tm_sec);
> +       rtc_data[1] = bin2bcd(tm->tm_min);
> +       rtc_data[2] = bin2bcd(tm->tm_hour);
> +       rtc_data[3] = bin2bcd(tm->tm_mday);
> +       rtc_data[4] = bin2bcd(tm->tm_mon + 1);
> +       rtc_data[5] = bin2bcd(tm->tm_year - 100);
> +       rtc_data[6] = bin2bcd(tm->tm_wday);
> +       dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
> +               1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> +               tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
> +
> +       /* Stop RTC while updating the RTC registers */
> +       ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +                                BIT_RTC_CTRL_REG_STOP_RTC_M,
> +                                BIT_RTC_CTRL_REG_STOP_RTC_M);
> +       if (ret) {
> +               dev_err(dev, "Failed to update RTC control: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = regmap_bulk_write(rk808->regmap, RK808_SECONDS_REG,
> +                               rtc_data, NUM_TIME_REGS);
> +       if (ret) {
> +               dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
> +               return ret;
> +       }
> +       /* Start RTC again */
> +       ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +                                BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
> +       if (ret) {
> +               dev_err(dev, "Failed to update RTC control: %d\n", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
>  /* Read current time and date in RTC */
>  static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  {
> @@ -105,51 +149,14 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>                 1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
>                 tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
>
> -       return ret;
> -}
> -
> -/* Set current time and date in RTC */
> -static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
> -{
> -       struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> -       struct rk808 *rk808 = rk808_rtc->rk808;
> -       u8 rtc_data[NUM_TIME_REGS];
> -       int ret;
> -
> -       rtc_data[0] = bin2bcd(tm->tm_sec);
> -       rtc_data[1] = bin2bcd(tm->tm_min);
> -       rtc_data[2] = bin2bcd(tm->tm_hour);
> -       rtc_data[3] = bin2bcd(tm->tm_mday);
> -       rtc_data[4] = bin2bcd(tm->tm_mon + 1);
> -       rtc_data[5] = bin2bcd(tm->tm_year - 100);
> -       rtc_data[6] = bin2bcd(tm->tm_wday);
> -       dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
> -               1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> -               tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
> -
> -       /* Stop RTC while updating the RTC registers */
> -       ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> -                                BIT_RTC_CTRL_REG_STOP_RTC_M,
> -                                BIT_RTC_CTRL_REG_STOP_RTC_M);
> -       if (ret) {
> -               dev_err(dev, "Failed to update RTC control: %d\n", ret);
> -               return ret;
> +       if (tm->tm_mon == 10 && tm->tm_mday == 31) {
> +               dev_warn(dev, "correcting Nov 31st to Dec 1st (HW bug)\n");
> +               tm->tm_mon = 11;
> +               tm->tm_mday = 1;
> +               rk808_rtc_set_time(dev, tm);

If a device is in S3 for the whole day that the glitch occurs and then
we wake up then we'll end up thinking it's Dec 1st instead of Dec 2nd,
right?  That case _could_ be handled by knowing that the last time we
read the clock it was before 12/1 and that this time it is after
11/30.  Then we add the extra day.  In order to do this, we'd have to
know that we're on hardware with the glitch, which I guess could
either be done with a device tree property or by spending 1 second
probing the device at bootup (that would be a bit of a pain...).

Obviously the trick above wouldn't handle if the clock ticked when the
device was in S5, but I'd imagine that most systems treat the RTC as
slightly questionable on an initial bootup anyway (though I'd imagine
that they rely on it working across S3).

What do you think?  Is that a worthwhile thing to handle too?  It's
pretty common for me to not turn all my devices on every day.

-Doug

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
