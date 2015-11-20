Return-Path: <rtc-linux+bncBDA7X7F2WUEBBW6EXOZAKGQEWSSBFZQ@googlegroups.com>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id m135si102677wmb.0.2015.11.20.01.05.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2015 01:05:31 -0800 (PST)
Received: by mail-wm0-x235.google.com with SMTP id w144so11958729wmw.0
        for <rtc-linux@googlegroups.com>; Fri, 20 Nov 2015 01:05:31 -0800 (PST)
Date: Fri, 20 Nov 2015 09:05:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, broonie@kernel.org,
	Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v5 0/4] mfd: sec: add S2MPS15 PMIC support
Message-ID: <20151120090528.GC3098@x1>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ51aPo3rdB6R6x-Y4SUD4nsAcUo3X5XoEUSg0gfxuJpdyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAGOxZ51aPo3rdB6R6x-Y4SUD4nsAcUo3X5XoEUSg0gfxuJpdyQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 19 Nov 2015, Alim Akhtar wrote:

> Hi Lee,
> Do I need to resend this series? This series still apply cleanly on
> top of v4.4-rc1.
> I can see 1/4 is already applied.

Yes, rebase and resend please.

> On Fri, Oct 30, 2015 at 11:55 AM, Alim Akhtar <alim.akhtar@samsung.com> w=
rote:
> > Samsung's S2MPS15 PMIC is targetted to be used with Samsung's Exynos7 S=
oC.
> > The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It con=
tains
> > 27 LDO and 10 Buck regulators, RTC, three 32.768 KHz clock outputs and =
allows
> > programming these blocks via a I2C interface. This patch series adds in=
itial
> > support for LDO/Buck regulators of S2MPS15 PMIC.
> >
> > Changes since v4:
> > * Dorpped Krzysztof reviewed-by and Lee Acked-by tags from patch 1/4,
> >   because of the new changes to DT bindings. Seeking a fresh review/ack=
 tags.
> > * Removed samsung,s2mps15-clk compatible as we can reuse exsisting comp=
atible of s2mps13.
> > * Added acked-by on patch 2/4
> > * Modified rtc driver as s2mps15 differs from s2mps14/13 etc, addressed=
 Krzysztof
> >   concerns on rtc patch.
> >   There are some other improvement suggestion from Krzystof for the rtc=
, I feel that can be done
> >   as a sperate patch later.
> >
> > Changes since v3:
> > * Changes regulator driver name from s2mps15-pmic -> s2mps15-regulator =
as disscussed here [2]
> > * Re-use the exsisting compatible/names for s2mps15 clock block.
> >
> > Changes since v2:
> > * Addressed Lee Jones review comments.
> >
> > Changes since v1:
> > * Added suggestion from Krzysztof [1].
> > * Added s2mps15's 32.768 clocks support.
> > * Added s2mps15's rtc support.
> >
> > V1 of these patches (with a lesser features) were posted a year back,
> > since then there is not much progress on this, this is my attempt to
> > move things forward.
> >
> > [1]-> https://lkml.org/lkml/2014/10/14/67
> > [2]-> https://lkml.org/lkml/2015/10/28/417
> >
> > This series is based on linux-next-20151022.
> > This is tested on exynos7-espresso board.
> >
> > Alim Akhtar (1):
> >   drivers/rtc/rtc-s5m.c: add support for S2MPS15 RTC
> >
> > Thomas Abraham (3):
> >   dt-bindings: mfd: s2mps11: add documentation for s2mps15 PMIC
> >   mfd: sec: Add support for S2MPS15 PMIC
> >   regulator: s2mps11: add support for S2MPS15 regulators
> >
> >  Documentation/devicetree/bindings/mfd/s2mps11.txt |   21 ++-
> >  drivers/mfd/sec-core.c                            |   31 ++++
> >  drivers/mfd/sec-irq.c                             |    8 ++
> >  drivers/regulator/Kconfig                         |    4 +-
> >  drivers/regulator/s2mps11.c                       |  135 +++++++++++++=
++++-
> >  drivers/rtc/rtc-s5m.c                             |   37 ++++-
> >  include/linux/mfd/samsung/core.h                  |    1 +
> >  include/linux/mfd/samsung/rtc.h                   |    2 +
> >  include/linux/mfd/samsung/s2mps15.h               |  158 +++++++++++++=
++++++++
> >  9 files changed, 383 insertions(+), 14 deletions(-)
> >  create mode 100644 include/linux/mfd/samsung/s2mps15.h
> >
> >
>=20
>=20
>=20

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
