Return-Path: <rtc-linux+bncBDA7X7F2WUEBB3MD3WYQKGQEK7FKTFA@googlegroups.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id g18si489859wmd.1.2015.11.02.02.58.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 02:58:52 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id f134so55245772wmf.1
        for <rtc-linux@googlegroups.com>; Mon, 02 Nov 2015 02:58:52 -0800 (PST)
Date: Mon, 2 Nov 2015 10:58:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>, broonie@kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Message-ID: <20151102105849.GV4058@x1>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-5-git-send-email-alim.akhtar@samsung.com>
 <20151101174048.GD22331@piout.net>
 <5636A44D.4090908@samsung.com>
 <20151102004722.GI22331@piout.net>
 <20151102090359.GR4058@x1>
 <20151102101931.GK22331@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151102101931.GK22331@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 02 Nov 2015, Alexandre Belloni wrote:

> On 02/11/2015 at 09:03:59 +0000, Lee Jones wrote :
> > > > I think you cannot apply it directly because it depends on headers =
from
> > > > patch 2/4. It won't build.
> > > >=20
> > >=20
> > > Yeah, this depends on the mfd tree. I don't thin Lee applied patch 2/=
4
> > > yet so I'm taking that one for 4.5.
> >=20
> > I don't mind if you take it, but if you do so you need to take the
> > Regulator patch as well AND provide Mark and I a pull-request from an
> > immutable branch please.=20
> >=20
>=20
> Actually, I was thinking that you would take 2/4 through your tree and I
> would either base myself on that or delay the patch for 4.5. You could
> also take the rtc patch if you plan to apply 2/4, feel free to add my
> acked-by.

Perfect.  I will do the latter.

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
