Return-Path: <rtc-linux+bncBDP6N55ZUYDRBJWGVC5QKGQE7OGUWMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-vk0-x234.google.com (mail-vk0-x234.google.com. [2607:f8b0:400c:c05::234])
        by gmr-mx.google.com with ESMTPS id v190si1162289vkf.2.2016.06.21.22.33.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 22:33:25 -0700 (PDT)
Received: by mail-vk0-x234.google.com with SMTP id j2so48403211vkg.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 22:33:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160622052517.GJ1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-3-git-send-email-narmstrong@baylibre.com> <20160622052517.GJ1256@tuxbot>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 21 Jun 2016 22:33:25 -0700
Message-ID: <CAKdAkRQnKs1+3mEO0L_0kntm5EY93hnONpEj=kUA2m5iZhXUDg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/5] input: pmic8xxx-pwrkey: Add support for
 pm8018 pwrkey
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org,
	RTCLINUX <rtc-linux@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 21, 2016 at 10:25 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:
>
>> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
>> for the pm8018 pwrkey in pmic8xxx-pwrkey.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But why? What does this new compat string gives us if the behavior is
exactly the same as 8921?

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
