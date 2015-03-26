Return-Path: <rtc-linux+bncBDA7X7F2WUEBBKVK2CUAKGQE2PV4CRA@googlegroups.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com. [209.85.212.175])
        by gmr-mx.google.com with ESMTPS id sf8si450161wic.2.2015.03.26.07.18.16
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 07:18:16 -0700 (PDT)
Received: by mail-wi0-f175.google.com with SMTP id g7so17605688wib.1
        for <rtc-linux@googlegroups.com>; Thu, 26 Mar 2015 07:18:16 -0700 (PDT)
Date: Thu, 26 Mar 2015 14:18:12 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, Sangbeom Kim <sbkim73@samsung.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [rtc-linux] Re: [PATCH v2 2/2] mfd: sec-core: Modify RTC
 compatible name of S2MPS13
Message-ID: <20150326141812.GO5951@x1>
References: <1426586058-15987-1-git-send-email-k.kozlowski@samsung.com>
 <1426586058-15987-2-git-send-email-k.kozlowski@samsung.com>
 <20150323123458.GE24804@x1>
 <CAJKOXPeh1McgSxJD23G=2QijRAQM2YGHbDFeGiA4bQQ-mRX-FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJKOXPeh1McgSxJD23G=2QijRAQM2YGHbDFeGiA4bQQ-mRX-FA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 24 Mar 2015, Krzysztof Kozlowski wrote:

> 2015-03-23 13:34 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> > On Tue, 17 Mar 2015, Krzysztof Kozlowski wrote:
> >
> >> From: Chanwoo Choi <cw00.choi@samsung.com>
> >>
> >> This patch modify the RTC compatible name of S2MPS13 because S2MPS13's=
 RTC is
> >> equal to S2MPS14's RTC.
> >>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. New patch.
> >> ---
> >>  drivers/mfd/sec-core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied, thanks.
>=20
> Hi,
>=20
> Sorry for the mess but we did this wrong.
> The S2MPS13 RTC is slightly different than S2MPS14 and that difference
> is important. It is embarrassing... but the difference was written
> small-print as a note in datasheet. Really. I found it after carefully
> comparing two PDFs. The impact of difference was not detected because
> of error in DTS for Exynos5433-based board.
>=20
> This patch should be dropped (or reverted) and "s2mps13-rtc" should be
> used for S2MPS13 RTC mfd_cell. The RTC driver (rtc/rtxc-s5m) should
> have its own support for RTC which I will add in separate patch.
>=20
> Lee, once again sorry for the mess. How would you like to proceed? Can
> you just drop this commit?

Patch removed -- panic averted.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
