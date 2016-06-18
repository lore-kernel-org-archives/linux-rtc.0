Return-Path: <rtc-linux+bncBDP6N55ZUYDRBB7KSW5QKGQEQH6PA5A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id un17si3853825pab.0.2016.06.18.09.21.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 09:21:27 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id hf6so7814004pac.2
        for <rtc-linux@googlegroups.com>; Sat, 18 Jun 2016 09:21:27 -0700 (PDT)
Date: Sat, 18 Jun 2016 09:21:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/5] input: pmic8xxx-pwrkey: Add support for
 pm8018 pwrkey
Message-ID: <20160618162123.GA12210@dtor-ws>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466158929-19524-3-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Neil,

On Fri, Jun 17, 2016 at 12:22:06PM +0200, Neil Armstrong wrote:
> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
> for the pm8018 pwrkey in pmic8xxx-pwrkey.

Why do we need a new compat string if IP block is compatible with 8921?

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt | 1 +
>  drivers/input/misc/pmic8xxx-pwrkey.c                           | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> index 588536c..9e530e2 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
> @@ -8,6 +8,7 @@ PROPERTIES
>  	Definition: must be one of:
>  		    "qcom,pm8058-pwrkey"
>  		    "qcom,pm8921-pwrkey"
> +		    "qcom,pm8018-pwrkey"
>  
>  - reg:
>  	Usage: required
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> index 67aab86..f6f9b87 100644
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -446,6 +446,7 @@ static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
> +	{ .compatible = "qcom,pm8018-pwrkey", .data = &pm8921_pwrkey_shutdown },
>  	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
>  	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
>  	{ }
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
