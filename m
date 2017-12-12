Return-Path: <rtc-linux+bncBDKY3XOCXMIBBNPRX7IQKGQEVBTFHMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qt0-x22a.google.com (mail-qt0-x22a.google.com. [2607:f8b0:400d:c0d::22a])
        by gmr-mx.google.com with ESMTPS id s6si598199ybg.2.2017.12.12.07.41.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 07:41:41 -0800 (PST)
Received: by mail-qt0-x22a.google.com with SMTP id f2so48241179qtj.4
        for <rtc-linux@googlegroups.com>; Tue, 12 Dec 2017 07:41:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171110215553.20696-1-enric.balletbo@collabora.com>
References: <20171110215553.20696-1-enric.balletbo@collabora.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 12 Dec 2017 16:41:39 +0100
Message-ID: <CAFqH_53pDkcXXpzvPqF9OS0ahmhHCV87925E82d0p7ym5gq=VQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 0/2] Add support for cros-ec-rtc driver.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

+   Alessandro Zummo
+   Alexandre Belloni

2017-11-10 22:55 GMT+01:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> Dear all,
>
> This is an attempt to revive some patches from that [1] patchset, some
> of them are still under discussion but I think there is no reason to not
> have the other two in this fourth version to land upstream meanwhile we
> discuss about the others.
>
> [1] https://lkml.org/lkml/2017/7/12/182
>
> Changes since v3:
> * Rebased an retested with current mainline using a Samsung Chromebook Plus
> * Removed from patchset
>   * 1/4 mfd: cros_ec: Get rid of cros_ec_check_features from cros_ec_dev.
>   * 4/4 mfd: cros_ec: add RTC as mfd subdevice.
>
> Changes since v2:
> - Rebase on top of mainline.
> - Removed patch 'mfd: cros-ec: Fix host command buffer size' from series
> as was already picked.
>
> Changes since v1:
> - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
> calibbias data' from series as was already picked.
> - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
> calibbias data' from series as was already picked.
> - Patch 2/5: Acked-by: Jonathan Cameron <***@kernel.org>
>
> Best regards,
>
>  Enric
>
> Stephen Barber (2):
>   mfd: cros_ec: Introduce RTC commands and events definitions.
>   rtc: cros-ec: add cros-ec-rtc driver.
>
>  drivers/rtc/Kconfig                  |  10 +
>  drivers/rtc/Makefile                 |   1 +
>  drivers/rtc/rtc-cros-ec.c            | 413 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/cros_ec_commands.h |   8 +
>  4 files changed, 432 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cros-ec.c
>
> --
> 2.9.3
>

Sorry, I just noticed that my script to add the email recipients
failed and I did not add the RTC maintainers :( So this is a gentle
ping cc'ing the maintainers to take in consideration these patches. If
you want I resend or something else just let me know please.

Thanks,
 Enric

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
