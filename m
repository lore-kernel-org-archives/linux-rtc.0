Return-Path: <rtc-linux+bncBDA7X7F2WUEBBHMNYXGAKGQE7UUTAYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com. [2a00:1450:400c:c09::234])
        by gmr-mx.google.com with ESMTPS id b82si240122wmd.5.2017.08.13.23.43.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Aug 2017 23:43:41 -0700 (PDT)
Received: by mail-wm0-x234.google.com with SMTP id m85so30528781wma.0
        for <rtc-linux@googlegroups.com>; Sun, 13 Aug 2017 23:43:41 -0700 (PDT)
Date: Mon, 14 Aug 2017 07:43:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out
 of I2C realm
Message-ID: <20170814064336.secnn77amfjgbltw@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
 <20170523071727.tw6vblpnevihqgqk@dell>
 <20170813133418.e7lftrmry3gu3dcc@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170813133418.e7lftrmry3gu3dcc@ninjato>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 13 Aug 2017, Wolfram Sang wrote:

> On Tue, May 23, 2017 at 08:17:27AM +0100, Lee Jones wrote:
> > On Mon, 22 May 2017, Wolfram Sang wrote:
> >=20
> > > include/linux/i2c is not for client devices. Move the header file to =
a
> > > more appropriate location.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > ---
> > >  drivers/input/misc/dm355evm_keys.c        | 2 +-
> >=20
> > >  drivers/mfd/dm355evm_msp.c                | 2 +-
> >=20
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>=20
> Does that mean it will be in 4.14? Or is something else needed?

Can this patch be applied on its own, or does it have dependencies?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
