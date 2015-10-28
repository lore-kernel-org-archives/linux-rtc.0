Return-Path: <rtc-linux+bncBDKZNNNLXAHBBG46YOYQKGQEICNIFWI@googlegroups.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com. [2607:f8b0:400e:c03::22c])
        by gmr-mx.google.com with ESMTPS id el2si4825035pbb.0.2015.10.28.06.35.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 06:35:22 -0700 (PDT)
Received: by mail-pa0-x22c.google.com with SMTP id fv9so7865336pac.3
        for <rtc-linux@googlegroups.com>; Wed, 28 Oct 2015 06:35:22 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support
 for S2MPS15 RTC
To: Alim Akhtar <alim.akhtar@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com> <20151028015323.GZ28319@sirena.org.uk>
 <56303054.8060804@samsung.com> <56303DA3.5020306@samsung.com>
 <5630419F.1000300@samsung.com> <20151028094853.GM22331@piout.net>
 <5630A3E2.9010207@samsung.com>
Cc: k.kozlowski.k@gmail.com, Mark Brown <broonie@kernel.org>,
 lee.jones@linaro.org, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-ID: <5630CF15.50206@samsung.com>
Date: Wed, 28 Oct 2015 22:35:17 +0900
MIME-Version: 1.0
In-Reply-To: <5630A3E2.9010207@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

W dniu 28.10.2015 o 19:30, Alim Akhtar pisze:
> Hi Alexandre,
> 
> On 10/28/2015 03:18 PM, Alexandre Belloni wrote:
>> On 28/10/2015 at 12:31:43 +0900, Krzysztof Kozlowski wrote :
>>> The s2mps13 clock driver added new name and compatible... which was
>>> probably totally unneeded (I missed that during review). We don't have
>>> to make this as a rule...
>>>
>>> Since we do not have any data about future workarounds and the
>>> differences then just follow Ockham's razor - use the same name and
>>> compatible.
>>>
>>
>> So you don't care about DT backward compatibility because when a
>> workaround will be needed for one of the IPs, then you will have to
>> update the old dtb to use it.
>>
>> Unless you are sure that the IP is the same, doing
>>
>> { "s2mps15-rtc",    S2MPS14X },
>>
>> is probably the best way to handle that. Note that I personally don't
>> care about the DT ABI, I'm just pointing out what may happen ;)
>>
> Thats what my point is, anyway I am still looking into the fine prints
> of the s2mps15 and s2mps14 user manual, now I have found at least one
> difference in their one of the register bit, which might be a good
> reason to keep s2mps15-rtc device.

No, this is not a good reason. Devices may be different but from
driver's perspective they behave the same. This means for example that
they use the same compatible. They can use the same driver name.

We have for example AHCI driver for entire range of different devices.
Some of them are different enough that require special code. So they
have different name and compatible. All of other use the same ahci
driver. But devices are different...

Best regards,
Krzysztof

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
