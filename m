Return-Path: <rtc-linux+bncBDA7X7F2WUEBBD6DRTCQKGQEPZGYYDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id f7si164322wmg.3.2017.02.14.07.26.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 07:26:07 -0800 (PST)
Received: by mail-wm0-x22d.google.com with SMTP id v77so19622353wmv.0
        for <rtc-linux@googlegroups.com>; Tue, 14 Feb 2017 07:26:07 -0800 (PST)
Date: Tue, 14 Feb 2017 15:26:04 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v2 3/4] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20170214152604.bvaiujkln6uo656w@dell>
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-3-enric.balletbo@collabora.com>
 <20170122233232.iin6frv7hme2y2jw@piout.net>
 <20170123121438.GM16020@dell>
 <c492877b-5bd1-511a-7591-b4ff911ceabc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <c492877b-5bd1-511a-7591-b4ff911ceabc@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 14 Feb 2017, Enric Balletbo i Serra wrote:

> Hi Lee,
>=20
> On 23/01/17 13:14, Lee Jones wrote:
> > On Mon, 23 Jan 2017, Alexandre Belloni wrote:
> >=20
> >> On 19/01/2017 at 13:30:31 +0100, Enric Balletbo i Serra wrote :
> >>> From: Stephen Barber <smbarber@chromium.org>
> >>>
> >>> On platforms with a Chrome OS EC, the EC can function as a simple RTC=
.
> >>> Add a basic driver with this functionality.
> >>>
> >>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>
> >> Lee, this can go through the mfd tree. Hopefully, nobody will add a ne=
w
> >> driver nearby ;)
> >=20
> > Yes, I can take the set, once all of the Acks are obtained.
> >=20
>=20
> Now that the patch series have all the acks, this will finally go through=
 the mfd tree?
>=20
> I suppose is too late for the upcoming merge window ... so just want to m=
ake sure which tree I should monitor to not forget it :)

You need to submit it, complete with all the Acks you received.

Yes, it's too late for this cycle.

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
