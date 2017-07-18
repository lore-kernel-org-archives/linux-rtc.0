Return-Path: <rtc-linux+bncBDA7X7F2WUEBBDNFW7FQKGQEZRRSYEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x234.google.com (mail-wr0-x234.google.com. [2a00:1450:400c:c0c::234])
        by gmr-mx.google.com with ESMTPS id s196si920788wmb.5.2017.07.18.02.19.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 02:19:09 -0700 (PDT)
Received: by mail-wr0-x234.google.com with SMTP id a10so19828857wrd.0
        for <rtc-linux@googlegroups.com>; Tue, 18 Jul 2017 02:19:09 -0700 (PDT)
Date: Tue, 18 Jul 2017 10:19:06 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Javier Martinez Canillas <martinez.javier@gmail.com>,
	Guenter Roeck <groeck@chromium.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 1/4] mfd: cros_ec: Get rid of
 cros_ec_check_features from cros_ec_dev.
Message-ID: <20170718091906.trvcaacdfrizjfks@dell>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-2-enric.balletbo@collabora.com>
 <CAMHSBOUT2hpcXrSuvRrZfnEXWtN9QfNLqHvM4TCvHPKiokP0Ag@mail.gmail.com>
 <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 17 Jul 2017, Enric Balletbo Serra wrote:

> Hi Gwendal,
>=20
> 2017-07-13 22:33 GMT+02:00 Gwendal Grignou <gwendal@chromium.org>:
> > On Wed, Jul 12, 2017 at 3:13 AM, Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >> The cros_ec_dev driver should be used only to expose the Chrome OS Emb=
edded
> >> Controller to user-space and should not be used to add MFD devices by
> >> calling mfd_add_devices. This patch moves this logic to the MFD cros_e=
c
> >> driver and removes the MFD bits from the character device driver. Also
> >> makes independent the IIO driver from the character device as also has=
 no
> >> sense.
> >
> > cros_ec_dev serves another purpose: it allows to represent an EC that
> > does not have a cros_ec structure. It happens when there are several
> > EC in a chromebook, and one EC is connected through another EC.
> > One example is Samus (Pixel 2): where we have:
> >
> > (main SOC, Application Processor) AP --> (main Embedded Controller) EC
> > ---> (Power Delivery [PD}) EC
> >
> > We  access to the PD EC via pass-through commands through the main EC.
> > Each EC has a cros_ec_dev structure, but only the main EC as a
> > cros_ec_device structure (I will forever regret the structure names).
> >
> > Now form the AP point of view, both ECs use the same protocol. That
> > why the sensors and other devcies that are registered by looking at
> > the feature fields are registered with cros_ec_dev as their parent.
> > Other devices that are registered from the device tree, predating the
> > feature field support, are registered with cros_ec_device as their
> > parent.
> >
>=20
> Interesting I didn't know that. So are you saying that this patch will
> break support for devices like Pixel 2? I tested the patches on
> various devices but not on Pixel 2 so could be.

Does this affect the rest of the series?

Or should I review/apply as usual?

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
