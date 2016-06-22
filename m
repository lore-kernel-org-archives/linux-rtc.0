Return-Path: <rtc-linux+bncBC2JZN6WSAHRBQGCVC5QKGQERGMKGRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com. [2607:f8b0:400e:c00::230])
        by gmr-mx.google.com with ESMTPS id c11si6793621pfc.2.2016.06.21.22.25.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 22:25:20 -0700 (PDT)
Received: by mail-pf0-x230.google.com with SMTP id h14so13933981pfe.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 22:25:20 -0700 (PDT)
Date: Tue, 21 Jun 2016 22:25:17 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/5] input: pmic8xxx-pwrkey: Add support for
 pm8018 pwrkey
Message-ID: <20160622052517.GJ1256@tuxbot>
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

On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
> for the pm8018 pwrkey in pmic8xxx-pwrkey.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

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
