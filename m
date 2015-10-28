Return-Path: <rtc-linux+bncBDKZNNNLXAHBBXXAYCYQKGQECSAKUSQ@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id vy6si4527878pbc.1.2015.10.27.19.18.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 19:18:06 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWW000TLRQ15700@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 28 Oct 2015 02:18:02 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
To: Mark Brown <broonie@kernel.org>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com> <20151028015323.GZ28319@sirena.org.uk>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
 mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56303054.8060804@samsung.com>
Date: Wed, 28 Oct 2015 11:17:56 +0900
MIME-version: 1.0
In-reply-to: <20151028015323.GZ28319@sirena.org.uk>
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

On 28.10.2015 10:53, Mark Brown wrote:
> On Wed, Oct 28, 2015 at 10:29:56AM +0900, Krzysztof Kozlowski wrote:
> 
>> If that's true, then don't add new compatibles, new names etc. Re-use.
>> No new code needed, no changes needed. Keep it simple.
> 
> Well, it depends - it can be useful to get the information about it
> being a different part into DT so that if in future we realise that
> there is some difference (perhaps a bug workaround even if the IP is
> intended to be the same).  Though in the case of a MFD that information
> can be obtained from the MFD for the device.

We can always differentiate later and introduce new compatible.
Declaring a compatible right now would be useful only if we really cared
about using the workaround on older DTBs.

Since I cannot judge the difference (I don't have the datasheet of
S2MPS15) then I don't see the need of adding new compatible/name for the
"same device".

Of course maybe there is such need? Alim?

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
