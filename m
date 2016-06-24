Return-Path: <rtc-linux+bncBDP6N55ZUYDRBOG6W25QKGQECX3YGHY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id po17si1062332pab.2.2016.06.24.15.07.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 15:07:52 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id 66so10280198pfy.1
        for <rtc-linux@googlegroups.com>; Fri, 24 Jun 2016 15:07:52 -0700 (PDT)
Date: Fri, 24 Jun 2016 15:07:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 2/5] input: pmic8xxx-pwrkey: Add support
 for pm8018 pwrkey
Message-ID: <20160624220748.GB11719@dtor-ws>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jun 24, 2016 at 11:18:04AM +0200, Neil Armstrong wrote:
> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
> for the pm8018 pwrkey in pmic8xxx-pwrkey.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

NAK.

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
