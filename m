Return-Path: <rtc-linux+bncBDA7X7F2WUEBBLNMWCVQKGQE76Q5L6Y@googlegroups.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com. [209.85.212.172])
        by gmr-mx.google.com with ESMTPS id k2si467790wif.0.2015.06.01.01.22.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 01:22:04 -0700 (PDT)
Received: by wizo1 with SMTP id o1so94526759wiz.1
        for <rtc-linux@googlegroups.com>; Mon, 01 Jun 2015 01:22:04 -0700 (PDT)
Date: Mon, 1 Jun 2015 09:22:00 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, sameo@linux.intel.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] Re: [PATCH 4/4] mfd: 88pm800: allocate pdata->rtc if not
 allocated earlier
Message-ID: <20150601082200.GC3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, 30 May 2015, Vaibhav Hiremath wrote:

> RTC in pmic 88PM800 can run even the core is powered off, and user
> can set alarm in RTC. When the alarm is timed out, the PMIC will power up
> the core, and the whole system will boot up. And during PMIC driver probe=
,
> it will read some register to find out whether this boot is caused by RTC
> timeout or not, and pass on this information to the RTC driver.
>=20
> So we need rtc platform data to be existed in PMIC driver to pass this
> information.
>=20
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 8ea4467..34546a1 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -586,6 +586,25 @@ static int pm800_probe(struct i2c_client *client,
>  			return ret;
>  	}
> =20
> +	/*
> +	 * RTC in pmic can run even the core is powered off, and user can set
> +	 * alarm in RTC. When the alarm is time out, the PMIC will power up
> +	 * the core, and the whole system will boot up. When PMIC driver is
> +	 * probed, it will read out some register to find out whether this
> +	 * boot is caused by RTC timeout or not, and it need pass this
> +	 * information to RTC driver.
> +	 * So we need rtc platform data to be existed to pass this information.
> +	 */
> +	if (!pdata->rtc) {
> +		pdata->rtc =3D devm_kzalloc(&client->dev,
> +					  sizeof(*(pdata->rtc)), GFP_KERNEL);
> +		if (!pdata->rtc) {
> +			dev_err(&client->dev,
> +					"failed to allocate memory for rtc\n");
> +			return -ENOMEM;
> +		}
> +	}
> +

Where is this memory first used?

>  	ret =3D pm80x_init(client);
>  	if (ret) {
>  		dev_err(&client->dev, "pm800_init fail\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
