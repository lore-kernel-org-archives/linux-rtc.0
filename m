Return-Path: <rtc-linux+bncBC2JZN6WSAHRB4VZVC5QKGQELRGPXLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com. [2607:f8b0:400e:c00::233])
        by gmr-mx.google.com with ESMTPS id c11si6782563pfc.2.2016.06.21.22.06.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 22:06:57 -0700 (PDT)
Received: by mail-pf0-x233.google.com with SMTP id t190so13763201pfb.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 22:06:57 -0700 (PDT)
Date: Tue, 21 Jun 2016 22:06:54 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/5] rtc: rtc-pm8xxx: Add support for pm8018 rtc
Message-ID: <20160622050654.GG1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-4-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466158929-19524-4-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> In order to support RTC on Qualcomm MDM9615 SoC, add support for
> the pm8018 rtc in rtc-pm8xxx driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt |  1 +
>  drivers/rtc/rtc-pm8xxx.c                              | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> index f24f334..37a088f 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
> @@ -62,6 +62,7 @@ The below bindings specify the set of valid subnodes.
>  		    "qcom,pm8058-rtc"
>  		    "qcom,pm8921-rtc"
>  		    "qcom,pm8941-rtc"
> +		    "qcom,pm8018-rtc"

Would be nice if we kept this sorted, but the patch looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
