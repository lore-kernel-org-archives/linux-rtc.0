Return-Path: <rtc-linux+bncBDS7HNEFSALRB4PQ5K4AKGQEOWXLCRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u137si122494wmd.1.2016.04.22.16.49.04
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Apr 2016 16:49:04 -0700 (PDT)
Date: Sat, 23 Apr 2016 01:48:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/6] rtc: rv3029: add alarm IRQ
Message-ID: <20160422234854.GI17051@piout.net>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com>
 <a3a20f7842d11e73e5dd41201a77bca3108e6b75.1461250479.git.mylene.josserand@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <a3a20f7842d11e73e5dd41201a77bca3108e6b75.1461250479.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2016 at 20:24:19 +0200, Myl=C4=8Dne Josserand wrote :
> @@ -731,11 +786,9 @@ static void rv3029_hwmon_register(struct device *dev=
, const char *name)
> =20
>  #endif /* CONFIG_RTC_DRV_RV3029_HWMON */
> =20
> -static const struct rtc_class_ops rv3029_rtc_ops =3D {
> +static struct rtc_class_ops rv3029_rtc_ops =3D {
>  	.read_time	=3D rv3029_read_time,
>  	.set_time	=3D rv3029_set_time,
> -	.read_alarm	=3D rv3029_read_alarm,
> -	.set_alarm	=3D rv3029_set_alarm,
>  };
> =20
>  static struct i2c_device_id rv3029_id[] =3D {
> @@ -772,8 +825,27 @@ static int rv3029_probe(struct device *dev, struct r=
egmap *regmap, int irq,
> =20
>  	rv3029->rtc =3D devm_rtc_device_register(dev, name, &rv3029_rtc_ops,
>  					       THIS_MODULE);
> +	if (IS_ERR(rv3029->rtc)) {
> +		dev_err(dev, "unable to register the class device\n");
> +		return PTR_ERR(rv3029->rtc);
> +	}
> =20
> -	return PTR_ERR_OR_ZERO(rv3029->rtc);
> +	if (rv3029->irq > 0) {
> +		rc =3D devm_request_threaded_irq(dev, rv3029->irq,
> +					       NULL, rv3029_handle_irq,
> +					       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					       "rv3029", dev);
> +		if (rc) {
> +			dev_warn(dev, "unable to request IRQ, alarms disabled\n");
> +			rv3029->irq =3D 0;
> +		} else {
> +			rv3029_rtc_ops.read_alarm =3D rv3029_read_alarm;
> +			rv3029_rtc_ops.set_alarm =3D rv3029_set_alarm;
> +			rv3029_rtc_ops.alarm_irq_enable =3D rv3029_alarm_irq_enable;
> +		}
> +	}
> +

While this work, devm_rtc_device_register() needs to know whether the
alarms are enabled and will try to call .read_alarm(). That is not
completely an issue right now and as we discussed, I'm planning to send
a rework of the rtc core to overcome that issue.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
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
