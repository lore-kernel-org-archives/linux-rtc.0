Return-Path: <rtc-linux+bncBCU2BBWH4IORBVOO2LIQKGQEGCWHKHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com. [2607:f8b0:4001:c0b::241])
        by gmr-mx.google.com with ESMTPS id e18si407302qtc.5.2017.12.15.20.55.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 20:55:48 -0800 (PST)
Received: by mail-it0-x241.google.com with SMTP id t1so22850558ite.5
        for <rtc-linux@googlegroups.com>; Fri, 15 Dec 2017 20:55:48 -0800 (PST)
Date: Fri, 15 Dec 2017 20:55:44 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v4 1/2] mfd: cros_ec: Introduce RTC commands
 and events definitions.
Message-ID: <20171216045542.GA52366@google.com>
References: <20171110215553.20696-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20171110215553.20696-2-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Fri, Nov 10, 2017 at 10:55:52PM +0100, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
> 
> The EC can function as a simple RT, this patch adds the RTC related
> definitions needed by the rtc-cros-ec driver.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>

I guess this is waiting to get merged by an RTC maintainer, since it's a
dependency for the RTC driver in patch 2? Alessandro or Alexandre, any
thoughts?

Brian

> ---
>  include/linux/mfd/cros_ec_commands.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 2b16e95..c6046a2 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -291,6 +291,9 @@ enum host_event_code {
>  	/* EC desires to change state of host-controlled USB mux */
>  	EC_HOST_EVENT_USB_MUX = 28,
>  
> +	/* EC RTC event occurred */
> +	EC_HOST_EVENT_RTC = 26,
> +
>  	/*
>  	 * The high bit of the event mask is not used as a host event code.  If
>  	 * it reads back as set, then the entire event mask should be
> @@ -799,6 +802,8 @@ enum ec_feature_code {
>  	EC_FEATURE_USB_MUX = 23,
>  	/* Motion Sensor code has an internal software FIFO */
>  	EC_FEATURE_MOTION_SENSE_FIFO = 24,
> +	/* EC has RTC feature that can be controlled by host commands */
> +	EC_FEATURE_RTC = 27,
>  };
>  
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> @@ -1709,6 +1714,9 @@ struct ec_response_rtc {
>  #define EC_CMD_RTC_SET_VALUE 0x46
>  #define EC_CMD_RTC_SET_ALARM 0x47
>  
> +/* Pass as param to SET_ALARM to clear the current alarm */
> +#define EC_RTC_ALARM_CLEAR 0
> +
>  /*****************************************************************************/
>  /* Port80 log access */
>  

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
