Return-Path: <rtc-linux+bncBDE6RCFOWIARBXPQ2HAAKGQEJ4GE4PA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x235.google.com (mail-qk0-x235.google.com. [2607:f8b0:400d:c09::235])
        by gmr-mx.google.com with ESMTPS id p22si19988ywe.3.2016.10.29.03.22.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2016 03:22:21 -0700 (PDT)
Received: by mail-qk0-x235.google.com with SMTP id v138so23627580qka.0
        for <rtc-linux@googlegroups.com>; Sat, 29 Oct 2016 03:22:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
References: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 29 Oct 2016 12:22:20 +0200
Message-ID: <CACRpkdb39Gp4ErqcnxenicgKJ6aSHS0AdC5MzY1xgHzMToF-iA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] ABI: rtc-ab8500: fix rtc_calibration documentation
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mark Godfrey <mark.godfrey@stericsson.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Oct 29, 2016 at 12:10 PM, Mauro Carvalho Chehab
<mchehab@s-opensource.com> wrote:

> The "What:" field at the ABI should describe the location of
> the ABI, e. g. the position under a mounted sysfs.
>
> Fix it.
>
> Cc: Mark Godfrey <mark.godfrey@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
