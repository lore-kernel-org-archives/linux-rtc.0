Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXNH4PBQKGQEKX5KUIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id 133si137774wmj.1.2017.01.13.05.19.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 05:19:25 -0800 (PST)
Received: by mail-wm0-x22a.google.com with SMTP id c85so64053568wmi.1
        for <rtc-linux@googlegroups.com>; Fri, 13 Jan 2017 05:19:25 -0800 (PST)
Date: Fri, 13 Jan 2017 13:23:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH 2/4] mfd: cros_ec: Introduce RTC commands and
 events definitions.
Message-ID: <20170113132315.GC6864@dell>
References: <20170111165221.17337-1-enric.balletbo@collabora.com>
 <20170111165221.17337-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170111165221.17337-2-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 11 Jan 2017, Enric Balletbo i Serra wrote:

> From: Stephen Barber <smbarber@chromium.org>
>=20
> The EC can function as a simple RT, this patch adds the RTC related
> definitions needed by the rtc-cros-ec driver.
>=20
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index 80d401d..73f7a62 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -286,6 +286,9 @@ enum host_event_code {
>  	/* Hang detect logic detected a hang and warm rebooted the AP */
>  	EC_HOST_EVENT_HANG_REBOOT =3D 21,
> =20
> +	/* EC RTC event occurred */
> +	EC_HOST_EVENT_RTC =3D 26,
> +
>  	/*
>  	 * The high bit of the event mask is not used as a host event code.  If
>  	 * it reads back as set, then the entire event mask should be
> @@ -790,6 +793,8 @@ enum ec_feature_code {
>  	EC_FEATURE_USB_MUX =3D 23,
>  	/* Motion Sensor code has an internal software FIFO */
>  	EC_FEATURE_MOTION_SENSE_FIFO =3D 24,
> +	/* EC has RTC feature that can be controlled by host commands */
> +	EC_FEATURE_RTC =3D 27,
>  };
> =20
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> @@ -1682,6 +1687,9 @@ struct ec_response_rtc {
>  #define EC_CMD_RTC_SET_VALUE 0x46
>  #define EC_CMD_RTC_SET_ALARM 0x47
> =20
> +/* Pass as param to SET_ALARM to clear the current alarm */
> +#define EC_RTC_ALARM_CLEAR 0
> +
>  /***********************************************************************=
******/
>  /* Port80 log access */
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
