Return-Path: <rtc-linux+bncBDA7X7F2WUEBBQHFS7CAKGQEEPXBLTY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id c129si588823wme.1.2017.01.23.04.10.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2017 04:10:40 -0800 (PST)
Received: by mail-wm0-x22e.google.com with SMTP id r144so151457025wme.1
        for <rtc-linux@googlegroups.com>; Mon, 23 Jan 2017 04:10:40 -0800 (PST)
Date: Mon, 23 Jan 2017 12:14:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v2 3/4] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20170123121438.GM16020@dell>
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-3-enric.balletbo@collabora.com>
 <20170122233232.iin6frv7hme2y2jw@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170122233232.iin6frv7hme2y2jw@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 23 Jan 2017, Alexandre Belloni wrote:

> On 19/01/2017 at 13:30:31 +0100, Enric Balletbo i Serra wrote :
> > From: Stephen Barber <smbarber@chromium.org>
> >=20
> > On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> > Add a basic driver with this functionality.
> >=20
> > Signed-off-by: Stephen Barber <smbarber@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>=20
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>=20
> Lee, this can go through the mfd tree. Hopefully, nobody will add a new
> driver nearby ;)

Yes, I can take the set, once all of the Acks are obtained.

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
