Return-Path: <rtc-linux+bncBDA7X7F2WUEBBOVH4PBQKGQEXSKARSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id l66si153576wml.0.2017.01.13.05.18.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 05:18:50 -0800 (PST)
Received: by mail-wm0-x22d.google.com with SMTP id r126so64802088wmr.0
        for <rtc-linux@googlegroups.com>; Fri, 13 Jan 2017 05:18:50 -0800 (PST)
Date: Fri, 13 Jan 2017 13:22:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Barber <smbarber@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [rtc-linux] Re: [PATCH 1/4] mfd: cros_ec: Add helper for event notifier.
Message-ID: <20170113132238.GB6864@dell>
References: <20170111165221.17337-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170111165221.17337-1-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 11 Jan 2017, Enric Balletbo i Serra wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
>=20
> Add cros_ec_get_event() entry point to retrieve event within functions
> called by the notifier.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 20 ++++++++++++++++++++

>  include/linux/mfd/cros_ec.h             | 10 ++++++++++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/c=
hrome/cros_ec_proto.c
> index ed5dee7..7428c2b 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -494,3 +494,23 @@ int cros_ec_get_next_event(struct cros_ec_device *ec=
_dev)
>  		return get_keyboard_state_event(ec_dev);
>  }
>  EXPORT_SYMBOL(cros_ec_get_next_event);
> +
> +u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
> +{
> +	u32 host_event;
> +
> +	BUG_ON(!ec_dev->mkbp_event_supported);
> +
> +	if (ec_dev->event_data.event_type !=3D EC_MKBP_EVENT_HOST_EVENT)
> +		return 0;
> +
> +	if (ec_dev->event_size !=3D sizeof(host_event)) {
> +		dev_warn(ec_dev->dev, "Invalid host event size\n");
> +		return 0;
> +	}
> +
> +	host_event =3D get_unaligned_le32(&ec_dev->event_data.data.host_event);
> +
> +	return host_event;
> +}
> +EXPORT_SYMBOL(cros_ec_get_host_event);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index b3d04de..be2c4eb 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -299,6 +299,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)=
;
>   */
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
> =20
> +/**
> + * cros_ec_get_host_event - Return a mask of event set by the EC.
> + *
> + * When MKBP is supported, when the EC raises an interrupt,
> + * We collect the events raised and call the functions in the ec notifie=
r.
> + *
> + * This function is a helper to know which events are raised.
> + */
> +u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> +
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;

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
