Return-Path: <rtc-linux+bncBC2JZN6WSAHRBJV2VC5QKGQE7KX5NIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com. [2607:f8b0:400e:c03::22b])
        by gmr-mx.google.com with ESMTPS id 62si8056817pfx.1.2016.06.21.22.07.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 22:07:50 -0700 (PDT)
Received: by mail-pa0-x22b.google.com with SMTP id hl6so13142714pac.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 22:07:50 -0700 (PDT)
Date: Tue, 21 Jun 2016 22:07:46 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/5] mfd: pm8921: Add support for pm8018
Message-ID: <20160622050746.GH1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466158929-19524-2-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> In order to support the Qualcomm MDM9615 PMIC, add support for the
> pm8018 in pm8921 mfd driver.
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
