Return-Path: <rtc-linux+bncBCU2BBWH4IORB3P437IQKGQEVTKLKLQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com. [2607:f8b0:4001:c06::22d])
        by gmr-mx.google.com with ESMTPS id v14si628303pfk.5.2017.12.18.09.44.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2017 09:44:12 -0800 (PST)
Received: by mail-io0-x22d.google.com with SMTP id f18so5603731ioh.1
        for <rtc-linux@googlegroups.com>; Mon, 18 Dec 2017 09:44:12 -0800 (PST)
Date: Mon, 18 Dec 2017 09:44:09 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v4 1/2] mfd: cros_ec: Introduce RTC commands
 and events definitions.
Message-ID: <20171218174409.GA114116@google.com>
References: <20171110215553.20696-2-enric.balletbo@collabora.com>
 <20171216045542.GA52366@google.com>
 <CAFqH_529DtNycxTauXHAzmGKBvYXWNxFM9ouEZRB+JTD2eSyHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <CAFqH_529DtNycxTauXHAzmGKBvYXWNxFM9ouEZRB+JTD2eSyHA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Dec 16, 2017 at 08:36:23AM +0100, Enric Balletbo Serra wrote:
>    Guess you missed the discussion in the cover letter of this patchset ;)
>    These patches has been accepted and merged soon for 4.16. Alexandre
>    will do it.

I wasn't copied on either the patches or the cover letter; I just found
them through patchwork, which does not catalog cover letters. I also
didn't see the patches in -next.

Anyway, good to hear.

Brian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
