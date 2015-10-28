Return-Path: <rtc-linux+bncBDKZNNNLXAHBBKEDYGYQKGQEGJRWPIQ@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id el2si4603932pbb.0.2015.10.27.20.31.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 20:31:52 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWW0009MV505710@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 28 Oct 2015 03:31:48 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
To: Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com> <20151028015323.GZ28319@sirena.org.uk>
 <56303054.8060804@samsung.com> <56303DA3.5020306@samsung.com>
Cc: lee.jones@linaro.org, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5630419F.1000300@samsung.com>
Date: Wed, 28 Oct 2015 12:31:43 +0900
MIME-version: 1.0
In-reply-to: <56303DA3.5020306@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28.10.2015 12:14, Alim Akhtar wrote:
> Hello,
> 
> On 10/28/2015 07:47 AM, Krzysztof Kozlowski wrote:
>> On 28.10.2015 10:53, Mark Brown wrote:
>>> On Wed, Oct 28, 2015 at 10:29:56AM +0900, Krzysztof Kozlowski wrote:
>>>
>>>> If that's true, then don't add new compatibles, new names etc. Re-use.
>>>> No new code needed, no changes needed. Keep it simple.
>>>
>>> Well, it depends - it can be useful to get the information about it
>>> being a different part into DT so that if in future we realise that
>>> there is some difference (perhaps a bug workaround even if the IP is
>>> intended to be the same).  Though in the case of a MFD that information
>>> can be obtained from the MFD for the device.
>>
>> We can always differentiate later and introduce new compatible.
>> Declaring a compatible right now would be useful only if we really cared
>> about using the workaround on older DTBs.
>>
>> Since I cannot judge the difference (I don't have the datasheet of
>> S2MPS15) then I don't see the need of adding new compatible/name for the
>> "same device".
>>
>> Of course maybe there is such need? Alim?
>>
> Well I did think of keeping the changes as minimal as possible, like
> just have "{ "s2mps15-rtc",        S2MPS14X }", since I don't have
> access to s2mps14 UM, I could not confirm that s2mps14 and s2mps15 are
> exactly the same w.r.t rtc block. So I proposed the current changes.
> 
> Well I do agree with Mark here, a name/compatible matching with the pmic
> is good to at least avoid confusion while looking at the sysfs.

What kind of confusion in sysfs? I don't see any... and already the
s2mps14-rtc name is used for S2MPS11 and S2MPS14.

The s2mps13 clock driver added new name and compatible... which was
probably totally unneeded (I missed that during review). We don't have
to make this as a rule...

Since we do not have any data about future workarounds and the
differences then just follow Ockham's razor - use the same name and
compatible.

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
