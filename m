Return-Path: <rtc-linux+bncBDAYD2P3QYGRBWFGX65QKGQE4EL2FYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id f70si38666wmf.0.2016.06.26.06.06.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2016 06:06:31 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id f126so70101436wma.1
        for <rtc-linux@googlegroups.com>; Sun, 26 Jun 2016 06:06:31 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 2/5] input: pmic8xxx-pwrkey: Add support
 for pm8018 pwrkey
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
 <20160624220748.GB11719@dtor-ws> <576E41FC.1080102@baylibre.com>
 <20160625155349.GD17812@dtor-ws>
Cc: andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org,
 lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 Rob Herring <robh@kernel.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <576FD356.70002@baylibre.com>
Date: Sun, 26 Jun 2016 15:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160625155349.GD17812@dtor-ws>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/25/2016 05:53 PM, Dmitry Torokhov wrote:
> On Sat, Jun 25, 2016 at 10:34:04AM +0200, Neil Armstrong wrote:
>> On 06/25/2016 12:07 AM, Dmitry Torokhov wrote:
>>> On Fri, Jun 24, 2016 at 11:18:04AM +0200, Neil Armstrong wrote:
>>>> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
>>>> for the pm8018 pwrkey in pmic8xxx-pwrkey.
>>>>
>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> NAK.
>>
>> Hi Dmitry,
>>
>> Actually, the new compatible string make sense, because the driver is compatible with the
>> "pm8018" pwrkey but from a system point of view, it's not a pm8921 pwrkey, hence the new
>> compatible string.
> 
> A lot of systems note this fact in DTS, but not require driver changes,
> by specifying several compatible strings:
> 
> 	compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
> 	compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
> 	compatible = "rockchip,rk3036-timer", "rockchip,rk3288-timer";

Sure, your point is valid.
But here, the situation is quite different, the question is about confidence.
>From the system point of view, I'm 100% sure there is a pm8010-pwrkey variant here, but
I`m not convinced at all how it is similar from the 8921 version.
>From the software point of view, I'm 80% sure the *actual* driver in it current form
somehow works for the pm8018-pwrkey, not more.
If somehow the driver is updated to support a 8921 feature that is not supported by the
8018 version, it will rely on the compatible string to make this a smart move.
Since I do not have the pm8018 datasheet and the 8921 either, I cannot statue on this,
So the smartest move from my side is to actually have a different compatible string
to avoid future blocking situations.

>>
>> Rob Herring was very clear with me with this policy, and it will simplify further driver
> 
> Could I get a pointer to this discussion so I can educate myself better
> about DT policies?

I had quite a lot of comments on the OXNAS support push (started here https://lkml.org/lkml/2016/3/3/495) were
the policy was to narrow the new compatible strings to a SoC specific naming.
For the qcom driver, the strings the already compliant and why not continue with the pm8018 ?

>> architecture change since it will not imply devicetree changes anymore.
> 
> Would we need the driver changes? What are the differences in power key
> functionality between 8018 and 8921?

You raise the biggest question, I do not know, so why should we say the pm8018-pwrkey /is/ compatible with pm8921-pwronly only by looking existing driver ?

>>
>> My point of view is that the devicetree describes the hardware and need to have SoC specific
>> compatible string since it describes the actual silicon, and drivers must make sure to handle
>> all the SoC or family variants using the compatible string and the match data.
> 
> No, the compatible string means that the hardware is *compatible* with
> something. It does not mean that we need to adjust driver every time a
> company pumps out a new package including said hardware.

It was something that I questionned myself about, but it seems the maintainers agrees quite easily to accept these compatible adding patches
like the USB Ids or PCI ids patches.

Regards,
Neil

> Thanks.
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
